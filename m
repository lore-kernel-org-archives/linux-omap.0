From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/4] mfd: DT bindings for TPS65218 PMIC
Date: Tue, 3 Dec 2013 11:04:22 +0000
Message-ID: <20131203110422.GO11828@lee--X1>
References: <1386053006-6480-1-git-send-email-j-keerthy@ti.com>
 <1386053006-6480-2-git-send-email-j-keerthy@ti.com>
 <20131203093637.GE11828@lee--X1>
 <529DB7E5.8040702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34010 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331Ab3LCLE3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Dec 2013 06:04:29 -0500
Received: by mail-ie0-f170.google.com with SMTP id qd12so23988111ieb.29
        for <linux-omap@vger.kernel.org>; Tue, 03 Dec 2013 03:04:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <529DB7E5.8040702@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, sameo@linux.intel.com, grant.likely@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

> >>+- interrupt-controller : Since the tps65218 support several interr=
upts
> >                                                support(s) (hosts?)
>=20
> Yes Supports multiple interrupts from the sub-modules.

I think 'support' should be the plural 'supports'.

<snip>

> >Why aren't you using 'regulator-compatible'?
>=20
> I referred tps65217.txt the predecessors and used the compatible.
> I also referred twl-regulator.txt.

That doesn't mean that they are correct/better. ;)

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
