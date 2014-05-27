From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/5] regulator: tps65917: Add Regulator driver for
 tps65917 PMIC
Date: Tue, 27 May 2014 09:30:12 +0100
Message-ID: <20140527083012.GA5875@lee--X1>
References: <1401098197-647-1-git-send-email-j-keerthy@ti.com>
 <1401098197-647-6-git-send-email-j-keerthy@ti.com>
 <20140526150052.GP22111@sirena.org.uk>
 <538404F2.9000505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35714 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbaE0IaS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 May 2014 04:30:18 -0400
Received: by mail-ie0-f176.google.com with SMTP id rl12so8459474iec.21
        for <linux-omap@vger.kernel.org>; Tue, 27 May 2014 01:30:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <538404F2.9000505@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, sameo@linux.intel.com

> >>This patch adds support for TPS65917 PMIC regulators.
> >>
> >>The regulators set consists of 5 SMPSs and 5 LDOs. The output
> >>voltages are configurable and are meant to supply power to the
> >>main processor and other components.
> >This appears to look *very* like the Palmas driver, should it not be
> >sharing code with that?  If it were just data tables it'd be less of=
 a
> >concern but there's quite a bit of actual code here.
> Yes it is. The difference is in the entire register space of the regu=
lators
> between the two. There are other differences in how the ramp delay
> is configured and SMPS ordering. The difference is also a bit in the
> programming
> sequence. I agree that largely it is Palmas based. I did not want to
> add more
> checks in the probe of the palmas driver. Hence came up with a new on=
e.
>=20
> Coming to sharing the code, can we have 2 drivers which share the com=
mon
> functions with separate data and specific functions?

Yes, that is what the match functionality is for.  Once you know which
driver you're dealing with, you can call specific initialisation
functions and/or supplement generic generic data structures with device
specific ones.

> I just simply do not want to add anything more to the palmas driver
> probe function.

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
