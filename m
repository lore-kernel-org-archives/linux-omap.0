From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] OMAP2+: Fix debug section mistmatch warnings
Date: Wed, 1 Jun 2011 00:13:59 -0700
Message-ID: <20110601071359.GV11352@atomide.com>
References: <1306907896-28789-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:52556 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755084Ab1FAHOB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 03:14:01 -0400
Content-Disposition: inline
In-Reply-To: <1306907896-28789-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, Nishant Kamat <nskamat@ti.com>

* Govindraj.R <govindraj.raja@ti.com> [110531 22:54]:
> Fix the below debug section mismatch warnings.
> while compiling kernel with CONFIG_DEBUG_SECTION_MISMATCH=y
> 
> WARNING: vmlinux.o(.data+0x38638): Section mismatch in reference from the
> variable serial*_data to the (unknown reference) .init.data:(unknown)
> The variable serial*_data references
> the (unknown reference) __initdata (unknown)
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

These should be already fixed by an earlier patch. Can you please
check against our devel-fixes branch?

Tony
