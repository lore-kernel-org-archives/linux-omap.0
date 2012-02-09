From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC PATCH 3/8] misc: emif: add register definitions for EMIF
Date: Thu, 9 Feb 2012 11:25:48 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433179B3F3@DBDE01.ent.ti.com>
References: <331ABD5ECB02734CA317220B2BBEABC1317897B8@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36066 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753160Ab2BILZx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 06:25:53 -0500
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC1317897B8@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "V, Aneesh" <aneesh@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of V, Aneesh
> Sent: Saturday, February 04, 2012 5:46 PM
> To: linux-omap@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; akpm@linux-foundation.org; V, Aneesh
> Subject: [RFC PATCH 3/8] misc: emif: add register definitions for EMIF
> 

Sorry for the delayed response. Can these register definitions be put in a place
where the code from the arch/arm/mach-omap2/* can also access it?

Devices like AM335x and TI814x will need to reconfigure the EMIF when coming out
of low power states and putting these register definitions in a common place
will help us avoid some code duplication.

Regards,
Vaibhav
