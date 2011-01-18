From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
Date: Tue, 18 Jan 2011 14:40:14 +0000
Message-ID: <20110118144014.GE10997@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <20110118143041.GA13576@shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57772 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab1AROkX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 09:40:23 -0500
Content-Disposition: inline
In-Reply-To: <20110118143041.GA13576@shutemov.name>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, Jan 18, 2011 at 04:30:41PM +0200, Kirill A. Shutemov wrote:
> On Mon, Jan 17, 2011 at 07:20:50PM +0000, Russell King - ARM Linux wrote:
> > This patch series reworks the ARMv6/ARMv6K support options, code
> > selection, and bit operations such that it's possible to safely
> > build a kernel which supports ARMv6, ARMv6K, ARMv7 and ARMv7 SMP
> > in one image.
> 
> Is it posible to implement CPU_ARCH_ARMv6K as well for runtime checks?

Err what?  There's no CPU_ARCH_ARMv6K.
