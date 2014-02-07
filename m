From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/4] MFD: TPS65218: Add driver for the TPS65218 PMIC
Date: Fri, 7 Feb 2014 11:12:29 +0000
Message-ID: <20140207111229.GN14727@lee--X1>
References: <1391665814-18814-1-git-send-email-j-keerthy@ti.com>
 <1391665814-18814-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:56037 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbaBGLMi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Feb 2014 06:12:38 -0500
Received: by mail-wi0-f182.google.com with SMTP id f8so718027wiw.15
        for <linux-omap@vger.kernel.org>; Fri, 07 Feb 2014 03:12:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1391665814-18814-3-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, sameo@linux.intel.com, grant.likely@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Thu, 06 Feb 2014, Keerthy wrote:

> The TPS65218 chip is a power management IC for Portable Navigation Sy=
stems
> and Tablet Computing devices. It contains the following components:
>=20
>  - Regulators.
>  - Over Temperature warning and Shut down.
>=20
> This patch adds support for tps65218 mfd device. At this time only
> the regulator functionality is made available.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/mfd/Kconfig          |   15 +++
>  drivers/mfd/Makefile         |    1 +
>  drivers/mfd/tps65218.c       |  281 ++++++++++++++++++++++++++++++++=
+++++++++
>  include/linux/mfd/tps65218.h |  284 ++++++++++++++++++++++++++++++++=
++++++++++
>  4 files changed, 581 insertions(+)
>  create mode 100644 drivers/mfd/tps65218.c
>  create mode 100644 include/linux/mfd/tps65218.h

Applied, thanks.

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
