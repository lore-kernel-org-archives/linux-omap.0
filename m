From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Avoid discarding sections that might have
	SMP_ON_UP fixups
Date: Wed, 9 Feb 2011 14:22:11 +0000
Message-ID: <20110209142211.GA11460@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <E1PeueP-0003SR-03@rmk-PC.arm.linux.org.uk> <AANLkTinnhivretaRHpYwCYouk-_jWKZQEo7x4sbheJVL@mail.gmail.com> <20110125165919.GD17286@n2100.arm.linux.org.uk> <AANLkTimK06nJPtQoym3HxXeDD-s4nUrN0vWjp_JcgTjx@mail.gmail.com> <20110125174636.GE17286@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1101251618230.8580@xanadu.home> <AANLkTi=zVsr8G=eYfp7v_QQvBBDCX+Es+T-4c4Fu=QVF@mail.gmail.com> <20110126124452.GB4232@n2100.arm.linux.org.uk> <20110126172535.GA15983@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59864 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755465Ab1BIOWW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 09:22:22 -0500
Content-Disposition: inline
In-Reply-To: <20110126172535.GA15983@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dave P. Martin" <dave.martin@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jan 26, 2011 at 05:25:35PM +0000, Dave P. Martin wrote:
> SMP_ON_UP fixups lead to vmlinux link errors if those sections are
> discarded at link-time.  In particular this may happen for built-in
> __exit stuff.
> 
> This patch modifies the vmlinux linker script to reduce the amount
> of discarded sections, and tries to make sure that __exit sections
> are kept in.
> 
> This is a hack and probably wrong!  Further discussion is needed.  

Can you send the configuration which you see this problem with?
I've tried to build a kernel which inlines the spinlocks, but I find
that's not possible, so I'm doubting whether any fix is required for
mainline.
