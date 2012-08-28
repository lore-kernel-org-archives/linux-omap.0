From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH RESEND 1/4] ARM: OMAP2+: AM33XX: Add tps65910 device tree
 data
Date: Tue, 28 Aug 2012 12:26:07 +0100
Message-ID: <20120828112603.GC25786@gmail.com>
References: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
 <1342766789-28148-2-git-send-email-anilkumar@ti.com>
 <20120720095935.GQ4495@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9FA91E@DBDE01.ent.ti.com>
 <20120720113806.GW4495@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA01F1E@DBDE01.ent.ti.com>
 <20120723133400.GU4435@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34160 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153Ab2H1L0L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Aug 2012 07:26:11 -0400
Received: by eaac11 with SMTP id c11so1504010eaa.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Aug 2012 04:26:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120723133400.GU4435@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Mark,

> > arch/arm/boot/dts/db8500.dtsi
>=20
> I'm not actually seeing anything terribly problematic here, though th=
e
> regulator-name properties should really be removed as they're fairly
> useless and seem to be missing the point of having the property.

Just looking at this now.=20

The regulator-name property is used to populate constrains->name. Are
you sure you still want them all removed?

Kind regards,
Lee

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
