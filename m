From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Avoid discarding sections that might have
	SMP_ON_UP fixups
Date: Fri, 11 Feb 2011 10:13:45 +0000
Message-ID: <20110211101345.GA23785@n2100.arm.linux.org.uk>
References: <20110126124452.GB4232@n2100.arm.linux.org.uk> <20110126172535.GA15983@arm.com> <20110209142211.GA11460@n2100.arm.linux.org.uk> <20110210125624.GA3652@n2100.arm.linux.org.uk> <AANLkTin3+4pwxQRz1J_1B6dJxJm0_5ou0OWteDFZNbo9@mail.gmail.com> <AANLkTinjAHLCMJja8q=bPhRBuoR2DCO_NjDw1qNi5MrU@mail.gmail.com> <20110210144617.GD3652@n2100.arm.linux.org.uk> <AANLkTiks_8hXd=7cKN0jNw=1QGcb=5ZyFu1sEFc0G=Px@mail.gmail.com> <20110210191125.GA12582@n2100.arm.linux.org.uk> <AANLkTim0RRw-xHQYTdHLCXCS_GXkaCiW8y9Fz=jMmwPa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38976 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab1BKKNx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Feb 2011 05:13:53 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTim0RRw-xHQYTdHLCXCS_GXkaCiW8y9Fz=jMmwPa@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 11, 2011 at 09:33:56AM +0000, Dave Martin wrote:
> Agreed -- actually, I suspected we might need to support this.  But I
> don't think solving this problem (= keeping the fixup implementation
> in memory and enhancing the module loader) solved the
> fixups-referencing-sections-discarded-from-vmlinux problem.  These
> seem to be two separate issues.  I am filing to understand something?

They are separate, but related issues.  They both ultimately have the
same cause - the placement of the spinlock code inline rather than
out of line, resulting in fixups appearing all over the place rather
than just in kernel/spinlock.o.
