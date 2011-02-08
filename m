From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
Date: Tue, 8 Feb 2011 17:47:18 +0100
Message-ID: <201102081747.18674.arnd@arndb.de>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org> <201102081615.15713.arnd@arndb.de> <20110208162515.GB6188@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57184 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755024Ab1BHQr2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 11:47:28 -0500
In-Reply-To: <20110208162515.GB6188@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Tuesday 08 February 2011 17:25:16 Russell King - ARM Linux wrote:
> On Tue, Feb 08, 2011 at 04:15:15PM +0100, Arnd Bergmann wrote:
> > But that doesn't work if you build a combined v5/v6/v7 kernel, because
> > v5 supports neither form, right? I think to do that, it needs the
> > same kind of abstraction that we have for a number of other things
> > like cache management in arch/arm/mm/.
> 
> The options are kernels which support v3-v5 or v6-v7.  There's too big
> a change between v5 and v6 to combine those into one kernel.

Ah, good to know. I never realized this with the common binary discussions.
Building for the versatile/realview platform makes it possible to select
any of ARM926 and the v6/v6k/v7 CPUs, as well as ARM7TDMI in the same
kernel config, so I assumed that this was actually a valid configuration
aside from bugs.

Would an attempt to make a combined v5/v6 kernel result in unacceptably
bad code, or is this just too much work for anyone to be bothered with
and little practical value?

	Arnd
