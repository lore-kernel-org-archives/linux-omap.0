From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/17] PM: fix suspend control for IVA2
Date: Tue, 20 Oct 2009 09:10:41 -0700
Message-ID: <87fx9enj0e.fsf@deeprootsystems.com>
References: <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
	<004e01ca4e84$5d0aa9f0$3d1018ac@am.dhcp.ti.com>
	<1F18D6510CF0474A8C9500565A7E41A210F69EEF6F@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f171.google.com ([209.85.216.171]:53892 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbZJTQKi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 12:10:38 -0400
Received: by pxi1 with SMTP id 1so1490541pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 09:10:43 -0700 (PDT)
In-Reply-To: <1F18D6510CF0474A8C9500565A7E41A210F69EEF6F@NOK-EUMSG-02.mgdnok.nokia.com> (Tero Kristo's message of "Mon\, 19 Oct 2009 11\:22\:49 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com
Cc: girishsg@ti.com, linux-omap@vger.kernel.org

<Tero.Kristo@nokia.com> writes:

>>-----Original Message-----
>>From: ext Girish S G [mailto:girishsg@ti.com] 
>>Sent: 16 October, 2009 20:16
>>To: Kristo Tero (Nokia-D/Tampere); linux-omap@vger.kernel.org
>>Subject: RE: [PATCH 01/17] PM: fix suspend control for IVA2
>>
>>
>>
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org 
>>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tero
>>> Kristo
>>> 
>>> From: Tero Kristo <tero.kristo@nokia.com>
>>> 
>>> IVA2 controls its target power state individually, thus 
>>suspend should not
>>> touch IVA2. Without this patch DSP suspend always fails.
>>> 
>>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>>> Acked-by: Ameya Palande <ameya.palande@nokia.com>
>>> ---
>>>  arch/arm/mach-omap2/pm34xx.c |    9 ++++++++-
>>>  1 files changed, 8 insertions(+), 1 deletions(-)
>>> 
>>>  static struct prm_setup_vc prm_setup = {
>>>  	.clksetup = 0xff,
>>> @@ -676,6 +676,12 @@ static int omap3_pm_suspend(void)
>>>  		pwrst->saved_state = 
>>pwrdm_read_next_pwrst(pwrst->pwrdm);
>>>  	/* Set ones wanted by suspend */
>>>  	list_for_each_entry(pwrst, &pwrst_list, node) {
>>> +		/* Special handling for IVA2, just use current 
>>sleep state */
>>> +		if (pwrst->pwrdm == iva2_pwrdm) {
>>> +			state = pwrdm_read_pwrst(pwrst->pwrdm);
>>> +			if (state < PWRDM_POWER_ON)
>>> +				pwrst->next_state = state;
>>> +		}
>>
>>Agree, IVA2 pwrdm is handled autonomously by bridge. I think 
>>this needs some additional change to remove all the redundant
>>configuration of iva pwdm. There are some inconsistencies like, 
>>	- Say enable_off_mode is disabled. Before doing system 
>>wide suspend if DSP hibernates then IVA2 will be put to OFF. In that
>>case we have IVA2 going to OFF and other domains in RET. This 
>>might not be an issue, but it's bad from sytem PM framework integrity
>>perspective.
>
> This is an issue with bridge driver, and I am not sure how this should be fixed. Currently bridge driver does not care whether off mode is enabled or not.
>
>>	- enable_off_mode->omap3_pm_off_mode_enable will also 
>>touch IVA2 power domain next state. This we don't want to do if dsp
>>bridge is already taking care of IVA2.
>>
>>IMO, we need to have some mechanism wherein if bridge PM takes 
>>care of IVA then PM framework should not configure the IVA
>>powerstate. It should only do if bridge PM is disabled.
>
> Should we have a Kconfig option for this? Like CONFIG_OMAP3_BRIDGE_PM, and disable all iva2 controls from pm34xx.c if it is enabled? Otherwise control IVA2 as currently done.
>

Rather than Kconfig, this should be run-time.

There should be some sort of flag for indpendent IVA2 control and a
register function that bridge (or any other DSP controller) could
register for and take over control of IVA2.

This way, if no bridge is loaded, IVA2 can still properly be suspended.

Kevin

