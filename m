From: "Basak, Partha" <p-basak2@ti.com>
Subject: RE: On the APIs for Enabling and Disabling Wakeup capability.
Date: Tue, 22 Jun 2010 15:59:12 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E76F4082@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E75F0BBF@dbde02.ent.ti.com>
	<87vd9isdxb.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94026FFCAA53@dbde02.ent.ti.com>
	<74583B8642AB8841B30447520659FCA901AA4908FF@dnce01.ent.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E940270056DEE@dbde02.ent.ti.com>
 <87ljacbd5u.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55833 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759204Ab0FVK3U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 06:29:20 -0400
In-Reply-To: <87ljacbd5u.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Kalliguddi, Hema" <hemahk@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Benoit/Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Friday, June 18, 2010 8:29 PM
> To: Kalliguddi, Hema
> Cc: Cousson, Benoit; Basak, Partha; paul@pwsan.com; Nayak, Rajendra;
> linux-omap@vger.kernel.org
> Subject: Re: On the APIs for Enabling and Disabling Wakeup capability.
> 
> "Kalliguddi, Hema" <hemahk@ti.com> writes:
> 
> > Hi Benoit,
> >
> > I have 2 cases in usb for the need of separate API for setting the auto
> idle bit.
> >
> > 1. Below the link for omap3430TRM. Please refer 24.1.5.4.2 and
> 24.1.5.4.3 there is note not to set smart
> > idle and autoidle bit simultaneously. Suggestion is to set the auto idle
> 0 before setting smart idle. Then set to 1.
> 
> Maybe this sequence should be enforced by the hwmod code itself,
> rather than the knowledge living in the driver.
> 
> However, based on the errata below, auto-idle will always be zero so
> the there should be no conflict in setting smart-idle and auto-idle
> simultaneously today.
> 
> > This applicable for omap4 as well.  I don't have the omap4430 pblic TRM
> to share.
> > http://focus.ti.com/pdfs/wtbu/SWPU223D_Final_EPDF_06_07_2010.pdf
> >
> > 2. There is a Errata in OMAP3 errata #1.59 that If auto idle is set then
> the USB can't  wakeup the system by
> > usb external events. The suggested workaround is to disable the autoIdle
> for omap3.
> 
> This one could be handled at init time in usb-musb.c by setting
> HWMOD_NO_OCP_AUTOIDLE for the hwmod with a comment summarizing this
> errata.
> 
> Note also that Errata 1.166 is another one related to MUSB auto-idle
> and we have a workaround in the PM branch to ensure that MUSB
> auto-idle is disabled in the idle path since it may be re-enabled
> after an off-mode transition.
> 
Few questions:
1. Are you mentioning about the following patch:
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=865f0e0b1dd25899fe30eee5c8f1dba420eea177?

Though this patch allows clearing of AutoIdle bit(signified by HWMOD_INIT_NO_IDLE) while remaining in Idle state, it does not allow the reverse, i.e. setting back the AutoIdle bit, while still remaining in Idle state. 

2. Changing the hwmod flags (oh->flags) is acceptable in run-time. Correct?

3. I believe, SysConfig settings have been a tricky area because of different h/w-errata. Instead of looking into particular errata, as and when they come in time to time and explore how to fit them in the framework, would it not be more useful to provide a more generic framework to operate on the SysConfig settings? Of course, as you suggested, the preferred approach would be to absorb the changes in the omap_device/hw-mod layer as much as possible. But unfortunately, that may not be sufficient in all situations.
 
Partha
> Kevin
> 
> >
> >>-----Original Message-----
> >>From: Cousson, Benoit
> >>Sent: Thursday, June 17, 2010 3:04 PM
> >>To: Kalliguddi, Hema; Kevin Hilman; Basak, Partha
> >>Cc: paul@pwsan.com; Nayak, Rajendra; linux-omap@vger.kernel.org
> >>Subject: RE: On the APIs for Enabling and Disabling Wakeup capability.
> >>
> >>Hi Hema,
> >>
> >>>From: linux-omap-owner@vger.kernel.org
> >>>
> >>>Kevin,
> >>>
> >>>There is no errata in the USB which needs the Enable/Disable
> >>>wakeup to be done
> >>>Seperately. If it can be handled with omap_devie_enable/idle
> >>>Apis it is sufficient.
> >>>
> >>>But there is a need of setting the Auto idle bit seperately as
> >>>for the USBOTG there is a need to set the Autoidle only after
> >>>configuring the smart idle. It is recommended in the TRM not
> >>>set the auto idle and smart idle together.
> >>>This I discussed with Partha he sent a mail to you.
> >>>
> >>>For setting autoidle there is an api at hwmod layer but not
> >>>yet omap device layer.
> >>>Is there a plan to add API at omap device layer for
> >>>enabling/disabling the autoidle?
> >>
> >>The whole issue with exposing all the low level stuff at driver level
> >>is that the hwmod abstraction become less and less useful.
> >>Drivers will start hacking with that for no good reason. And
> >>then we will start adding again some omap version specific
> >>hacks in the driver.
> >>
> >>Could you provide the full errata description of that USB_OTG
> >>issue? Or at least that TRM part you are talking about.
> >>
> >>Thanks,
> >>Benoit
> >>
> >>>Regards,
> >>>Hema
> >>>
> >>>
> >>>>
> >>Texas Instruments France SA, 821 Avenue Jack Kilby, 06270
> >>Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920
> >>
> >>-----Original Message-----
> >>
> >>>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> >>>>Sent: Thursday, June 17, 2010 5:56 AM
> >>>>To: Basak, Partha
> >>>>Cc: paul@pwsan.com; Kalliguddi, Hema; Nayak, Rajendra;
> >>>>linux-omap@vger.kernel.org
> >>>>Subject: Re: On the APIs for Enabling and Disabling Wakeup
> >>capability.
> >>>>
> >>>>"Basak, Partha" <p-basak2@ti.com> writes:
> >>>>
> >>>>> I wanted to close on the introduction of two new OMAP device APIs
> >>>>> omap_device_enable_wakeup () & omap_device_disable_wakeup() in
> >>>>> omap_device layer.
> >>>>>
> >>>>> These APIs are potentially needed by the USB driver (via function
> >>>>> pointers) to work around some USB erratum.
> >>>>>
> >>>>> Alternatively, can we call omap_hwmod_enable_wakeup() via function
> >>>>> pointer?  Is it agreeable to call these from driver code (via
> >>>>> function pointers)in some special cases such as to handle some
> >>>>> errata?
> >>>>
> >>>>Hi Partha,
> >>>>
> >>>>First, we need to dig up the Errata details for that USB problem to
> >>>>better understand the USB-specific issue.
> >>>>
> >>>>In addition, Paul and I discussed the option of
> >>automatically managing
> >>>>the wakeup during the hwmod enable/idle, since there isn't really a
> >>>>need to have the wakeup enabled when the hwmod is active.
> >>>>
> >>>>Do you see any disadvantages to that?  That would be much
> >>cleaner than
> >>>>manually managing the wakeup feature per-driver.
> >>>>
> >>>>Kevin
> >>>>--
> >>>To unsubscribe from this list: send the line "unsubscribe
> >>>linux-omap" in
> >>>the body of a message to majordomo@vger.kernel.org
> >>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>
