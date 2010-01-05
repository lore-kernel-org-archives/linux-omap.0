From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/4] OMAP clock/CPUFreq: avoid leaking the CPUFreq
 frequency table
Date: Tue, 5 Jan 2010 08:58:19 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001050855110.2083@utopia.booyaka.com>
References: <20100105024113.16275.96273.stgit@localhost.localdomain> <20100105024207.16275.26135.stgit@localhost.localdomain> <20100105104603.GB11291@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51402 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576Ab0AEP6V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 10:58:21 -0500
In-Reply-To: <20100105104603.GB11291@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 5 Jan 2010, Felipe Balbi wrote:

> On Tue, Jan 05, 2010 at 03:42:08AM +0100, ext Paul Walmsley wrote:
> > OMAP2xxx uses a dynamically-allocated cpufreq_frequency_table array,
> > so this patch ensures that it is freed if CPUFreq terminates.
> 
> wasn't this introduced by the previous patch ?

The dynamically-allocated array?  Yes.  Your point being?


- Paul
