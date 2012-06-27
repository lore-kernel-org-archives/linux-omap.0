From: Paul Walmsley <paul@pwsan.com>
Subject: RE: Current state of AM33xx patches
Date: Wed, 27 Jun 2012 13:37:26 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206271335280.27496@utopia.booyaka.com>
References: <4FD5BA4C.9070706@gmail.com> <4FD5FD9E.5040203@ti.com> <CADjby3UTVBKWRZUBRNTX9Bh4TqQJsoWQrrBxW6HuqSNZCUcvCw@mail.gmail.com> <79CD15C6BA57404B839C016229A409A83EA5B7DE@DBDE01.ent.ti.com> <alpine.DEB.2.00.1206271218540.27496@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA5C1AB@DBDE01.ent.ti.com> <alpine.DEB.2.00.1206271306170.27496@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EA5C1F7@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38028 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754852Ab2F0Th2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 15:37:28 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA5C1F7@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Domenico Andreoli <cavokz@gmail.com>, Daniel Mack <zonque@gmail.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, 27 Jun 2012, Hiremath, Vaibhav wrote:

> Shouldn't impact, but  still will apply now...will update you on this.
> Can you also share me the .config file of yours??

Just sent it to you via private E-mail.  It's just omap2plus_defconfig 
plus the two DT-related config options that you mentioned.

One other minor comment, the kernel build system wouldn't build a kernel 
following the exact sequence of steps that you mentioned earlier.  Rather 
than building uImage-dtb.am335x-evm as a direct target, first I had to 
build the uImage.


- Paul
