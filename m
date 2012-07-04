From: Paul Walmsley <paul@pwsan.com>
Subject: RE: how to specify dma_mask and coherent_dma_mask in hwmod
Date: Wed, 4 Jul 2012 03:28:38 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207040328260.6760@utopia.booyaka.com>
References: <EB1619762EAF8B4E97A227FB77B7E0293E9BDE96@DBDE01.ent.ti.com> <B5906170F1614E41A8A28DE3B8D121433EAED507@DBDE01.ent.ti.com> <alpine.DEB.2.00.1206280950440.2338@utopia.booyaka.com> <B5906170F1614E41A8A28DE3B8D121433EAED713@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1206281031510.2338@utopia.booyaka.com> <B5906170F1614E41A8A28DE3B8D121433EAEE878@DBDE01.ent.ti.com> <EB1619762EAF8B4E97A227FB77B7E0293E9C03C6@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51157 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab2GDJ2j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 05:28:39 -0400
In-Reply-To: <EB1619762EAF8B4E97A227FB77B7E0293E9C03C6@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "N, Mugunthan V" <mugunthanvnm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>

On Mon, 2 Jul 2012, N, Mugunthan V wrote:

> Extending omap_device_build() to accommodate dma masks will endup with lot 
> of code changes in other modules

Why?


- Paul
