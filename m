From: Suman Anna <s-anna@ti.com>
Subject: Re: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Mon, 15 Jul 2013 14:23:52 -0500
Message-ID: <51E44C48.3090905@ti.com>
References: <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com> <20130708112553.GU5523@atomide.com> <51DAB394.3050104@ti.com> <20130708131033.GA5523@atomide.com> <51DABC81.3080409@ti.com> <20130708133512.GD31221@arwen.pp.htv.fi> <87mwpuakod.fsf@linaro.org> <20130710142633.GV5523@atomide.com> <20130710160704.GH18966@arwen.pp.htv.fi> <20130710161158.GA19716@arwen.pp.htv.fi> <20130711063209.GZ5523@atomide.com> <51DE8215.5060306@ti.com> <51DF508F.3050703@ti.com> <51E39A3F.6080106@ti.com> <51E3C85D.2010008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59458 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753716Ab3GOTaI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Jul 2013 15:30:08 -0400
In-Reply-To: <51E3C85D.2010008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@linaro.org>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Sourav Poddar <sourav.poddar@ti.com>, Paul Walmsley <paul@pwsan.com>

On 07/15/2013 05:01 AM, Rajendra Nayak wrote:
> On Monday 15 July 2013 12:14 PM, Rajendra Nayak wrote:
>> On Friday 12 July 2013 06:10 AM, Suman Anna wrote:
>>> On 07/11/2013 04:59 AM, Grygorii Strashko wrote:
>>>> Hi,
>>>>
>>>> On 07/11/2013 09:32 AM, Tony Lindgren wrote:
>>>>> * Felipe Balbi <balbi@ti.com> [130710 09:18]:
>>>>>>
>>>>>> On Wed, Jul 10, 2013 at 07:07:04PM +0300, Felipe Balbi wrote:
>>>>>>> how about something like below ? It makes omap_device/hwmod and
>>>>>>> pm_runtime agree on the initial state of the device and will prevent
>>>>>>> ->runtime_resume() from being called on first pm_runtime_get*() done
>>>>>>> during probe.
>>>>>>>
>>>>>>> This is similar to what PCI bus does (if you look at pci_pm_init()).
>>>>>>>
>>>>>>> commit 59108a500b4ab4b1a5102648a3360276dbf7df6f
>>>>>>> Author: Felipe Balbi <balbi@ti.com>
>>>>>>> Date:   Wed Jul 10 18:50:16 2013 +0300
>>>>>>>
>>>>>>>      arm: omap2plus: unidle devices which are about to probe
>>>>>>>
>>>>>>>      in order to make HWMOD and pm_runtime agree on the
>>>>>>>      initial state of the device, we will unidle the device
>>>>>>>      and call pm_runtime_set_active() to tell pm_runtime
>>>>>>>      that the device is really active.
>>>> Don't think that it's good idea (
>>>> I've checked some driver's and think this patch will enable some devices
>>>> unpredictably:
>>>> - hwspinlock
>>>> - mailbox
>>>> - iommu
>>>> - ipu
>>>> All above devices need to be enabled on demand only (no
>>>> pm_runtime_get*() calls in probe). More over, some of them have very
>>>> specific enabling sequence - like ipu).
>>>>
>>>> May be Summan can say more on that.
>>>
>>> Indeed, this is a problem for any of the slave processor devices.
>>> mailbox and iommu would be slaves to the remoteproc and the drivers have
>>> a specific sequence of bringing up a processor. The current
>>> hwmod/omap_device code is such that these devices will be left in reset
>>> and the driver code use the omap_device_(de)assert_hardreset API
>>> together with omap_device_enable code to bring up the devices. The
>>> remoteproc driver also needs to assert the resets (there are other
>>> problems associated with using omap_device_idle for remoteproc and
>>> iommu) for bringing up the devices after a suspend sequence. hwspinlock
>>> and mailbox may get away since they are in CORE domain, but definitely
>>> an issue for iommu and remoteproc. I would think that this would also
>>> affect other compute devices like IVAHD, ISS, SGX.
>>
>> Today, for these IPs I guess hwmod waits for the resets to be de-asserted, right?

Yes, the omap_device_enable bails out if the reset lines are still
asserted, and the driver code deals with the resets currently. This code
essentially achieves the same as if a HWMOD_INIT_NO_RESET flag is
added to the corresponding hwmods - we do not want the hwmod/omap_device
code to enable the processor IPs and leave the enabling/device
management to the driver.

>>
>>         /*
>>          * If an IP block contains HW reset lines and all of them are
>>          * asserted, we let integration code associated with that
>>          * block handle the enable.  We've received very little
>>          * information on what those driver authors need, and until
>>          * detailed information is provided and the driver code is
>>          * posted to the public lists, this is probably the best we
>>          * can do.
>>          */
>>         if (_are_all_hardreset_lines_asserted(oh))
>>                 return 0;
>>
>> What if this information is send back to omap_device() through a return value
>> so omap_device() knows about this too, so it avoids marking the omap device as
>> enabled? Wouldn't that fix the issue?
> 
> I meant something like this..
> 
> From 2fbea0dde0f72897089ef2e8e441b5e5bd6ea967 Mon Sep 17 00:00:00 2001
> From: Rajendra Nayak <rnayak@ti.com>
> Date: Mon, 15 Jul 2013 15:23:07 +0530
> Subject: [PATCH] ARM: OMAP2+: Make omap_device aware of hwmod failing to
>  enable/idle/shutdown the hwmods
> 
> For IP blocks (mainly processors) which have hard reset lines, hwmod avoids
> enable/idle/shutdown operations as long as all the hard reset lines are
> kept asserted. However it does not return an error back to the caller (in some
> cases the omap_device layer) to communicate back the failure to operate on the
> hwmod.
> 
> Fix this by making _enable()/_idle()/_shutdown() all return an error in such
> cases, and also fix the omap_device layer to look at the return values coming
> from hwmod operations before doing a omap_device level state transition.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Let me test this and get back to you if there are any issues.

regards
Suman

