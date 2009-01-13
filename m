From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 3/3] ASoC: Always syncronize audio transfers on frames
Date: Tue, 13 Jan 2009 10:16:41 +0200
Message-ID: <20090113101641.4d1c9a12.jarkko.nikula@nokia.com>
References: <12318331352537-git-send-email-ext-eero.nurkkala@nokia.com>
	<12318331373879-git-send-email-ext-eero.nurkkala@nokia.com>
	<12318331393997-git-send-email-ext-eero.nurkkala@nokia.com>
	<1231833140301-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34560 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbZAMIQ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 03:16:58 -0500
In-Reply-To: <1231833140301-git-send-email-ext-eero.nurkkala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext ext-eero.nurkkala@nokia.com" <ext-eero.nurkkala@nokia.com>
Cc: linux-omap@vger.kernel.org, "ext Lopez Cruz, Misael" <x0052729@ti.com>

On Tue, 13 Jan 2009 09:52:15 +0200
"ext ext-eero.nurkkala@nokia.com" <ext-eero.nurkkala@nokia.com> wrote:

> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> 
> All these steps are required for ASoC to behave correctly.
> This is, no RFIG or XFIG (Not defined in 34xx), correct
> initiliazation of rccr and xccr. They are format dependent,
> for example TDM audio has different values than I2S or
> DSP_A. Also the omap_mcbsp_xmit_enable and/or
> omap_mcbsp_recv_enable must be called right after the
> DMA has started. This provides no longer L and R channels
> switching at random.
> 
This needs to be separated. Misael have already patch for xccr and rccr
initialization in sound/soc/omap/omap-mcbsp.c and he's waiting first
patch to be integrated into mainline before posting into alsa-devel.

> @@ -293,19 +298,26 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
>  	/* Generic McBSP register settings */
>  	regs->spcr2	|= XINTM(3) | FREE;
>  	regs->spcr1	|= RINTM(3);
> -	regs->rcr2	|= RFIG;
> -	regs->xcr2	|= XFIG;
> +	/* RFIG and XFIG are not defined in 34xx */
> +	if (!cpu_is_omap34xx()) {
> +		regs->rcr2	|= RFIG;
> +		regs->xcr2	|= XFIG;
> +	}
This is true (checked now :-)) that RFIG and XFIG are not defined for
34xx (and 2430 as well!) but writing doesn't have any effect since the
bit is read only. But since it's marked reserved, then better to not
write it.

If you can generate patch against Torvald's tree, i.e. 2.6.29-rc1 and
send to alsa-devel, I can ack it.


Jarkko
