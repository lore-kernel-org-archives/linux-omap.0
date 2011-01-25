From: "Premi, Sanjeev" <premi@ti.com>
Subject: [query] smartreflex: No PMIC hook to init smartreflex
Date: Tue, 25 Jan 2011 20:55:51 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302485ADDFE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32999 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728Ab1AYPZ4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 10:25:56 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p0PFPrbA005057
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 09:25:55 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p0PFPqr4029782
	for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 20:55:52 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

While building the kernel at 2.6.37, i see this warning for omap3evm - with omap3630:

Power Management for TI OMAP3.
sr_init: No PMIC hook to init smartreflex <-- THIS IS THE WARNING.
smartreflex smartreflex.0: omap_sr_probe: SmartReflex driver initialized
smartreflex smartreflex.1: omap_sr_probe: SmartReflex driver initialized
SmartReflex Class3 initialized

In the code, i see this comment:
 /*
  * sr_init is a late init. If by then a pmic specific API is not
  * registered either there is no need for anything to be done on
  * the PMIC side or somebody has forgotten to register a PMIC
  * handler. Warn for the second condition.
  */
 if (sr_pmic_data && sr_pmic_data->sr_pmic_init)
  sr_pmic_data->sr_pmic_init();
 else
  pr_warning("%s: No PMIC hook to init smartreflex\n", __func__);

But, I couldn't find any place where PMIC is being registered.

premi # grep register_pmic *.c
omap_twl.c:     omap_voltage_register_pmic(voltdm, &omap4_mpu_volt_info);
omap_twl.c:     omap_voltage_register_pmic(voltdm, &omap4_iva_volt_info);
omap_twl.c:     omap_voltage_register_pmic(voltdm, &omap4_core_volt_info);
omap_twl.c:     omap_voltage_register_pmic(voltdm, &omap3_mpu_volt_info);
omap_twl.c:     omap_voltage_register_pmic(voltdm, &omap3_core_volt_info);
smartreflex.c: * omap_sr_register_pmic() - API to register pmic specific info.
smartreflex.c:void omap_sr_register_pmic(struct omap_sr_pmic_data *pmic_data)
voltage.c: * omap_voltage_register_pmic() - API to register PMIC specific data
voltage.c:int omap_voltage_register_pmic(struct voltagedomain *voltdm,

Where can I look for an example of registration?

~sanjeev
