From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3] omap: dmtimer: convert printk to pr_err
Date: Fri, 7 Oct 2011 20:18:22 +0100
Message-ID: <20111007191822.GA26805@n2100.arm.linux.org.uk>
References: <20111006201827.GT6324@atomide.com> <1317977417-17874-1-git-send-email-vjaquez@igalia.com> <20111007092243.GC27281@n2100.arm.linux.org.uk> <1318009239.1644.38.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60806 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281Ab1JGTTA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 15:19:00 -0400
Content-Disposition: inline
In-Reply-To: <1318009239.1644.38.camel@Joe-Laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: =?iso-8859-1?Q?V=EDctor_Manuel_J=E1quez?= Leal <vjaquez@igalia.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Timo Teras <timo.teras@solidboot.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Oct 07, 2011 at 10:40:39AM -0700, Joe Perches wrote:
> At some point in the next couple of years, I want
> to convert all of, or as many as possible of, the
> remaining printk uses to pr_<level>.

If the idea is also to get rid of printk() too (which IMHO would be a
good thing as it kills off the constant need to continually patch for
missing KERN_ prefixes) then that's a good reason (provided Linus
accepts the idea.)  At that point having such patches as part of a
progressive series of patches also makes sense.

Doing it piecemeal when we've already had frequent complaints from
Linus about useless churn with no apparant reasoning behind it doesn't
help relieve us of those accusations.
