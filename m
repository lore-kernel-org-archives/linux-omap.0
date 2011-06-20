From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 5/8] OMAP4: DSS2: HDMI: Split the HDMI driver to DSS and
 IP
Date: Mon, 20 Jun 2011 19:18:19 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D625B1D@dbde02.ent.ti.com>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
 <1308298637-29753-2-git-send-email-mythripk@ti.com>
 <1308298637-29753-3-git-send-email-mythripk@ti.com>
 <1308298637-29753-4-git-send-email-mythripk@ti.com>
 <1308298637-29753-5-git-send-email-mythripk@ti.com>
 <1308298637-29753-6-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60646 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754343Ab1FTNs1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jun 2011 09:48:27 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5KDmOBr005664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 20 Jun 2011 08:48:26 -0500
In-Reply-To: <1308298637-29753-6-git-send-email-mythripk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of K, Mythri P
> Sent: Friday, June 17, 2011 1:47 PM
> To: linux-omap@vger.kernel.org; Valkeinen, Tomi
> Cc: K, Mythri P
> Subject: [PATCH 5/8] OMAP4: DSS2: HDMI: Split the HDMI driver 
> to DSS and IP
> 
> Splitting HDMI IP dependent IP configuring code from HDMI DSS 
> dependent code and
> moving to a new IP file.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/Makefile                   |    1 +
>  drivers/video/omap2/dss/hdmi.c                     |  751 
> -------------------
>  drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c          |  781 
> ++++++++++++++++++++
>  .../video/omap2/dss/{hdmi.h => hdmi_ti_4xxx_ip.h}  |    9 +-
>  include/video/hdmi_ti_4xxx_ip.h                    |   10 +

[sp] Is it okay to have 2 files by same name in two dirs?
     'include/video' and 'drivers/.../omap2/dss'.
     Compiler won't complain, but my comments is more from readability.
     There has to be something characteristically different in these
     headers - maybe this should reflect in the names as well.

~sanjeev
