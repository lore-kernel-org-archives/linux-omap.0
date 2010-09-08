From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] OMAP2+: PM: initial runtime PM core support
Date: Wed, 8 Sep 2010 11:39:31 -0600
Message-ID: <20100908173931.GL3686@angua.secretlab.ca>
References: <1283907282-986-1-git-send-email-khilman@deeprootsystems.com>
 <20100908162143.GD3686@angua.secretlab.ca>
 <871v945esf.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48265 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758Ab0IHRje (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Sep 2010 13:39:34 -0400
Received: by pwi3 with SMTP id 3so161938pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Sep 2010 10:39:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <871v945esf.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On Wed, Sep 08, 2010 at 10:24:48AM -0700, Kevin Hilman wrote:
> Grant Likely <grant.likely@secretlab.ca> writes:
> 
> > On Tue, Sep 07, 2010 at 05:54:41PM -0700, Kevin Hilman wrote:
> >> +	omap_pm->runtime_suspend = omap_pm_runtime_suspend;
> >> +	omap_pm->runtime_resume = omap_pm_runtime_resume;
> >
> > This will fail to build when CONFIG_PM_RUNTIME is unset.  None of this
> > file should be build when CONFIG_PM_RUNTIME=n.
> 
> FYI... Rather than not building the whole file, I'm fixing this by
> adding an #else clause to the #ifdef:
> 
> #else
> #define omap_pm_runtime_suspend NULL
> #define omap_pm_runtime_resume NULL
> #endif /* CONFIG_PM_RUNTIME */
> 
> This is because I'll also be building on this to hook up the
> _[suspend|resume]_noirq() methods which are based on #ifdef
> CONFIG_SUSPEND and not CONFIG_PM_RUNTIME.

okay.

g.

