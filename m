From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 0/4] Create infrastructure for running C code from SRAM.
Date: Fri, 6 Sep 2013 12:14:08 +0100
Message-ID: <20130906111408.GI25647@n2100.arm.linux.org.uk>
References: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com> <52278F84.2080509@elopez.com.ar> <CA+Bv8XaHonrpeNZ6tRCyqpMK1bzgpDTqvLyrsLWEyMY_ky6apQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53608 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab3IFLOZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Sep 2013 07:14:25 -0400
Content-Disposition: inline
In-Reply-To: <CA+Bv8XaHonrpeNZ6tRCyqpMK1bzgpDTqvLyrsLWEyMY_ky6apQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, mans@mansr.com, Shawn Guo <shawn.guo@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Philipp Zabel <p.zabel@pengutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Wed, Sep 04, 2013 at 02:47:51PM -0700, Russ Dill wrote:
> I think this is already taken care of by the way sram.c is using
> genalloc. The allocation returned should be aligned to 32 bytes. The
> thumb bit shouldn't be an issue as code is copied based on the start
> and end makers made by the linker. I may need to add .align statements
> in the linker so that the start and end markers for the copied code
> are aligned to at least 8 bytes.

I think you need to read up on what fncpy does... there's more to it
than just merely copying code at an appropriate alignment.
