From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] ARM: arch timer: Export 'read_current_timer' symbol
Date: Wed, 3 Oct 2012 10:13:10 +0100
Message-ID: <20121003091310.GB22445@mudshark.cambridge.arm.com>
References: <20121003005218.GA23874@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:43707 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753057Ab2JCJPK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Oct 2012 05:15:10 -0400
Content-Disposition: inline
In-Reply-To: <20121003005218.GA23874@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <rmk+kernel@arm.linux.org.uk>, jonaus01@arm.com

Hi Mark,

On Wed, Oct 03, 2012 at 01:52:18AM +0100, Mark A. Greer wrote:
> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> Commit 923df96b9f31b7d08d8438ff9677326d9537accf
> (ARM: 7451/1: arch timer: implement read_current_timer and get_cycles)
> modifies get_cycles() such that it calls read_current_timer().
> Unfortunately, the 'read_current_timer' symbol is not exported so when
> a driver that calls get_cycles() is built as a module, an undefined
> reference error occurs.
> 
> A good example is the crypto/tcrypt.c (CONFIG_CRYPTO_TEST) driver
> because it calls get_cycles() and can only be built as a module.
> 
> Fix this error by exporting the 'read_current_timer' symbol.

This was already reported over on the kernel-janitors list, I assumed they'd
CC'd LAK, but it looks like it didn't happen.

  http://marc.info/?l=kernel-janitors&m=134910841909057&w=2

Anyway, I've got a fix in the works (I don't think you need the ifdef).

Will
