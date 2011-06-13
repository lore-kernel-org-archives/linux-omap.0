From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: pandora: fix NAND support
Date: Mon, 13 Jun 2011 06:49:43 -0700
Message-ID: <20110613134943.GF3352@atomide.com>
References: <1307132643-17432-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:45287 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752516Ab1FMNtq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Jun 2011 09:49:46 -0400
Content-Disposition: inline
In-Reply-To: <1307132643-17432-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Grazvydas Ignotas <notasas@gmail.com> [110603 13:20]:
> Commit d5ce2b65 "omap3630: nand: fix device size to work in polled mode"
> changed values for .devsize in nand platform data, now we have to pass
> NAND_BUSWIDTH_16 instead of '1' to select 16bit NAND.
> 
> Update pandora's platform data accordingly, also specify appropriate
> transfer type.

Thanks adding to fixes.

Tony
