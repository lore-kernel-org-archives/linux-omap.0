From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] [OMAP] Mark Beagleboard-xM MMC bus as 4-bit
Date: Tue, 8 May 2012 17:14:41 -0700
Message-ID: <20120509001440.GB5088@atomide.com>
References: <20120507203139.GL5088@atomide.com>
 <1336443849-22753-1-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63446 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab2EIAOm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 20:14:42 -0400
Content-Disposition: inline
In-Reply-To: <1336443849-22753-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org

* Russ Dill <Russ.Dill@ti.com> [120507 19:27]:
> On Beagleboard-xM (all revisions) only MMC1_DAT0-MMC1_DAT3 are wired up.
> Tested on Beagleboard-xM Rev C1 and Beagleboard Rev B4.
> 
> v2 - Moved logic into omap3_beagle_init_rev

Thanks applying into board branch.

Tony
