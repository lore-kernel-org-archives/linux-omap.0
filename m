From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v4 1/9] OMAP3: PM: Adding voltage driver support for OMAP3
Date: Mon, 15 Nov 2010 11:43:49 -0800
Message-ID: <87bp5qnzii.fsf@deeprootsystems.com>
References: <1288195856-11011-1-git-send-email-thara@ti.com>
	<1288195856-11011-2-git-send-email-thara@ti.com>
	<87hbfp9gli.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB035EFF4E51@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61486 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119Ab0KOTnx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 14:43:53 -0500
Received: by pzk28 with SMTP id 28so999409pzk.19
        for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 11:43:53 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB035EFF4E51@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Mon, 15 Nov 2010 16:11:47 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

>>>

[...]

>>>
>>>cpu_is_* checks are only acceptable at init time.  This one happens
>>>during every scale.  These VC settings should be set at init time only.
>>>
>>>Same issue with forceupdate_scale.
>
> These masks are needed only in vc bypass voltage scaling API. I was
> thinking that for using in just one API I need not maintain these
> variables in the generic vdd structure. But yes this will add a
> cpu_is_* check in this API.  Is it preferred to have these variables
> defined in the common vdd structures and populated during init even if
> used only in one API?

Yes.

[...]

>>>> +void omap_vp_enable(struct voltagedomain *voltdm)
>>>> +{
>>>> +   struct omap_vdd_info *vdd;
>>>> +   u32 vpconfig;
>>>> +
>>>> +   if (!voltdm || IS_ERR(voltdm)) {
>>>> +           pr_warning("%s: VDD specified does not exist!\n", __func__);
>>>> +           return;
>>>> +   }
>>>> +
>>>> +   vdd = container_of(voltdm, struct omap_vdd_info, voltdm);
>>>> +
>>>> +   /* If VP is already enabled, do nothing. Return */
>>>> +   if (voltage_read_reg(vdd->vp_offs.vpconfig) &
>>>> +                           vdd->vp_reg.vpconfig_vpenable)
>>>> +           return;
>>>
>>>Minor: is a register access here required?  Why not just keep an
>>>'vp_enabled' flag as part of the vdd struct?
>
> I do not want to have the complications of maintaining a flag and
> ensuring exclusivity. 

Whether you use a flag or a register access, the ability to ensure 
exclusivity does not change.

> But do you think having a register read here is bad? 

Yes.

s/bad/unnecessary/

> Latency cannot be much as it is a single register read. If you really
> think we should have a flag, I can change it.

The PRCM is on L4, so accesses to PRCM registers are all slow and should
be avoided if possible.  This is an easy case where a register access
can be prevented simply by caching.


Kevin
