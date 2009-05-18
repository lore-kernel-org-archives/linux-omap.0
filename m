From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RESUBMIT][PATCH 4/7] OMAP4: Update common omap platform common
	sources.
Date: Mon, 18 May 2009 21:22:48 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B49CB5E8@dbde02.ent.ti.com>
References: <1241677756-28756-1-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-2-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-3-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-4-git-send-email-santosh.shilimkar@ti.com>
 <20090516095332.GH15328@n2100.arm.linux.org.uk>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B49042A1@dbde02.ent.ti.com>
 <20090518155054.GQ19742@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33811 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbZERPxN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 11:53:13 -0400
In-Reply-To: <20090518155054.GQ19742@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> > > is a static function.  The only user of omap4_globals is 
> > > __omap4_set_globals.
> > > It looks to me like the only purpose of omap4_globals is to pass a
> > > structure to __omap4_set_globals.  Why not use a function 
> > > argument instead?
> > Indeed. Actually I just more or less followed what is done 
> for OMAP2/OMAP3 here. I will clean this for OMAP4.
> > 
> > Tony,
> > We may want to clean up this for OMAP2/OMAP3 as well. Can 
> we add this to the clean up patches planned if any. I can 
> create the patch.
> 
> Sure, please post that patch for review.

OK


Regards,
Santosh
 