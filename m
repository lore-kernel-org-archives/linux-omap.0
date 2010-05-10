From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCHv4 1/4] procfs: Introduce socinfo under /proc
Date: Mon, 10 May 2010 15:55:49 +0300
Message-ID: <20100510125548.GB11804@besouro.research.nokia.com>
References: <1273487857-32281-1-git-send-email-eduardo.valentin@nokia.com>
 <1273487857-32281-3-git-send-email-eduardo.valentin@nokia.com>
 <1273487857-32281-1-git-send-email-eduardo.valentin@nokia.com>
 <1273487857-32281-2-git-send-email-eduardo.valentin@nokia.com>
 <20100510111259.GA14680@linux-sh.org>
 <20100510123514.GA11804@besouro.research.nokia.com>
 <20100510123902.GA15293@linux-sh.org>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:50062 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668Ab0EJMwx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 08:52:53 -0400
Content-Disposition: inline
In-Reply-To: <20100510123902.GA15293@linux-sh.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Mundt <lethal@linux-sh.org>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, LKML <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, ext Tony Lindgren <tony@atomide.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, "De-Schrijver Peter (Nokia-D/Helsinki)" <Peter.De-Schrijver@nokia.com>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, Ambresh <a0393775@ti.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>

On Mon, May 10, 2010 at 02:39:02PM +0200, ext Paul Mundt wrote:
> On Mon, May 10, 2010 at 03:35:14PM +0300, Eduardo Valentin wrote:
> > On Mon, May 10, 2010 at 01:13:00PM +0200, ext Paul Mundt wrote:
> > > On Mon, May 10, 2010 at 01:37:34PM +0300, Eduardo Valentin wrote:
> > > > + */
> > > > +#include <linux/fs.h>
> > > > +#include <linux/init.h>
> > > > +#include <linux/proc_fs.h>
> > > > +#include <linux/seq_file.h>
> > > > +
> > > > +extern const struct seq_operations socinfo_op;
> > > 
> > > This doesn't look promising..
> > 
> > Right.. as stated in patch description (maybe not that clear), this was
> > basically same thing which you see under fs/proc/cpuinfo.c
> > 
> The cpuinfo case is a bit more complex since you have actual real work to
> do in the ->start op and you will iterate over the ->show op for each
> CPU. In your socinfo case you're just following the single_xxx()
> semantics so using those helpers there simplifies things quite a bit.

Yeah,

> 
> Architectures that do not support SMP technically employ single_open()
> semantics, but the fs/proc/cpuinfo.c abstraction requires the
> architecture to provide seq ops regardless.

OK.

> 
> Note that in the cpuinfo case there is often special handling for the
> single (or boot CPU) case, such as printing out a descriptor for the
> machine type and so on. You might be better off just extending cpuinfo
> rather than introducing another /proc abstraction, presumably your
> socinfo string will be fixed regardless of whether it's SMP or not.

Yeah, I wouldn't expect it to change if it SMP or not. It should be fixed.
Previous version of this change was actually extending ARM cpuinfo. The previous
thread starts here:
http://marc.info/?l=linux-omap&m=127304890312365&w=2

But, the point of moving that to specific file was that soc info is not really cpu info.


BR,

--
Eduardo Valentin
