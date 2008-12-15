From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH v3] MUSB: fix srp sysfs entry deletion
Date: Mon, 15 Dec 2008 22:08:57 +0200
Message-ID: <20081215200856.GB28753@frodo>
References: <20081215171611.0b3877d5@lxorguk.ukuu.org.uk> <1229362427.12163.94.camel@localhost.localdomain> <1229363671.12163.109.camel@localhost.localdomain> <20081215180740.02ef1667@lxorguk.ukuu.org.uk> <FCCFB4CDC6E5564B9182F639FC356087025127B95B@dbde02.ent.ti.com> <FCCFB4CDC6E5564B9182F639FC356087025127B95C@dbde02.ent.ti.com> <20081215195136.GM23324@frodo> <FCCFB4CDC6E5564B9182F639FC356087025127B962@dbde02.ent.ti.com> <20081215195941.GA28753@frodo> <FCCFB4CDC6E5564B9182F639FC356087025127B964@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:44168 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbYLOUJD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 15:09:03 -0500
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087025127B964@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>

On Tue, Dec 16, 2008 at 01:35:05AM +0530, Pandita, Vikram wrote:
> From: Vikram Pandita <vikram.pandita@ti.com>
> 
> srp sysfs attribute is dependent on gadget mode
> 
> the entry was not getting deleted in rmmod case,
> fixing the bug
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> CC: Felipe Balbi <me@felipebalbi.com>

applied, thanks

-- 
balbi
