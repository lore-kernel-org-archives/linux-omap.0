From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Omap3 -> AM37xx change cpu-frequency
Date: Mon, 20 Jun 2011 14:32:40 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D62590D@dbde02.ent.ti.com>
References: <BANLkTinahsY8wTRk8E=Fdows11rN_-CvuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47366 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464Ab1FTJCr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jun 2011 05:02:47 -0400
In-Reply-To: <BANLkTinahsY8wTRk8E=Fdows11rN_-CvuQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arno Steffen <arno.steffen@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Arno Steffen
> Sent: Monday, June 20, 2011 12:24 PM
> To: linux-omap@vger.kernel.org
> Subject: Omap3 -> AM37xx change cpu-frequency
> 
> Currently I am using 2.6.33 on an OMAP3. I would change from a 600MHz
> Omap35xx to a pincompatible 1GHz AM37xx. Where is to change the clock
> frequencies/dividers?
> Is it done in x-loader, uboot or in kernel itself (and if so where?).
> Are there other Software-issued to take care in this migration?
> Best regards

[sp] Are you looking for one time change to 1GHz OR would you be scaling
     the frequency run-time?

~sanjeev

> -Arno
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 