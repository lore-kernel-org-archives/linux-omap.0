From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] arm: omap: Immutable branch between MFD and ARM OMAP
 due for the v3.16 merge-window
Date: Wed, 23 Apr 2014 13:41:18 -0700
Message-ID: <20140423204118.GA6053@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
 <1397173639-29587-11-git-send-email-tony@atomide.com>
 <20140417080051.GE28725@lee--X1>
 <20140417153722.GA23385@atomide.com>
 <20140423144644.GF6264@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:44653 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217AbaDWUlZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 16:41:25 -0400
Content-Disposition: inline
In-Reply-To: <20140423144644.GF6264@lee--X1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>

* Lee Jones <lee.jones@linaro.org> [140423 07:47]:
> Hi Tony,
>=20
> Sorry for the delay - I've been snowed under recently.
>=20
> As requested, you patch based on v3.14 ( for some reason :) ).

Thanks, I just got tired of chasing regressions with the
-rc cycle while trying to work on some PM changes :)

Regards,

Tony
=20
> The following changes since commit 455c6fdbd219161bd09b1165f11699d6d7=
3de11c:
>=20
>   Linux 3.14 (2014-03-30 20:40:15 -0700)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-m=
fd-omap-3.16
>=20
> for you to fetch changes up to a613b739b8c08eab811e677810045cc0522fc3=
e6:
>=20
>   mfd: twl-core: Fix idle mode signaling for omaps when booted with d=
evice tree (2014-04-23 15:31:05 +0100)
>=20
> ----------------------------------------------------------------
> Immutable branch between MFD and ARM OMAP due for v3.16 merge-window.
>=20
> ----------------------------------------------------------------
> Tony Lindgren (1):
>       mfd: twl-core: Fix idle mode signaling for omaps when booted wi=
th device tree
>=20
>  arch/arm/mach-omap2/omap_twl.c | 60 --------------------------------=
----------------------------
>  drivers/mfd/twl-core.c         | 15 +++++++++++++++
>  2 files changed, 15 insertions(+), 60 deletions(-)
>=20
> --=20
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
