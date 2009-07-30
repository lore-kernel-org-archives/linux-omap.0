From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 20/20] ASoC: Always syncronize audio transfers on frames
Date: Thu, 30 Jul 2009 21:57:48 +0300
Message-ID: <20090730215748.5ba9fd07.jhnikula@gmail.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-11-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-13-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-14-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-15-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-16-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-17-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-18-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-19-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-20-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-21-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:26505 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbZG3S4x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 14:56:53 -0400
In-Reply-To: <1248958183-15015-21-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>

On Thu, 30 Jul 2009 15:49:43 +0300
Eduardo Valentin <eduardo.valentin@nokia.com> wrote:

> @@ -321,8 +326,11 @@ static int omap_mcbsp_dai_set_dai_fmt(struct
> snd_soc_dai *cpu_dai, /* Generic McBSP register settings */
>  	regs->spcr2	|= XINTM(3) | FREE;
>  	regs->spcr1	|= RINTM(3);
> -	regs->rcr2	|= RFIG;
> -	regs->xcr2	|= XFIG;
> +	/* RFIG and XFIG are not defined in 34xx */
> +	if (!cpu_is_omap34xx()) {
> +		regs->rcr2	|= RFIG;
> +		regs->xcr2	|= XFIG;
> +	}

This is true. These bits are marked as reserved read only bits in 34xx.
I'm fine if you do change here in this patch but I can add immediate
acked-by if you want to post this as a separate change for 2.6.32
(setting them for 34xx is null-op at the moment AFAIK).

If you find generic fix for channel switching problem found also from
older OMAP's like 2420 then I give you a deep bow and acked-by for
2.6.31!

-- 
Jarkko
