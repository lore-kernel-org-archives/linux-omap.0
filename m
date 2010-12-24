From: David Brownell <david-b@pacbell.net>
Subject: Re: Issue : jffs2 and ecc layout
Date: Fri, 24 Dec 2010 10:37:57 -0800 (PST)
Message-ID: <89885.88076.qm@web180308.mail.gq1.yahoo.com>
References: <AANLkTiky0G_H9vGDRNj-y=JTcfCcvRgfXraa0SbAZM4t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm8-vm0.bullet.mail.sp2.yahoo.com ([98.139.91.194]:27808 "HELO
	nm8-vm0.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753097Ab0LXSh7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Dec 2010 13:37:59 -0500
In-Reply-To: <AANLkTiky0G_H9vGDRNj-y=JTcfCcvRgfXraa0SbAZM4t@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charles Manning <manningc2@actrix.gen.nz>, Ming Lei <tom.leiming@gmail.com>
Cc: SukumarGhorai <s-ghorai@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

ISTR that while JFFS2 worked with NAND, it had
to reserve a few bytes of OOB data that might more
naturally be used for ECC data.  I've not looked
at your layout ... does it reserve those bytes
for use by JFFS, or is it using them for ECC?

Also, ISTR that Some People felt that using JFFS2
with NAND was sub-optimal.  Which is why we have other NAND filesystem choices, like UBI/UBIFS,
and  (currently out-of-tree) YAFFS2.

- Dave

