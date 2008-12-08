From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Bug in linux omap clock framework?
Date: Mon, 08 Dec 2008 11:36:07 +0200
Message-ID: <1228728967.8668.72.camel@tubuntu>
References: <21FAA8D4A5AB5E4096AC4BE4BF42EB140157D444@vaebe104.NOE.Nokia.com>
	 <alpine.DEB.2.00.0812061635110.21247@utopia.booyaka.com>
	 <1228726770.8668.66.camel@tubuntu>
	 <alpine.DEB.2.00.0812080218190.5902@utopia.booyaka.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:47007 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbYLHJgY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2008 04:36:24 -0500
In-Reply-To: <alpine.DEB.2.00.0812080218190.5902@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

On Mon, 2008-12-08 at 02:24 -0700, ext Paul Walmsley wrote:
> Hi Tomi,
> 
> On Mon, 8 Dec 2008, Tomi Valkeinen wrote:
> 
> > On Sat, 2008-12-06 at 16:51 -0700, ext Paul Walmsley wrote:
> 
> > > Based on the traceback that you sent, I'd conjecture that probably some 
> > > part of the DSS subsystem is generating an interrupt via DSS_IRQ; but then 
> > > dss_iclk ends up disabled, and the MPU INTC is not able to communicate 
> > > with the DSS, and the INTC wedges.  (The aborting access is to 0xd8200098, 
> > > the INTCPS_PENDING_IRQ0 register, rather than a DSS register.)  Probably 
> > > some IRQs need to be masked before disabling the dss_iclk.
> > 
> > Okay. So, is this a DSS problem or clock framework problem? 
> 
> At this point my guess would be that it is a DSS driver problem, but I 
> don't think it is clear yet.

Also, after disabling CONFIG_PM the code doesn't crash anymore...
Something is turning powers/clocks off too eagerly?

 Tomi

