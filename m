From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH RESEND 1/4] ARM: OMAP2+: AM33XX: Add tps65910 device tree
 data
Date: Wed, 29 Aug 2012 09:31:31 +0100
Message-ID: <20120829083129.GB3439@gmail.com>
References: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
 <1342766789-28148-2-git-send-email-anilkumar@ti.com>
 <20120720095935.GQ4495@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9FA91E@DBDE01.ent.ti.com>
 <20120720113806.GW4495@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA01F1E@DBDE01.ent.ti.com>
 <20120723133400.GU4435@opensource.wolfsonmicro.com>
 <20120828112603.GC25786@gmail.com>
 <20120828172133.GH4534@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:36762 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab2H2Ibg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Aug 2012 04:31:36 -0400
Received: by eekc1 with SMTP id c1so101854eek.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Aug 2012 01:31:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120828172133.GH4534@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Aug 28, 2012 at 10:21:33AM -0700, Mark Brown wrote:
> On Tue, Aug 28, 2012 at 12:26:07PM +0100, Lee Jones wrote:
>=20
> > > > arch/arm/boot/dts/db8500.dtsi
>=20
> > > I'm not actually seeing anything terribly problematic here, thoug=
h the
> > > regulator-name properties should really be removed as they're fai=
rly
> > > useless and seem to be missing the point of having the property.
>=20
> > Just looking at this now.=20
>=20
> > The regulator-name property is used to populate constrains->name. A=
re
> > you sure you still want them all removed?
>=20
> Yes, of course.  There's no way that a generic .dtsi used for any
> possible board could come up with a sensible value.

So how should constrains->name be populated then? Would you prefer
regulator-names moved to the .dts file(s), or something else?

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
