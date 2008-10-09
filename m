From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP2 not booting in 2.6.27-rc9?
Date: Thu, 9 Oct 2008 05:58:44 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810090558170.1405@utopia.booyaka.com>
References: <20081009103258.cbace620.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33800 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756784AbYJIL6i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 07:58:38 -0400
In-Reply-To: <20081009103258.cbace620.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

On Thu, 9 Oct 2008, Jarkko Nikula wrote:

> At least N810 hangs somewhere executing local_flush_tlb_all() in
> omap_map_sram. Last printk is before that call.

Broken on 2430SDP too.  Will look further.


- Paul
