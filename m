From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 1/8] ARM: OMAP: clk: add support for omap_clk_for_each
Date: Mon, 16 Jul 2012 14:42:51 +0300
Message-ID: <1342438971.4672.64.camel@sokoban>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
	 <1342189185-5306-2-git-send-email-t-kristo@ti.com>  <5003E737.60406@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39488 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab2GPLnB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jul 2012 07:43:01 -0400
In-Reply-To: <5003E737.60406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Mon, 2012-07-16 at 15:34 +0530, Rajendra Nayak wrote:
> On Friday 13 July 2012 07:49 PM, Tero Kristo wrote:
> > This works similarly to e.g. pwrdm_for_each(). Needed by enhanced
> > usecounting debug functionality that will be added to pm-debug.
> 
> OMAP clock framework has its own debugfs entry (/debug/clock) to expose
> usecounts for clocks, so does the COMMON clock framework (/debug/clk).
> Maybe there isn't one which dumps usecounts for the complete tree,
> instead there is one per each clock node.
> 
> I agree having a complete dump of the clock tree usecounts can be
> useful, but can we keep it in /debug/clock for now?
> The reason I am saying this is because once we move from OMAP clock to
> COMMON clock, something like what 'omap_clk_for_each' does will
> not be possible anyway. We might have to add the support for
> dumping complete tree usecounts into the COMMON clock core.

The main idea behind the dump was to allow dumping of whole clocktree
status during failed suspend. It is not that useful as a debugfs feature
(you can do the same with some scripts on userspace), but this is
available as a side effect from the suspend dump.

-Tero

