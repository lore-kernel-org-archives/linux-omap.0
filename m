From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/15] ARM: OMAP2+: mailbox: Add an API for flushing
 the FIFO
Date: Fri, 2 Nov 2012 12:00:04 -0700
Message-ID: <20121102190002.GA15766@atomide.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-2-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:27779 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932260Ab2KBTAI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Nov 2012 15:00:08 -0400
Content-Disposition: inline
In-Reply-To: <1351859566-24818-2-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com

* Vaibhav Bedia <vaibhav.bedia@ti.com> [121102 05:35]:
> On AM33XX, the mailbox module between the MPU and the
> WKUP-M3 co-processor facilitates a one-way communication.
> MPU uses the assigned mailbox sub-module to issue the
> interrupt to the WKUP-M3 co-processor which then goes
> and reads the the IPC data from registers in the control
> module.
> 
> WKUP-M3 is in the L4_WKUP and does not have any access to
> the Mailbox module. Due to this limitation, the MPU is
> completely responsible for FIFO maintenance and interrupt
> generation. MPU needs to ensure that the FIFO does not
> overflow by reading by the assigned mailbox sub-module.
> 
> This patch adds an API in the mailbox code which the MPU
> can use to empty the FIFO by issuing a readback command.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
>  arch/arm/mach-omap2/mailbox.c             |   42 ++++++++++++++++++++---------
>  arch/arm/plat-omap/include/plat/mailbox.h |    3 ++
>  arch/arm/plat-omap/mailbox.c              |   35 ++++++++++++++++++++++++

Patches have been posted to move the mailbox related
files out of arch/arm, so you'll have to update those
for that. Please see thread "[PATCH 0/2] ARM: OMAP:
mailbox out of plat code" for more information.

Regards,

Tony
