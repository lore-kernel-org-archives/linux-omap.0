From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: fix section mismatches in usb-host.c
Date: Tue, 3 Apr 2012 11:09:35 -0700
Message-ID: <20120403180935.GG8240@atomide.com>
References: <1332773470-22800-1-git-send-email-grinberg@compulab.co.il>
 <20120327085426.GI7379@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:15514 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568Ab2DCSJl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Apr 2012 14:09:41 -0400
Content-Disposition: inline
In-Reply-To: <20120327085426.GI7379@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Felipe Balbi <balbi@ti.com> [120327 01:57]:
> On Mon, Mar 26, 2012 at 04:51:10PM +0200, Igor Grinberg wrote:
> > Fix the below section mismatch warning and alike:
> > 
> > WARNING: vmlinux.o(.text+0x281d4): Section mismatch in reference from
> > the function setup_ehci_io_mux() to the function
> > .init.text:omap_mux_init_signal()
> > The function setup_ehci_io_mux() references
> > the function __init omap_mux_init_signal().
> > This is often because setup_ehci_io_mux lacks a __init
> > annotation or the annotation of omap_mux_init_signal is wrong.
> > 
> > Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> 
> Acked-by: Felipe Balbi <balbi@ti.com>

Thanks applying into fixes.

Tony
