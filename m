From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC][PATCH 8/9] OMAP4: clockdomain: Use CHIP_IS_44XX to reuse
 all CD's on 4460
Date: Thu, 26 May 2011 14:17:52 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D177F88@dbde02.ent.ti.com>
References: <1306375016-707-1-git-send-email-nm@ti.com>
 <1306375016-707-9-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56108 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab1EZIsB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 May 2011 04:48:01 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4Q8lwv3016513
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 03:48:00 -0500
In-Reply-To: <1306375016-707-9-git-send-email-nm@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Thursday, May 26, 2011 7:27 AM
> To: linux-omap
> Cc: Nayak, Rajendra
> Subject: [RFC][PATCH 8/9] OMAP4: clockdomain: Use 
> CHIP_IS_44XX to reuse all CD's on 4460

[sp] Is CD as standard nomenclature?
     In any case "CD's" is different from "CDs".

~sanjeev

> 
> From: Rajendra Nayak <rnayak@ti.com>
> 
> The 4460 platform has no difference in the clockdomains
> as compared to the 4430 platform.
> Hence just update the .omap_chip field to make sure
> the same clockdomains model data can be reused on the
> 4460 platform.

[snip]...[snip]
