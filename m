From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 1/2] Added board-3630.c file.
Date: Wed, 28 Oct 2009 22:45:10 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA36ED29@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940253EFDFA6@dbde02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E940253EFE2F7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33139 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012AbZJ1RPT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 13:15:19 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9SHFG17015793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 12:15:23 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9SHFG1N026615
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 22:45:16 +0530 (IST)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940253EFE2F7@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, "Pais, Allen" <allen.pais@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of G,
>Manjunath Kondaiah
>Sent: Monday, October 26, 2009 9:49 AM
>To: Pais, Allen; linux-omap@vger.kernel.org
>Subject: RE: [PATCH 1/2] Added board-3630.c file.
>
>
>> +static int __init omap_i2c_init(void)
>> +{
>> +	omap_register_i2c_bus(1, 2600, sdp3630_i2c_boardinfo,
>> +			ARRAY_SIZE(sdp3630_i2c_boardinfo));
>> +	omap_register_i2c_bus(2, 400, NULL, 0);
>> +	omap_register_i2c_bus(3, 400, NULL, 0);
>> +	return 0;
>> +}
>
>If sdp3630 board is using TWL5030/GAIA, then you need to reduce I2C speed.
>http://patchwork.kernel.org/patch/52760/

Very valid point.

>
>-Manjunath--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

