From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: RE: [RFC][PATCH 0/4] TWL6030 patch series
Date: Mon, 17 Aug 2009 15:12:21 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940432B7A951@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E739404329D670F@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940432AF3EB6@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940432B7A0B6@dbde02.ent.ti.com>
 <20090816235959.GC4266@sortiz.org>
 <19F8576C6E063C45BE387C64729E73940432B7A87B@dbde02.ent.ti.com>
 <20090817091453.GB3228@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35749 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbZHQJm6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 05:42:58 -0400
In-Reply-To: <20090817091453.GB3228@sortiz.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "sameo@openedhand.com" <sameo@openedhand.com>, "wim@iguana.be" <wim@iguana.be>, "timo.t.kokkonen@nokia.com" <timo.t.kokkonen@nokia.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "me@felipebalbi.com" <me@felipebalbi.com>

> -----Original Message-----
> From: Samuel Ortiz [mailto:sameo@linux.intel.com]
> On Mon, Aug 17, 2009 at 10:46:55AM +0530, Krishnamoorthy, Balaji T wrote:
> > > From: Samuel Ortiz [mailto:sameo@linux.intel.com]
> > > * Why are you moving twl_init_irq and twl_exit_irq to twl.h ?
> > >
> > twl_init_irq and twl_exit_irq is defined in twl4030-irq.c and called from
> > twl-core.c.  Earlier twl4030-core.c had declaration too.
> You're now exporting those 2 routines from a include/linux/ header, and I
> still dont understand why.
My assumption was that declaration has to be in .h file.  But since these two 
functions are called only from twl-core.c files, I can keep it as before, 
without moving to twl.h

