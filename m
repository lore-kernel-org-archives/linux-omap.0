From: "Singh, Vimal" <vimalsingh@ti.com>
Subject: RE: [PATCH] OMAP2 NAND: Fix __raw_readsl() length argument
Date: Fri, 24 Oct 2008 12:14:29 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403DC101329@dbde02.ent.ti.com>
References: <a46a26fd0810221358l6153c0dat74f76af99fc8afaf@mail.gmail.com>
	 <200810221446.11415.david-b@pacbell.net>
	 <a46a26fd0810221452x1edfead1l524270ddaf250e2a@mail.gmail.com>
	 <200810221502.53045.david-b@pacbell.net>
	 <a46a26fd0810221523y4a947442p6eb060192603b8f1@mail.gmail.com>,<a46a26fd0810231451n2095b03btc832c2a8b70d2749@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55981 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbYJXGqI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Oct 2008 02:46:08 -0400
In-Reply-To: <a46a26fd0810231451n2095b03btc832c2a8b70d2749@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>, David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -       __raw_readsl(nand->IO_ADDR_R, buf, len / 2);
> +       __raw_readsw(nand->IO_ADDR_R, buf, len / 2);

I would prefer len >> 1 rather len / 2.

---
vimal