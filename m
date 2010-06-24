From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 10/13] OMAP: omap_device: add flag to disable automatic
 bus-level suspend/resume
Date: Thu, 24 Jun 2010 12:06:00 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1006241205460.1550@utopia.booyaka.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com> <1277336563-24988-11-git-send-email-khilman@deeprootsystems.com> <alpine.DEB.2.00.1006232136440.1550@utopia.booyaka.com> <87zkykfhyp.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44602 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab0FXSGA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 14:06:00 -0400
In-Reply-To: <87zkykfhyp.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Thu, 24 Jun 2010, Kevin Hilman wrote:

> Paul Walmsley <paul@pwsan.com> writes:
> 
> > Hi Kevin,
> >
> > A few comments:
> >
> > Your "add runtime PM support at bus-level" series has a unstated 
> > dependency on this patch.  If you fix one minor issue (below), it's 
> > probably easiest if you merge it with that other series to avoid 
> > cross-dependencies.
> 
> If I switch (back) to just using pm_runtime_* API in the system PM
> path _noirq methods, then rather than setting this flag at the
> omap_device level, drivers that want to prevent this can simply
> do a runtime_pm_get_sync() if they want to prevent a bus-level
> suspend.
> 
> Any thoughts/objectsion to that?

Sounds fine to me.


- Paul
