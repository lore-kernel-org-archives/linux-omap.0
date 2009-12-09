From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/6] OMAP4: Fix cpu detection
Date: Thu, 10 Dec 2009 01:07:27 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BC0A826C@dbde02.ent.ti.com>
References: <1260383350-32681-1-git-send-email-santosh.shilimkar@ti.com>
 <74583B8642AB8841B30447520659FCA9DE4CF096@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36893 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756787AbZLIThl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 14:37:41 -0500
In-Reply-To: <74583B8642AB8841B30447520659FCA9DE4CF096@dnce01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>


> -----Original Message-----
> From: Cousson, Benoit
> Sent: Thursday, December 10, 2009 1:04 AM
> To: Shilimkar, Santosh; tony@atomide.com
> Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org; linux@arm.linux.org.uk
> Subject: RE: [PATCH 1/6] OMAP4: Fix cpu detection
> 
> Hi Santosh,
> 
> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >owner@vger.kernel.org] On Behalf Of Shilimkar, Santosh
> >
> >This patch fixes the OMAP4430 cpu detection. Since the omap ID
> >register is not fused in OMAP4430 ES1.0 silicon, identification is
> >done using ARM CPUID register.
> 
> I think that this description is not reflecting your current patch that does use the DEVICE_ID
> register.
Yes. The second version uses ID_CODE but the commit message still refers to the 1st one. Will fix
Commit message.

