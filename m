From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
Date: Tue, 18 Jan 2011 16:44:52 +0200
Message-ID: <20110118144452.GB13576@shutemov.name>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <20110118143041.GA13576@shutemov.name>
 <20110118144014.GE10997@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from shutemov.name ([188.40.19.243]:60129 "EHLO shutemov.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045Ab1AROox (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Jan 2011 09:44:53 -0500
Content-Disposition: inline
In-Reply-To: <20110118144014.GE10997@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, Jan 18, 2011 at 02:40:14PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 18, 2011 at 04:30:41PM +0200, Kirill A. Shutemov wrote:
> > On Mon, Jan 17, 2011 at 07:20:50PM +0000, Russell King - ARM Linux wrote:
> > > This patch series reworks the ARMv6/ARMv6K support options, code
> > > selection, and bit operations such that it's possible to safely
> > > build a kernel which supports ARMv6, ARMv6K, ARMv7 and ARMv7 SMP
> > > in one image.
> > 
> > Is it posible to implement CPU_ARCH_ARMv6K as well for runtime checks?
> 
> Err what?  There's no CPU_ARCH_ARMv6K.

I some cases we need runtime check for K extention (see exceptions_init())
Is there any facility for it?

-- 
 Kirill A. Shutemov
