From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 2/3] Add tps65921 chip
Date: Fri, 1 Jul 2011 13:37:26 +0200
Message-ID: <20110701113726.GJ12106@sortiz-mobl>
References: <1308066307-415-1-git-send-email-green@linuxhacker.ru>
 <1308066307-415-3-git-send-email-green@linuxhacker.ru>
 <20110701073557.GF23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22028 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755059Ab1GALhG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 07:37:06 -0400
Content-Disposition: inline
In-Reply-To: <20110701073557.GF23145@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, green@linuxhacker.ru

Hi Tony,

On Fri, Jul 01, 2011 at 12:35:58AM -0700, Tony Lindgren wrote:
> Samuel,
> 
> * green@linuxhacker.ru <green@linuxhacker.ru> [110614 08:42]:
> > From: Oleg Drokin <green@linuxhacker.ru>
> > 
> > Very similar to TPS65920
> > List of differences: http://www.ti.com/litv/pdf/swcu066b
> > 
> > CC: sameo@linux.intel.com
> > Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
> 
> Looks like this one can be merged independently of the rest of the
> Nook patches via your mfd tree. Care to queue this?
I asked Oleg to rebase this patch against my for-next branch as it was not
applying cleanly. But I never got the fixed patch.
I fixed it up now, and it's applied.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
