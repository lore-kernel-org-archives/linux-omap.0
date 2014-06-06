From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/9] mfd: tps65917: Add support for for TPS65917 PMIC
Date: Fri, 6 Jun 2014 13:43:28 +0100
Message-ID: <20140606124328.GR24240@lee--X1>
References: <1401272423-25761-1-git-send-email-j-keerthy@ti.com>
 <53919EF7.2000904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:57918 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbaFFMnf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2014 08:43:35 -0400
Received: by mail-ie0-f181.google.com with SMTP id rp18so2304120iec.26
        for <linux-omap@vger.kernel.org>; Fri, 06 Jun 2014 05:43:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53919EF7.2000904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com

> Hi Mark/Lee Jones,
>=20
> On Wednesday 28 May 2014 03:50 PM, Keerthy wrote:
> >The TPS65917 chip is a power management IC for Portable Navigation S=
ystems
> >and Tablet Computing devices. It contains the following components:
> >
> >  - Regulators.
> >  - GPADC.
> >  - Over Temperature warning and Shut down.
> >
> >This patch series adds support for TPS65917 mfd device. At this time=
 only
> >the regulator functionality is made available.
> >
> >The closest drivers are PALMAS series drivers. Hence adapted palmas =
mfd
> >driver to support the tps65917 PMIC.
> >
> >The register set for SMPSs and LDOs are changed and the ramp delay s=
upport
> >is also changed. Bit-field defenitions are changed.
> >Hence added driver data structures for mfd and regulator drivers
> >for palmas and added support for tps65917.
> >
> >The patches are boot tested on DRA72-EVM.
> >The patches are boot tested on OMAP5-UEVM board.
>=20
> A gentle ping on this rework.

There's no point in pinging on any patch during the merge-window.

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
