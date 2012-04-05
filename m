From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: PRM: fix compile for OMAP4-only build
Date: Thu, 5 Apr 2012 17:37:53 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204051734560.10302@utopia.booyaka.com>
References: <1333660837-23249-1-git-send-email-khilman@ti.com> <alpine.DEB.2.00.1204051533110.10302@utopia.booyaka.com> <20120405225345.GJ3785@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46136 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab2DEXhy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 19:37:54 -0400
In-Reply-To: <20120405225345.GJ3785@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 5 Apr 2012, Tony Lindgren wrote:

> I heard of this first from Kevin before I started hitting it with
> my compiles..

Okay.

> Anyways, can you also check that we don't have a similar issue
> with omap44xx_prm_reconfigure_io_chain for omap3 only builds?

Will do.  Clearly I need to be running the full build-test suite on all of 
my branches, as I was doing before the arm-soc transition.

Future pull requests from me will be test-built with a large variety of 
kernel .configs, and will contain a 'size' report for each generated 
binary in the pull request.


- Paul
