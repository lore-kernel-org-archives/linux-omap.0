From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
	check for it on V6
Date: Fri, 19 Mar 2010 08:54:04 +0000
Message-ID: <20100319085403.GB8451@n2100.arm.linux.org.uk>
References: <20100317175731.GE2900@atomide.com> <1268849278.19565.28.camel@e102109-lin.cambridge.arm.com> <20100317191114.GH2900@atomide.com> <1268910826.15334.32.camel@e102109-lin.cambridge.arm.com> <20100318170021.GN2900@atomide.com> <20100319013521.GP2900@atomide.com> <20100319034645.GG14108@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43109 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab0CSIye (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 04:54:34 -0400
Content-Disposition: inline
In-Reply-To: <20100319034645.GG14108@shareable.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jamie Lokier <jamie@shareable.org>
Cc: Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Mar 19, 2010 at 03:46:45AM +0000, Jamie Lokier wrote:
> I'm thinking, why not an alternative() macro like on x86, which is a
> very nice way to describe run-time patches of one or a few instructions
> which depend on arch feature bits.

Having XIP support prevents that kind of thing.
