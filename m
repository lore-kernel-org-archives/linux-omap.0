From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/2]  OMAP4: Patch series
Date: Sat, 16 May 2009 11:16:47 +0100
Message-ID: <20090516101647.GN15328@n2100.arm.linux.org.uk>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B4687E57@dbde02.ent.ti.com> <54599.192.168.10.89.1242109175.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52950 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990AbZEPKQ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 06:16:56 -0400
Content-Disposition: inline
In-Reply-To: <54599.192.168.10.89.1242109175.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Syed Rafiuddin <rafiuddin.syed@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, May 12, 2009 at 11:49:35AM +0530, Syed Rafiuddin wrote:
> This patch series enables McBSP and UART4 support for OMAP4430 development
> platform.
> 
> The series contains:
> [PATCH 1/2]OMAP4: McBSP support for OMAP4430
> [PATCH 2/2]OMAP4: UART4 support for OMAP4430

Not nice - you've replied to Santosh's SMP patch series with your
own patch series.  That means your patches are grouped with Santosh's
SMP patches...

Please don't do this.

Santosh - I don't seem to have your SMP patch set, just your introductory
message for them.

Syed - I only have your first patch.
