From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH 1/2] Added board-3630.c file.
Date: Mon, 26 Oct 2009 20:18:35 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940253EFE2F7@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940253EFDFA6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42119 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbZJZOsf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 10:48:35 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9QEmbGR002143
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 09:48:39 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9QEmaCK026361
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 20:18:36 +0530 (IST)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940253EFDFA6@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pais, Allen" <allen.pais@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> +static int __init omap_i2c_init(void)
> +{
> +	omap_register_i2c_bus(1, 2600, sdp3630_i2c_boardinfo,
> +			ARRAY_SIZE(sdp3630_i2c_boardinfo));
> +	omap_register_i2c_bus(2, 400, NULL, 0);
> +	omap_register_i2c_bus(3, 400, NULL, 0);
> +	return 0;
> +}

If sdp3630 board is using TWL5030/GAIA, then you need to reduce I2C speed.
http://patchwork.kernel.org/patch/52760/

-Manjunath