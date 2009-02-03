From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH B 02/10] OMAP2/3 clockdomains: combine pwrdm, pwrdm_name into union in struct clockdomain
Date: Tue, 3 Feb 2009 15:52:08 +0000
Message-ID: <20090203155208.GB9840@n2100.arm.linux.org.uk>
References: <20090128024301.27240.39391.stgit@localhost.localdomain> <20090128024408.27240.32198.stgit@localhost.localdomain> <20090131120112.GG1394@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0902030149520.29513@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38164 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755788AbZBCPwX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 10:52:23 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0902030149520.29513@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Tue, Feb 03, 2009 at 02:20:44AM -0700, Paul Walmsley wrote:
> Hello Russell,
> 
> On Sat, 31 Jan 2009, Russell King - ARM Linux wrote:
> 
> > On Tue, Jan 27, 2009 at 07:44:11PM -0700, Paul Walmsley wrote:
> > > struct clockdomain contains a struct powerdomain *pwrdm and const char
> > > *pwrdm_name.  The pwrdm_name is only used at initialization to look up
> > > the appropriate pwrdm pointer.  Combining these into a union saves
> > > about 100 bytes on 3430SDP.  This patch should not cause any change in
> > > kernel function.
> > 
> > For the same reasons as B1, this would seem to be unsafe.
> 
> Fixed; updated patch attached below.

Better.  Can I have it in email format so git-am can handle it please?
