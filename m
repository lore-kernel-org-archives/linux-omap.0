From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 0/7] mfd: twl4030-power: Enable off-idle configuration
 when booted with device tree
Date: Wed, 28 May 2014 08:03:52 +0100
Message-ID: <20140528070352.GG4227@lee--X1>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
 <20140527165234.GF4227@lee--X1>
 <20140527171351.GA18063@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:64106 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302AbaE1HD5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2014 03:03:57 -0400
Received: by mail-ie0-f177.google.com with SMTP id y20so9844768ier.22
        for <linux-omap@vger.kernel.org>; Wed, 28 May 2014 00:03:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140527171351.GA18063@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

> > > Here's an updated set of patches to enable low-power idle modes
> > > for some omap3 boards when booted with device tree.
> > >=20
> > > This series when applied on top of the patches in tread          =
                                                                       =
                     =20
> > > "[PATCH 00/11] Fixes for omap PM for making omap3 DT only",
> > > or omap-for-v3.16/pm branch.
> > >=20
> > > Lee, if these patches look OK to you, please feel free to=20
> > > pick them, preferrably to the immutable branch you already
> > > have set up so I can also merge them in to be able to have
> > > things working in my branch properly for PM.
> >=20
> > Whoops, nearly forgot about this patchset.
> >=20
> > Tony, can you resend it with all your fix-ups please.  The 8< doesn=
't
> > work well with my patch application 'system'.
>=20
> Sure I'll do that. FYI, these kind of patches should apply just
> fine when piped to git-am --scissors.

It's not that - the patches would apply just fine individually.
However my mailer stores the patches in date order, so when I use `git
am <mbox-folder>` it attempts to apply them OoO.

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
