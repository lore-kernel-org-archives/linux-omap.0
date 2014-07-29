From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] OMAP mailbox cleanup
Date: Tue, 29 Jul 2014 01:59:52 -0700
Message-ID: <20140729085947.GI29045@atomide.com>
References: <1403657023-53897-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18443 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbaG2JBR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2014 05:01:17 -0400
Content-Disposition: inline
In-Reply-To: <1403657023-53897-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Suman Anna <s-anna@ti.com> [140624 17:45]:
> Hi,
> 
> This patch series is mainly a cleanup of the current OMAP mailbox drivers
> in preparation for adding DT support and adoption to the upcoming mailbox
> framework from Jassi Brar [1]. It removes the OMAP1 mailbox driver as there
> are no users for it in the kernel, and consolidates the previous OMAP
> mailbox framework and the OMAP2+ mailbox driver into a single OMAP mailbox
> driver. 
> 
> The last patch also allows the OMAP mailbox driver to support multiple
> instances of the IP (for DRA7xx, which is the first SoC in the OMAP family
> to have more than one System Mailbox IP).
> 
> The patches are based on 3.16-rc2 and do not change any of the functional
> behavior on any OMAP2+ SoCs. The boot logs on various OMAP platforms with
> these patches are at:
>   OMAP2 (SDP2430)           : http://slexy.org/view/s20rOAReeS
>   OMAP3 (BeagleXM)          : http://slexy.org/view/s2QITyvzH9
>   OMAP4 (PandaBoard)        : http://slexy.org/view/s2X9jdZ9Wh
>   OMAP5 (OMAP5 uEVM)        : http://slexy.org/view/s21hZUTYwm
>   DRA7  (DRA7 EVM)          : http://slexy.org/view/s213K7f87s
>   AM33xx (BeagleBone Black) : http://slexy.org/view/s2vB7oxbix
>   AM43xx (AM437x GP EVM)    : http://slexy.org/view/s21rMlUWMg
> 
> [1] https://lkml.org/lkml/2014/6/12/470
> 
> Suman Anna (7):
>   mailbox/omap: use devm_* interfaces
>   mailbox/omap: remove OMAP1 mailbox driver
>   mailbox/omap: remove omap_mbox_type_t from mailbox ops
>   mailbox/omap: simplify the fifo assignment by using macros
>   mailbox/omap: consolidate OMAP mailbox driver
>   mailbox/omap: remove the private mailbox structure
>   mailbox/omap: add a parent structure for every IP instance
> 
>  arch/arm/configs/omap1_defconfig |   2 -
>  drivers/mailbox/Kconfig          |  19 +-
>  drivers/mailbox/Makefile         |   6 +-
>  drivers/mailbox/mailbox-omap1.c  | 203 ------------------
>  drivers/mailbox/mailbox-omap2.c  | 357 -------------------------------
>  drivers/mailbox/omap-mailbox.c   | 444 +++++++++++++++++++++++++++++++--------
>  drivers/mailbox/omap-mbox.h      |  67 ------
>  7 files changed, 360 insertions(+), 738 deletions(-)
>  delete mode 100644 drivers/mailbox/mailbox-omap1.c
>  delete mode 100644 drivers/mailbox/mailbox-omap2.c
>  delete mode 100644 drivers/mailbox/omap-mbox.h

I'll apply these on into omap-for-v3.17/mailbox. Might be a bit
too late for v3.17 so no guarantees these will get merged. But
it removes some old dead code, so that's nice ;)

Regards,

Tony
