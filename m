From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: NAND erase failures on overo
Date: Sat, 11 Sep 2010 13:13:48 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0315F0281F@dbde02.ent.ti.com>
References: <AANLkTi=JiyPeyi11cvqNZDn1JWBEPJupmu1i5DZ+=q+f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35112 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752395Ab0IKHnz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Sep 2010 03:43:55 -0400
In-Reply-To: <AANLkTi=JiyPeyi11cvqNZDn1JWBEPJupmu1i5DZ+=q+f@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Cliff Brake
> Sent: Saturday, September 11, 2010 3:22 AM
> To: Linux OMAP Users
> Subject: NAND erase failures on overo
> 
> With the current, linux-omap:master branch
> (8475b9e5077d9e9b4ba7a92afd4c5c7d65564c09), I get the following errors
> on a overo system when erasing flash:
> 
> root@ts3:~# flash_eraseall -j /dev/mtd4
> Erasing 128 Kibyte @ 8c40000 -- 56 % complete. Cleanmarker written at
> 8c20000.
> flash_eraseall: /dev/mtd4: MTD Erase failure: Input/output error
> Erasing 128 Kibyte @ 9440000 -- 59 % complete. Cleanmarker written at
> 9420000.
> flash_eraseall: /dev/mtd4: MTD Erase failure: Input/output error
> Erasing 128 Kibyte @ f980000 -- 100 % complete.Cleanmarker written at
> f960000.
[Ghorai] There are few bad blocks reported by NAND erase.

> 
> On the omap3530 TI EVM, with the same kernel, I don't see any of these
> errors.
> 
> I'm not sure if its related to something like this:
> 
> http://lists.infradead.org/pipermail/linux-mtd/2010-August/031563.html
> 
> Thanks,
> Cliff
> 
> --
> =================
> http://bec-systems.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
