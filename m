From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] mfd: twl-core: Fix passing of platform data in the
 device tree case
Date: Thu, 21 Nov 2013 10:46:54 +0000
Message-ID: <20131121104654.GA23067@lee--X1>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <1384562167-14725-2-git-send-email-tony@atomide.com>
 <20131118102907.GC13640@lee--X1>
 <20131118172510.GI16038@saruman.home>
 <20131118174638.GQ13640@lee--X1>
 <20131118181110.GM10317@atomide.com>
 <20131118190921.GT13640@lee--X1>
 <20131118192256.GU10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33259 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab3KUKrC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Nov 2013 05:47:02 -0500
Received: by mail-pd0-f173.google.com with SMTP id p10so3353505pdj.18
        for <linux-omap@vger.kernel.org>; Thu, 21 Nov 2013 02:47:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131118192256.GU10317@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

On Mon, 18 Nov 2013, Tony Lindgren wrote:

> * Lee Jones <lee.jones@linaro.org> [131118 11:10]:
> > > > Are you Acking this patch by the way?
> > >=20
> > > If this looks acceptable to you guys, I'd like to merge this via =
my fixes
> > > branch this week with your acks if that works for you. That way I=
 can base
> > > my omap legacy platform data removal patches on my fixes branch w=
hile keep
> > > things working for the drivers. Alternatively I can naturally bas=
e my
> > > legacy data removal on -rc2 too if this gets merged to mainline b=
y then=20
> > > via the MFD tree.
> >=20
> > I can either send it up for the -rcs, or I can create an immutable
> > branch for you to pull from. That way the patch can do in via ARM-S=
oC
> > and MFD and we can let Git sort it out.
>=20
> OK great, I'd prefer an immutable branch that I can merge in too. The=
n
> you can bundle it with other MFD fixes for the -rc series and send it
> in when it suits you :)

https://git.linaro.org/gitweb?p=3Dpeople/ljones/mfd.git;a=3Dshortlog;h=3D=
refs/heads/for-mfd-fixes

Here Tony, you can take this one.

I will simply apply my other fixes on top of it.

The issue is, I will most likely have to rebase it on top of -rc1 prior
to sending a request to Linus, so in that regard it's not exactly
immutable.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
