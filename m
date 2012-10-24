From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] OMAP: mtd: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Wed, 24 Oct 2012 16:27:17 -0700
Message-ID: <20121024232717.GD11928@atomide.com>
References: <1350935758-9215-1-git-send-email-zonque@gmail.com>
 <1350935758-9215-5-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:51746 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750934Ab2JXX1V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 19:27:21 -0400
Content-Disposition: inline
In-Reply-To: <1350935758-9215-5-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, jon-hunter@ti.com, x0148406@ti.com, paul@pwsan.com, nsekhar@ti.com

* Daniel Mack <zonque@gmail.com> [121022 12:57]:
> This patch adds basic DT bindings for OMAP GPMC.
> 
> The actual peripherals are instanciated from child nodes within the GPMC
> node, and the only type of device that is currently supported is NAND.
> 
> Code was added to parse the generic GPMC timing parameters and some
> documentation with examples on how to use them.
> 
> Successfully tested on an AM33xx board.

That's great, looks good to me. Please repost at least the
binding patch with devicetree-discuss and Rob Herring cc:d
so hopefully we'll get an ack for the binding.

Regards,

Tony
