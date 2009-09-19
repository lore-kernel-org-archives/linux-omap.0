From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] OMAP1/2/3/4: DEBUG_LL run time detection
Date: Sat, 19 Sep 2009 09:40:52 +0100
Message-ID: <20090919084051.GA20296@n2100.arm.linux.org.uk>
References: <1253320780-19396-1-git-send-email-vikram.pandita@ti.com> <1253320780-19396-2-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36691 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932158AbZISIlD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Sep 2009 04:41:03 -0400
Content-Disposition: inline
In-Reply-To: <1253320780-19396-2-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Fri, Sep 18, 2009 at 07:39:39PM -0500, Vikram Pandita wrote:
> The decision of finding the physical address of debug uart is done
> at runtime now, making possible to use a single defconfig for multiple boards.
> 
> This patch gets rid of  menuconfig options of choosing low level debug uarts.

This approach won't work in all cases where the debug functions are called
(which can be before the MMU is enabled.)

The problem is that you can't run C code before the MMU is setup because
C code always encodes absolute address locations, which won't be valid
at that time.

Also, since there is no stack during the initial kernel boot, you can't
stack registers in the LL debug functions.
