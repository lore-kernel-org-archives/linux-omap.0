From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
Date: Thu, 15 Nov 2012 13:36:23 +0000
Message-ID: <20121115133623.GG3332@n2100.arm.linux.org.uk>
References: <20121114185335.GU6801@atomide.com> <50A3EBCD.3040801@ti.com> <20121114202244.GE3332@n2100.arm.linux.org.uk> <20121114203221.GA6801@atomide.com> <50A413D4.7000405@gmail.com> <20121114222159.GB6801@atomide.com> <50A43D58.5030404@gmail.com> <20121115110137.GA25985@arm.com> <CACY+gR3PurUofCbUeG40B6vXqXAoHrMmbOQSuwAGoc1LS8XXJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42925 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767735Ab2KONgq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 08:36:46 -0500
Content-Disposition: inline
In-Reply-To: <CACY+gR3PurUofCbUeG40B6vXqXAoHrMmbOQSuwAGoc1LS8XXJQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Rob Herring <robherring2@gmail.com>, Tony Lindgren <tony@atomide.com>, Dave Martin <dave.martin@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jon Hunter <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Nov 15, 2012 at 02:41:43PM +0200, Siarhei Siamashka wrote:
> BTW, I always wondered about what could be preventing TI and the other
> silicon vendors from using something like an SMC API based on
> asymmetric cryptography?

The answer is... nothing.  But it didn't happen and we're stuck with the
consequences of that.
