From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH F 06/12] OMAP2/3 clock: every clock must have a clkdm
Date: Tue, 3 Feb 2009 08:20:14 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE89671620376F47DFB@dlee02.ent.ti.com>
References: <20090128193326.2396.9437.stgit@localhost.localdomain>
 <20090128193512.2396.75340.stgit@localhost.localdomain>
 <20090131140804.GH1394@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.0902030011320.5741@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55686 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbZBCOUm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 09:20:42 -0500
In-Reply-To: <alpine.DEB.2.00.0902030011320.5741@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

> Virtual clocks should soon be eliminated from the OMAP clock tree.  (
> "Virtual clocks" is here used to refer a clock that does not have a
> referent in the hardware; the usage of the term in the code is loose.)
> So far as I know, all of the OMAP virtual clocks have either turned out to
> be superfluous (and prone to spinlock recursion bugs), or to be better
> implemented outside of the clock framework (such as the virtual OPP
> clocks).  We've eliminated the former.  We should be able to eliminate the
> latter in a few months.

What is your idea for replacement of virtual OPPs?

Especially on OMAP2 they were useful with tightly coupled clock sets.  Some later versions of 2420 were characterized such that some of the dependencies could be ignored but that is not the case for all of them.  The centerline design as I understand it wasn't for this. It just happened that enough margin was there in some binn'ed lots to do this.

Regards,
Richard W.

