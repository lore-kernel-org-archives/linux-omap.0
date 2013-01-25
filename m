From: kishon <kishon@ti.com>
Subject: Re: [PATCH v3 1/4] drivers: usb: phy: add a new driver for usb part
 of control module
Date: Fri, 25 Jan 2013 14:12:41 +0530
Message-ID: <51024581.6020301@ti.com>
References: <1359080391-5120-1-git-send-email-kishon@ti.com> <1359080391-5120-2-git-send-email-kishon@ti.com> <510218FE.8080606@wwwdotorg.org> <20130125074818.GF15886@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130125074818.GF15886@arwen.pp.htv.fi>
Sender: linux-doc-owner@vger.kernel.org
To: balbi@ti.com
Cc: Stephen Warren <swarren@wwwdotorg.org>, rob.herring@calxeda.com, rob@landley.net, tony@atomide.com, b-cousson@ti.com, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, gregkh@linuxfoundation.org, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On Friday 25 January 2013 01:18 PM, Felipe Balbi wrote:
> On Thu, Jan 24, 2013 at 09:32:46PM -0800, Stephen Warren wrote:
>> On 01/24/2013 06:19 PM, Kishon Vijay Abraham I wrote:
>>> Added a new driver for the usb part of control module. This has an API
>>> to power on the USB2 phy and an API to write to the mailbox depending on
>>> whether MUSB has to act in host mode or in device mode.
>>>
>>> Writing to control module registers for doing the above task which was
>>> previously done in omap glue and in omap-usb2 phy will be removed.
>>
>>> diff --git a/Documentation/devicetree/bindings/usb/usb-phy.txt b/Documentation/devicetree/bindings/usb/usb-phy.txt
>>
>> This file seems to be specific to the TI USB PHYs, not all USB PHYs;
>> shouldn't it be renamed ti-usb-phy.txt, or even better renamed to match
>> the compatible value it documents, giving ti,omap-usb2.txt?
>
> could be, but that can be done as a separate patch. It's not part of
> $SUBJECT.
>
>>>   add the address of control module dev conf register until a driver for
>>>   control module is added
>>>
>>> +Optional properties:
>>> + - ctrl_module : phandle of the control module used by PHY driver to power on
>>> +   the PHY.
>>
>> DT property names generally use - not _ as the word separator.
>
> fair enough, Kishon, can you fix this up ?

Sure. Will post a patch..

Thanks
Kishon
