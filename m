From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: On the APIs for Enabling and Disabling Wakeup capability.
Date: Wed, 23 Jun 2010 13:31:09 -0700
Message-ID: <87sk4dqynm.fsf@deeprootsystems.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E75F0BBF@dbde02.ent.ti.com>
	<87vd9isdxb.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94026FFCAA53@dbde02.ent.ti.com>
	<74583B8642AB8841B30447520659FCA901AA4908FF@dnce01.ent.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E940270056DEE@dbde02.ent.ti.com>
	<87ljacbd5u.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E76F4082@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:59016 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab0FWUbM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 16:31:12 -0400
Received: by pxi7 with SMTP id 7so424612pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Jun 2010 13:31:12 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E76F4082@dbde02.ent.ti.com>
	(Partha Basak's message of "Tue, 22 Jun 2010 15:59:12 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Basak, Partha" <p-basak2@ti.com>
Cc: "Kalliguddi, Hema" <hemahk@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Basak, Partha" <p-basak2@ti.com> writes:

> Benoit/Kevin,
>
>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> Sent: Friday, June 18, 2010 8:29 PM
>> To: Kalliguddi, Hema
>> Cc: Cousson, Benoit; Basak, Partha; paul@pwsan.com; Nayak, Rajendra;
>> linux-omap@vger.kernel.org
>> Subject: Re: On the APIs for Enabling and Disabling Wakeup capability.
>> 
>> "Kalliguddi, Hema" <hemahk@ti.com> writes:
>> 
>> > Hi Benoit,
>> >
>> > I have 2 cases in usb for the need of separate API for setting the auto
>> idle bit.
>> >
>> > 1. Below the link for omap3430TRM. Please refer 24.1.5.4.2 and
>> 24.1.5.4.3 there is note not to set smart
>> > idle and autoidle bit simultaneously. Suggestion is to set the auto idle
>> 0 before setting smart idle. Then set to 1.
>> 
>> Maybe this sequence should be enforced by the hwmod code itself,
>> rather than the knowledge living in the driver.
>> 
>> However, based on the errata below, auto-idle will always be zero so
>> the there should be no conflict in setting smart-idle and auto-idle
>> simultaneously today.
>> 
>> > This applicable for omap4 as well.  I don't have the omap4430 pblic TRM
>> to share.
>> > http://focus.ti.com/pdfs/wtbu/SWPU223D_Final_EPDF_06_07_2010.pdf
>> >
>> > 2. There is a Errata in OMAP3 errata #1.59 that If auto idle is set then
>> the USB can't  wakeup the system by
>> > usb external events. The suggested workaround is to disable the autoIdle
>> for omap3.
>> 
>> This one could be handled at init time in usb-musb.c by setting
>> HWMOD_NO_OCP_AUTOIDLE for the hwmod with a comment summarizing this
>> errata.
>> 
>> Note also that Errata 1.166 is another one related to MUSB auto-idle
>> and we have a workaround in the PM branch to ensure that MUSB
>> auto-idle is disabled in the idle path since it may be re-enabled
>> after an off-mode transition.
>> 
> Few questions:
> 1. Are you mentioning about the following patch:
> http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=865f0e0b1dd25899fe30eee5c8f1dba420eea177?

No, this is a totally unrelated problem related to a specific init
sequene.

> Though this patch allows clearing of AutoIdle bit(signified by
> HWMOD_INIT_NO_IDLE) while remaining in Idle state, it does not allow
> the reverse, i.e. setting back the AutoIdle bit, while still remaining
> in Idle state.

The use-case for setting the auto-idle bit while leaving the device in
idle have not been described.

> 2. Changing the hwmod flags (oh->flags) is acceptable in run-time. Correct?

For errata workarounds, in device/SoC init code yes.  In drivers, no.
Drivers should not have any knowledge of hwmod internals.

> 3. I believe, SysConfig settings have been a tricky area because of
> different h/w-errata. Instead of looking into particular errata, as
> and when they come in time to time and explore how to fit them in the
> framework, would it not be more useful to provide a more generic
> framework to operate on the SysConfig settings? Of course, as you
> suggested, the preferred approach would be to absorb the changes in
> the omap_device/hw-mod layer as much as possible. But unfortunately,
> that may not be sufficient in all situations.

For this kind of thing, I strongly prefer to better understand the
specific errata that require the special settings.

History suggests that having an API to modify sysconfig means it would
get used not just for errata workarounds but also because "it doesn't
work unless I do this."   We *really* need to better understand the
reasons behind these special cases.

Kevin
