From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] ARM: OMAP3: gpmc: add BCH ecc api and modes
Date: Tue, 8 May 2012 17:29:28 -0700
Message-ID: <20120509002927.GF5088@atomide.com>
References: <1335442669-13474-1-git-send-email-ivan.djelic@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24035 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699Ab2EIA3a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 20:29:30 -0400
Content-Disposition: inline
In-Reply-To: <1335442669-13474-1-git-send-email-ivan.djelic@parrot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivan Djelic <ivan.djelic@parrot.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org

* Ivan Djelic <ivan.djelic@parrot.com> [120426 05:23]:
> Hello,
> 
> Here is version 3 of this patch after review from Tony Lindgren.
> This version adds a separate initialization function mostly to check CPU
> compatibility. This check cannot be done in gpmc_enable_hwecc_bch() (which
> is meant to be called from mtd function ecc.hwctl) because ecc.hwctl is
> not called before the first NAND read access, and it cannot return an error
> status.

Thanks applying into devel-gpmc branch.

Tony
