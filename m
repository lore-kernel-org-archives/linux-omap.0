From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] OMAP: omap_device: when 'called from invalid state',
 print state
Date: Thu, 11 Feb 2010 00:17:50 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002110017240.28188@utopia.booyaka.com>
References: <1264532444-22706-1-git-send-email-khilman@deeprootsystems.com> <1264532444-22706-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48065 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab0BKHRv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 02:17:51 -0500
In-Reply-To: <1264532444-22706-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Tue, 26 Jan 2010, Kevin Hilman wrote:

> The omap_device_[enable|idle|shutdown] functions print a warning
> when called from an invalid state.  Print the invalid state in
> the warning messages.  This also uses __func__ to get the function
> name.
> 
> Also, move the entire print string onto a single line to facilitate
> grepping or error messages.  Recent discussions on LKML show
> strong preference for grep-able code vs. strict 80 column limit.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Thanks, queued for 2.6.34.


- Paul
