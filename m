From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am437x-gp-evm: Boot fixes
Date: Tue, 22 Apr 2014 12:01:32 -0700
Message-ID: <20140422190132.GA12204@atomide.com>
References: <1398192739-8901-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22130 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbaDVTBk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2014 15:01:40 -0400
Content-Disposition: inline
In-Reply-To: <1398192739-8901-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, bcousson@baylibre.com, Sekhar Nori <nsekhar@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>

* Dave Gerlach <d-gerlach@ti.com> [140422 11:52]:
> This patch, along with patch here [1], fixes boot for am437x-gp-evm. The
> bootloader configures gpio5_7 to control the DDR3 termination regulator,
> the linked patch prevents that gpio bank from being reset and losing
> the previously configured state, and this patch binds the gpio to a
> regulator so the kernel is aware of the state of the gpio.
> 
> [1] https://www.mail-archive.com/linux-omap@vger.kernel.org/msg102941.html

Setting up the GPIO regulator makes sense to me. But the hack in the
link above is potentially a nasty time bomb for anybody trying to
use GPIO bank 5 on that board.

What tests have been done that the GPIO bank behaves properly when
it's not reset?

Regards,

Tony
