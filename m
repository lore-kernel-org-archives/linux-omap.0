From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH v2] MUSB: fix wrongly created sysfs entry
Date: Mon, 15 Dec 2008 21:51:36 +0200
Message-ID: <20081215195136.GM23324@frodo>
References: <1229356837.22285.239.camel@violet> <1229357553.12163.55.camel@localhost.localdomain> <20081215162505.4b11c9be@lxorguk.ukuu.org.uk> <1229359592.12163.80.camel@localhost.localdomain> <20081215171611.0b3877d5@lxorguk.ukuu.org.uk> <1229362427.12163.94.camel@localhost.localdomain> <1229363671.12163.109.camel@localhost.localdomain> <20081215180740.02ef1667@lxorguk.ukuu.org.uk> <FCCFB4CDC6E5564B9182F639FC356087025127B95B@dbde02.ent.ti.com> <FCCFB4CDC6E5564B9182F639FC356087025127B95C@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:38220 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbYLOTvn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 14:51:43 -0500
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087025127B95C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>

On Tue, Dec 16, 2008 at 12:53:47AM +0530, Pandita, Vikram wrote:
> From: Vikram Pandita <vikram.pandita@ti.com>
> 
> attr_srp is created wrongly for GADGET only mode of MUSB
> The attribute is related to OTG mode only
> 
> For Gadget mode, this attribute gets created on insmod but does
> not get deleted. Fixing the bug.
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>

NAK, any gadget is allowed to initiate SRP.
See otg rev1.3 page 20:

"Any B-device, including a standard USB peripheral, is allowed to
initiate SRP"

-- 
balbi
