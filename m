From: "Premi, Sanjeev" <premi@ti.com>
Subject: omap: pm: assumptions on TWL and SmartReflex.
Date: Wed, 23 Feb 2011 19:57:42 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BBE29B6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55286 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336Ab1BWO1r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 09:27:47 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1NERhmX025080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 08:27:46 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1NERgp6023304
	for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 19:57:43 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

While trying to suport TPS65023 with AM3517 processor, i realize
that much of the code has implicit assumption on usage of TWLx0y0
PMIC and Smartreflex.

Check the definition of omap_volt_pmic_info and omap_volt_data.

Just to "hack" support we can fill *don't care* values for the
fields not supported and wrap processing under if (cpu_is_....())
checks; but this doesn't appear to be a good solution.

Also, the PMIC specific code doesn't really belong to mach-omap2.
OR was there a specific reason to keep it here??

Looking for thoughts, comments, explanations, ...

Best regards,
Sanjeev
