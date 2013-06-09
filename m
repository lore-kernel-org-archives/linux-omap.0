From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 7/7] mailbox/omap: move the OMAP mailbox framework to
 drivers
Date: Sat, 8 Jun 2013 21:01:35 -0700
Message-ID: <20130609040135.GA1730@kroah.com>
References: <1370656692-41425-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:44942 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab3FIEBH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Jun 2013 00:01:07 -0400
Content-Disposition: inline
In-Reply-To: <1370656692-41425-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Jassi Brar <jaswinder.singh@linaro.org>, Loic Pallardy <loic.pallardy@st.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jun 07, 2013 at 08:58:12PM -0500, Suman Anna wrote:
> The mailbox hardware (in OMAP) uses a queued mailbox interrupt
> mechanism that provides a communication channel between processors
> through a set of registers and their associated interrupt signals
> by sending and receiving messages.
> 
> The OMAP mailbox framework/driver code is moved to be under
> drivers/mailbox, in preparation for adapting to a common mailbox
> driver framework. This allows the build for OMAP mailbox to be
> enabled (it was disabled during the multi-platform support).
> 
> As part of the migration from plat and mach code:
> - Kconfig symbols have been renamed to build OMAP1 or OMAP2+ drivers.
> - mailbox.h under plat-omap/plat/include has been split into a public
>   and private header files. The public header has only the API related
>   functions and types.
> - The module name mailbox.ko from plat-omap is changed to
>   omap-mailbox.ko
> - The module name mailbox_mach.ko from mach-omapX is changed as
>     mailbox_omap1.ko for OMAP1
>     mailbox_omap2.ko for OMAP2+
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@copitl.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>

Staging part:
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
