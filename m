From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 7/9] regulator: palmas: Add palmas_pmic_driver_data
 structure
Date: Wed, 18 Jun 2014 08:24:36 +0100
Message-ID: <20140618072436.GA21030@lee--X1>
References: <1401272423-25761-1-git-send-email-j-keerthy@ti.com>
 <1401272423-25761-8-git-send-email-j-keerthy@ti.com>
 <20140617163721.GR29841@lee--X1>
 <53A11D40.7020201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:52740 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbaFRHYm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jun 2014 03:24:42 -0400
Received: by mail-ie0-f179.google.com with SMTP id tr6so381167ieb.38
        for <linux-omap@vger.kernel.org>; Wed, 18 Jun 2014 00:24:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53A11D40.7020201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com

> >>Add palmas_pmic_driver_data structure.
> >>
> >>Signed-off-by: Keerthy <j-keerthy@ti.com>
> >>---
> >>  include/linux/mfd/palmas.h |   25 +++++++++++++++++++++++++
> >>  1 file changed, 25 insertions(+)
> >>
> >>diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.=
h
> >>index 8d68452..70f0695 100644
> >>--- a/include/linux/mfd/palmas.h
> >>+++ b/include/linux/mfd/palmas.h
[...]

> >>+struct palmas_pmic_driver_data {
> >>+	int smps_start;
> >>+	int smps_end;
> >>+	int ldo_begin;
> >>+	int ldo_end;
> >>+	int max_reg;
> >>+	struct regs_info *palmas_regs_info;
> >>+	struct of_regulator_match *palmas_matches;
> >>+	struct palmas_sleep_requestor_info *sleep_req_info;
> >>+	int (*smps_register)(struct palmas_pmic *pmic,
> >>+			     struct palmas_pmic_driver_data *ddata,
> >>+			     struct palmas_pmic_platform_data *pdata,
> >>+			     const char *pdev_name,
> >>+			     struct regulator_config config);
> >>+	int (*ldo_register)(struct palmas_pmic *pmic,
> >>+			    struct palmas_pmic_driver_data *ddata,
> >>+			    struct palmas_pmic_platform_data *pdata,
> >>+			    const char *pdev_name,
> >>+			    struct regulator_config config);
> >Are you sure you need to store all of this stuff?
> >
> >Particularly the match pointer.  Do you really re-use it?
>=20
> Match pointer is used extensively in the palmas_regulator.c.
> This structure is very much used by regulator driver.

On closer inspection, I now see that it's a 'of_regulator_match',
rather than an 'of_match' pointer, which were my initial thoughts.  I
think it would have been weird to carry the 'of_match', but the
reality sounds sane.

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
