From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 0/5] OMAP4 Power Domain Framework Support
Date: Mon, 14 Dec 2009 22:43:16 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912142240260.12561@utopia.booyaka.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02BC14194C@dbde02.ent.ti.com> <alpine.DEB.2.00.0912141628300.12561@utopia.booyaka.com> <EAF47CD23C76F840A9E7FCE10091EFAB02BC2402B9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40068 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbZLOFnR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 00:43:17 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BC2402B9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pagare, Abhijit" <abhijitpagare@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

Hi Abhijit,

On Tue, 15 Dec 2009, Pagare, Abhijit wrote:

> 	There is one Fix patch for OMAP3 on top of which these patches 
> should go in cleanly. I will post the fix patch and the rebased and 
> tested patch-set soon.

thanks.  One other thing that I noticed: in the first powerdomain patch, 
in arch/arm/plat-omap/include/plat/cpu.h, in struct omap_chip_id, the 'oc' 
field needs to be a u16, rather than a u8.


- Paul
