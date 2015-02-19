From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Thu, 19 Feb 2015 23:10:55 +0200
Message-ID: <20150219211055.GB8558@fuloong-minipc.musicnaut.iki.fi>
References: <20131206213613.GA19648@earth.universe>
 <201502111339.54480@pali>
 <CAALWOA_ngoSKjB=ZQ264Va37bBK7v41Ei45SyoYLiMdanTKnxQ@mail.gmail.com>
 <201502191920.41284@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:43300 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbbBSVLD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2015 16:11:03 -0500
Content-Disposition: inline
In-Reply-To: <201502191920.41284@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@ring0.de>, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

On Thu, Feb 19, 2015 at 07:20:41PM +0100, Pali Roh=E1r wrote:
> Anyway, in Nokia Harmattan N9/N950 2.6.32 kernel is this patch:

> +/* Do we need runtime check ? */
> +#if __LINUX_ARM_ARCH__ < 6
>  	{ do_bad,		SIGBUS,	 0,		"external abort on linefetch"	   },
> +#else
> +	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"I-cache maintenance =
fault"	   },
> +#endif

> Maybe it is related?

That was unrelated. Also, the patch is also in mainline,
see 8c0b742ca7a7d21de0ddc87eda6ef0b282e4de18 (ARM: 6134/1: Handle
instruction cache maintenance fault properly).

A.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
