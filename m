From: =?UTF-8?B?IkFuZHkgR3JlZW4gKOael+WuieW7uCki?= <andy@warmcat.com>
Subject: Re: [try#1 PATCH 5/7] omap4: panda: add smsc95xx regulator and reset
 dependent on root hub
Date: Fri, 30 Nov 2012 15:38:35 +0800
Message-ID: <50B8627B.20102@warmcat.com>
References: <Pine.LNX.4.44L0.1211291247130.1535-100000@iolanthe.rowland.org> <50B7CC8B.5050802@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:57537 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab2K3H5A (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Nov 2012 02:57:00 -0500
In-Reply-To: <50B7CC8B.5050802@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, keshava_mgowda@ti.com, balbi@ti.com

On 11/30/2012 04:58 AM, the mail apparently from Andy Green included:
> On 11/30/2012 01:57 AM, the mail apparently from Alan Stern included:
>> On Thu, 29 Nov 2012, Andy Green wrote:
>>
>>> However I think what you're saying about binding to hub power is good.
>>> The hub ports are not devices, but it would be possible to bind an asset
>>> array to them and make the pre- and post- code functions.
>>
>> In the 3.6 kernel, hub ports are not devices.  In 3.7 they are -- that
>> is, each hub port has its own struct device.
>
> Right, I should have seen this in hub.c before.  It's much better like
> that.
>
>>> I think it will be possible to address objections around the "pathiness"
>>> by being able to seed the path match with a platform_device pointer
>>> (there exists in the board file time a platform_device for ehci-omap.0
>>> ...) and just matching the remainder on a single usb device's name, like
>>> "*-1.1-1".
>>
>> Can you think of a way to do this without checking for a match every
>> time a new device is registered?  For instance, in this case it would
>> be preferable to do this match only for descendants of ehci-omap.0.  To
>> match the port device, the string would have to be something like
>> "*-0:1.0/port2".
>
> Yes.  How about adding a third callback to struct device_asset, along
> the lines of
>
>      int (*pre_child_register)(struct device *child);
>
> then, in register_device() we add code that before we get down to it, we
> walk up the new device's parents calling ->pre_child_register() on any
> assets the parents may have.  In the typical case that's a rapid NOP
> once per device registration.
>
> However... if we had arranged back at boot time that the ehci-omap.0
> struct device had an asset with only pre_device_register callback set,
> we can use that asset's .name for the right-justified child device name
> we are looking for like "-0:1.0/port2", and its .asset member to point
> to another asset table the pre_child_register callback will attach to
> the child device if the name matches.  So in the board file:
>
>      struct device_asset ehci_omap0_smsc_hub_port_assets[] = {
>          /* the smsc regulator and clock assets destined for the hub
> port */
>          { }
>      };
>
>      /* below is attached to ehci-omap.0 like in try#1 */
>
>      struct device_asset ehci_omap0_assets[] = {
>          {
>              .name = "-0:1.0/port2",
>              .asset = ehci_omap0_smsc_hub_port_assets,
>              .pre_child_register = device_asset_attach_to_child,
>          },
>          { }
>      };
>
> In that way we can project as many stashed asset tables on to
> dynamically probed devices as we like from the platform_devices at boot
> time.  Only children of the right platform devices do any checking or
> processing.
>
>> In fact, if the match were anchored at the end of the string, we
>> wouldn't need the wildcard at all -- at least, not in this case.  The
>> string could simply be "-0:1.0/port2".  But that's only if the match is
>> restricted to devices below ehci-omap.0.
>
> It's a good idea, it won't get fooled by a hub getting plugged there
> which has its own port2 either, the -0:1.0 bit will have been elaborated
> for the subsequent hub "path" and won't match.
>
>
> It may be neater to split out the device_asset callbacks to an ..._ops
> struct.
>
>      struct device_asset_ops {
>          int (*pre_probe)(struct device *device, struct device_asset
> *asset);
>          void (*post_remove)(struct device *device, struct device_asset
> *asset);
>          int (*pre_child_register)(struct device *child);
>      };
>
>      struct device_asset {
>          ...
>          struct device_asset_ops *ops;
>      };
>
> that also lets us export and set one thing to select say regulator
> "handler", instead of n callbacks that must match.

I have everything discussed above ready for a try#2, including the 
descendant matching stuff in separate patches.  The code got a lot 
smaller and better with the _ops struct.

The new code can attach the assets to the targeted hub port as discussed 
(using only "-0:1.0/port1" and only checking ehci-omap.0 descendants at 
device_add() time), but the hub port device never probes, unless I 
missed the point it's because it actually never binds to a driver, it's 
a very unusual standalone logical device.

If that's the case I could work around that by doing the probe() asset 
stuff at device_add() time if there's no driver name on the device, but 
actually I am not sure that's where we wanted to end up.

Now we got so far as to succeed to associate regulator + clock assets to 
the logical hub port device, isn't it that we want the assets to be 
enabled and disabled according to hub port power state?  In that case it 
needs to go in the direction of calling device_asset helpers in the 
hub.c code that handles enable and disable hub port power.  Is this 
sounding like the right way, or something else?

-Andy

> Something else I think mux would be a great target for device_asset
> support.  That way it could become normal for mux function to get set as
> part of the specific device instantiation, so if you know you have an
> 8-bit ULPI PHY that will be logically created by the platform_device,
> you can attach ULPI-mode mux config appropriate for your exact SoC as an
> asset to the platform_device.
>
> When the device is destroyed, balls can go back to safe mode and save
> power, and if the balls are muxed with other things again the right mux
> asset can be associated with that so it switches automagically according
> to what you are doing.  That's a lot better than forcing them once at
> boot which is the current method.  Are there any gotchas with that?
>
> -Andy
>

