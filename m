From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 6/6] OMAP: WDT: Use PM runtime APIs instead of clk
 FW APIs
Date: Wed, 15 Sep 2010 10:55:40 -0700
Message-ID: <20100915175540.GD4174@atomide.com>
References: <1284528403-6494-1-git-send-email-charu@ti.com>
 <1284528403-6494-7-git-send-email-charu@ti.com>
 <87fwxbgj55.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57280 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847Ab0IORzs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 13:55:48 -0400
Content-Disposition: inline
In-Reply-To: <87fwxbgj55.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, linux-omap@vger.kernel.org, "Varadarajan, Charulatha" <charu@ti.com>

* Kevin Hilman <khilman@deeprootsystems.com> [100915 07:37]:
> Hi Wim,
> 
> "Varadarajan, Charulatha" <charu@ti.com> writes:
> 
> > Call runtime pm APIs pm_runtime_put_sync() and pm_runtime_get_sync()
> > for enabling/disabling the clocks, sysconfig settings instead of using
> > clock FW APIs.
> >
> > Signed-off-by: Charulatha V <charu@ti.com>
> 
> With your ack, I'll be glad to merge this via the OMAP tree since it
> depends on the rest of the series for the OMAP platform specific
> changes.

Just checking.. The pm_runtime functions are implemented as
clk_enable/disable functions for omap1, right?

Tony
