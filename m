From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 4/4] OMAP clock/CPUFreq: avoid leaking the CPUFreq
 frequency table
Date: Wed, 6 Jan 2010 17:54:59 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001061750590.10034@utopia.booyaka.com>
References: <20100105173347.15485.42853.stgit@localhost.localdomain> <20100105173517.15485.60424.stgit@localhost.localdomain> <87k4vu93rw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39345 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756405Ab0AGAzA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 19:55:00 -0500
In-Reply-To: <87k4vu93rw.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com

On Wed, 6 Jan 2010, Kevin Hilman wrote:

> Paul Walmsley <paul@pwsan.com> writes:
> 
> > OMAP2xxx uses a dynamically-allocated cpufreq_frequency_table array,
> > so this patch ensures that it is freed if CPUFreq terminates.
> >
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> Minor nit, but shouldn't this be just folded into PATCH 3/4 since you
> add the dynamic allocation there?

I guess it's a matter of taste.  Maybe this is what Felipe was talking 
about.

The addition of clk_exit_cpufreq_table belongs in a separate patch.  So I 
will split that part out and put it earlier in the series.


- Paul
