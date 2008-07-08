From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 0/9] OMAP2/3 SDRC/clock: control CORE M2 divider, clean
 up SDRC
Date: Tue, 8 Jul 2008 16:12:56 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0807081611500.12684@utopia.booyaka.com>
References: <20080708025225.11646.55912.stgit@localhost.localdomain> <02aa01c8e0b4$5c09a450$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54742 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbYGHWM6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2008 18:12:58 -0400
In-Reply-To: <02aa01c8e0b4$5c09a450$68bf18ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, 'Igor Stoppa' <igor.stoppa@nokia.com>

On Tue, 8 Jul 2008, Rajendra Nayak wrote:

> > From: Paul Walmsley [mailto:paul@pwsan.com] 
> >
> > A few notes:
> > 
> > - The M2 divider switch does not seem to work consistently on the
> >   3430SDP I use to test.  In particular, the switch back to 
> > M2=1 results
> >   in a hung console.
> 
> SRAM being mapped as cacheable could be a possible reason for this.

Certainly possible, and that change needs to be included.  But why would 
it only happen on the M2  2 -> 1 transition?


- Paul
