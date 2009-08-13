From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Thu, 13 Aug 2009 18:33:27 +0100
Message-ID: <20090813173327.GA14872@n2100.arm.linux.org.uk>
References: <0680EC522D0CC943BC586913CF3768C00378FF3971@dbde02.ent.ti.com> <20090807220016.GG31543@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C5B3A@dbde02.ent.ti.com> <20090808170300.GA23481@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C64CF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59950 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755255AbZHMRdf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 13:33:35 -0400
Content-Disposition: inline
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003790C64CF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Aug 13, 2009 at 10:51:43PM +0530, Syed Mohammed, Khasim wrote:
> <1>Unable to handle kernel paging request at virtual address c5cef000 Unable to handle kernel paging request at virtual address c5cef000
> 
> Internal error: Oops: 805 [#4]
> Internal error: Oops: 805 [#4]
> <d>Modules linked in:Modules linked in: cmemk cmemk

Please.  If you've got the kernel booting.  Turn off printascii support.
This oops dump is almost unreadable as a result of keeping printascii
support enabled.
