From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/4] OMAP clock/CPUFreq: avoid leaking the CPUFreq
 frequency table
Date: Tue, 19 Jan 2010 12:26:26 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001191222040.3977@utopia.booyaka.com>
References: <20100105024113.16275.96273.stgit@localhost.localdomain> <20100105024207.16275.26135.stgit@localhost.localdomain> <20100105104603.GB11291@nokia.com> <alpine.DEB.2.00.1001050855110.2083@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48783 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab0AST01 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 14:26:27 -0500
In-Reply-To: <alpine.DEB.2.00.1001050855110.2083@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Felipe,

On Tue, 5 Jan 2010, Paul Walmsley wrote:

> On Tue, 5 Jan 2010, Felipe Balbi wrote:
> > On Tue, Jan 05, 2010 at 03:42:08AM +0100, ext Paul Walmsley wrote:
> > > OMAP2xxx uses a dynamically-allocated cpufreq_frequency_table array,
> > > so this patch ensures that it is freed if CPUFreq terminates.
> > 
> > wasn't this introduced by the previous patch ?
> 
> The dynamically-allocated array?  Yes.  Your point being?

By the way, I am sorry for this - it was too brusque for how I 
believe collaborative development should be.  Next time I will be more 
clear about the question...

regards,

- Paul
