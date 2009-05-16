From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] OMAP4: SMP: Add OMAP4430 SMP board files
Date: Sat, 16 May 2009 11:31:30 +0100
Message-ID: <20090516103130.GR15328@n2100.arm.linux.org.uk>
References: <1241681366-21094-1-git-send-email-santosh.shilimkar@ti.com> <04c801c9cfa0$4563dfa0$LocalHost@wipultra793> <EAF47CD23C76F840A9E7FCE10091EFAB02B4688490@dbde02.ent.ti.com> <001801c9cfa4$0cf99840$LocalHost@wipultra793> <EAF47CD23C76F840A9E7FCE10091EFAB02B476B68B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36320 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbZEPKbl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 06:31:41 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B476B68B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "V, Hemanth" <hemanthv@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, May 08, 2009 at 12:27:33PM +0530, Shilimkar, Santosh wrote:
> This is done using __enable_mmu in head.S. Bye the way even if the
> u-boot don't enable I-cache , D-caches, kernel does that anyways
> depending on settings.

uboot should not be calling the kernel with caches enabled.  This
is well documented.
