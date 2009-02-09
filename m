From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH C 06/13] OMAP3 clock: DPLLs should enter bypass if new rate is sys_ck
Date: Mon, 9 Feb 2009 11:19:22 +0000
Message-ID: <20090209111922.GA11668@n2100.arm.linux.org.uk>
References: <20090128190724.12092.22239.stgit@localhost.localdomain> <20090128190823.12092.2638.stgit@localhost.localdomain> <20090129123936.GA16644@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0901292244211.26985@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753976AbZBILTx@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0901292244211.26985@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 29, 2009 at 10:47:40PM -0700, Paul Walmsley wrote:
> Hello Russell,
> 
> this E-mail responds to your comments on patches C 04 through C 08.  
> My understanding is that you'd like me to:
> 
> 1. Compress patches C 04 through C 09;

What I would like to see is a clear set of patches (or maybe just a
single patch if appropriate) implementing the bypass DPLL support,
and have it implemented in a common form for both OMAP2 and OMAP3.

In other words, if we're going to have a 'bypass' clock in the DPLL
data, it shouldn't be just an OMAP3 thing.

I suspect it's going to be easier for me to figure out what's going
on, clean up the existing patches and work from them so that they
still fit in the existing series.
