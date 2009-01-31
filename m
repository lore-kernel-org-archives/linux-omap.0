From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH E 08/14] OMAP clock: move rate recalc, propagation code up to plat-omap/clock.c
Date: Sat, 31 Jan 2009 11:40:14 +0000
Message-ID: <20090131114014.GD1394@n2100.arm.linux.org.uk>
References: <20090128192551.29333.82943.stgit@localhost.localdomain> <20090128192748.29333.5856.stgit@localhost.localdomain> <20090129174153.GH18233@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0901300135560.26985@utopia.booyaka.com> <20090130085249.GB6864@n2100.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE89671620376DEC116@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34077 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbZAaLka (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2009 06:40:30 -0500
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620376DEC116@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Fri, Jan 30, 2009 at 08:23:49AM -0600, Woodruff, Richard wrote:
> 
> > There's one bug that your version highlights in mine - the virtual mpu
> > clock in omap1 touches the DPLL and repropagates that rate.  I've
> > removed that repropagation, so that needs fixing.
> >
> > However, this raises a question: why is the virtual mpu clock touching
> > some other part of the clock tree.  I wonder whether this should be
> > handled a different way, though the first thing that needs answering is
> > why we have this alias for 'arm_ck' ?
> 
> At one point in time the virtual clock allowed control for a set of clocks
> with some dependencies.  The mpu alias provided a convenient control point.

>From what I can see (checking both mainline and Tony's tree), this mpu
alias (virtual_ck_mpu) is not used on OMAP1, which seems to suggest
that this quirk has become redundant.  If it is redundant, it should
be removed.

If there is some code somewhere to use it, this quirk should live with
the user of the quirk until such time that the user becomes ready to be
merged.
