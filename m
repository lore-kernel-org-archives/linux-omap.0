From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
 check for it on V6
Date: Fri, 19 Mar 2010 08:32:23 -0700
Message-ID: <20100319153223.GR2900@atomide.com>
References: <20100317175731.GE2900@atomide.com>
 <1268849278.19565.28.camel@e102109-lin.cambridge.arm.com>
 <20100317191114.GH2900@atomide.com>
 <1268910826.15334.32.camel@e102109-lin.cambridge.arm.com>
 <20100318170021.GN2900@atomide.com>
 <20100319013521.GP2900@atomide.com>
 <20100319034645.GG14108@shareable.org>
 <20100319085403.GB8451@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62127 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818Ab0CSPbN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 11:31:13 -0400
Content-Disposition: inline
In-Reply-To: <20100319085403.GB8451@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jamie Lokier <jamie@shareable.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100319 01:50]:
> On Fri, Mar 19, 2010 at 03:46:45AM +0000, Jamie Lokier wrote:
> > I'm thinking, why not an alternative() macro like on x86, which is a
> > very nice way to describe run-time patches of one or a few instructions
> > which depend on arch feature bits.
> 
> Having XIP support prevents that kind of thing.

How about we store the HWCAP_TLS flag into 0xffff0ff4 for
__kuser_get_tls? That way the userspace won't be able to set
it.

Tony
