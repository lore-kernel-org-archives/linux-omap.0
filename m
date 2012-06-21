From: Paul Walmsley <paul@pwsan.com>
Subject: Re: 5912OSK NFS root broken on v3.5-rc3
Date: Thu, 21 Jun 2012 13:58:24 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206211357200.10198@utopia.booyaka.com>
References: <alpine.DEB.2.00.1206211212290.10198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37143 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756484Ab2FUT6Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jun 2012 15:58:25 -0400
In-Reply-To: <alpine.DEB.2.00.1206211212290.10198@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com

On Thu, 21 Jun 2012, Paul Walmsley wrote:

> The 5912OSK here no longer mounts NFS root:
> 
> http://www.pwsan.com/omap/bootlogs/20120620/omap_cleanup_a_3.6__07b3a13957aa250ff5b5409b8ed756b113544112/
> 
> This broke at some point between v3.4-rc2 and v3.5-rc3.

This one wass due to a bogus kernel command line on my 5912OSK board 
that started failing after commit 377485f6244af255b04d662cf19cddbbc4ae4310 
("init: don't try mounting device as nfs root unless type fully matches").


- Paul
