From: "Singh, Vimal" <vimalsingh@ti.com>
Subject: RE: [RESENDING][PATCH 1/2]OMAP3 NAND: Add NAND support on OMAP3430
Date: Thu, 11 Sep 2008 14:20:19 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403CD517C4B@dbde02.ent.ti.com>
References: <41054.192.168.10.89.1219747319.squirrel@dbdmail.itg.ti.com>
 <33923.192.168.10.89.1221112794.squirrel@dbdmail.itg.ti.com>,<200809102321.44169.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40176 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599AbYIKIu2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 04:50:28 -0400
In-Reply-To: <200809102321.44169.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > +       /* All the partition sizes are listed in terms of NAND block size
> > ...
> > +               .size           = SZ_512K,
> > ...
> > +               .size           = SZ_512K,
> > ...
>
> But now they're not "in terms of NAND block size".

Agree.

>
> Wouldn't it be better to use either 4 * SZ_128K or 4 * NAND_BLOCK_SIZE?

4 * NAND_BLOCK_SIZE looks much better. I'll send patch after updating for this.
I will define NAND_BLOCK_SIZE as:
#define NAND_BLOCK_SIZE                64 * NAND_MAX_PAGESIZE