From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/3]  OMAP4: SMP: Patch series
Date: Sat, 16 May 2009 11:34:13 +0100
Message-ID: <20090516103413.GS15328@n2100.arm.linux.org.uk>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B4687E57@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36322 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537AbZEPKeW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 06:34:22 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B4687E57@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, May 07, 2009 at 12:47:30PM +0530, Shilimkar, Santosh wrote:
> [PATCH 1/3]OMAP4: SMP: Add OMAP4430 SMP board files
> [PATCH 2/3]OMAP4: SMP: Add mpu timer support for OMAP4430
> [PATCH 3/3]OMAP4: SMP: Enable SMP support for OMAP4430

Overall comment - you seem to be re-using ARMs SCU and TWD blocks in
OMAP, which is fine.  If this is the way other silicon vendors are
going for SMP support, we should move that out of platform dependent
code, so we don't end up with everyone having their own duplicated
implementations of this code.
