From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP3: hwmod: Adding flag to prevent caching of sysconfig
 register.
Date: Mon, 11 Jan 2010 23:04:06 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001112256300.8534@utopia.booyaka.com>
References: <1260098674-27143-1-git-send-email-thara@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB031DF2E171@dbde02.ent.ti.com> <alpine.DEB.2.00.1001051730230.21295@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB031E1D6B7B@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1001111515080.8534@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB031E1D7500@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56960 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab0ALGEI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 01:04:08 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D7500@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Thara,

On Tue, 12 Jan 2010, Gopinath, Thara wrote:

> >>-----Original Message-----
> >>From: Paul Walmsley [mailto:paul@pwsan.com]
> >>
> >>Aren't the SmartReflex modules in their own powerdomain that changes with
> >>the CORE powerdomain?
> 
> Hmmmm I think Smartreflex is in Core poweerdomain but sr1_fclk and 
> sr2_fclk are in the wakeup domain. Slightly complicated :-(

According to the TRM rev W figure 4-18 "Device Power Domains", at least, 
the SmartReflex modules are in their own powerdomain.


- Paul
