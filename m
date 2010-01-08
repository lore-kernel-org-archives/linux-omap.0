From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/6] Regulator: Removing common code for TWL4030 PMIC from various OMAP3 board-evms
Date: Fri, 08 Jan 2010 14:26:47 -0800
Message-ID: <874omws060.fsf@deeprootsystems.com>
References: <1262973448-32439-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f211.google.com ([209.85.217.211]:33007 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180Ab0AHW0u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 17:26:50 -0500
Received: by gxk3 with SMTP id 3so8974553gxk.1
        for <linux-omap@vger.kernel.org>; Fri, 08 Jan 2010 14:26:49 -0800 (PST)
In-Reply-To: <1262973448-32439-1-git-send-email-anuj.aggarwal@ti.com> (Anuj Aggarwal's message of "Fri\,  8 Jan 2010 23\:27\:28 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk

Anuj Aggarwal <anuj.aggarwal@ti.com> writes:

> Based on the discussions and feedback received, this patch set is
> created which cleans up various OMAP3-board-evm files and removes
> common TWL4030 specific regulator suuplies and init data structs.
> These structures are instead placed in a new file - 
> board-omap35x-twl4030-pmic.c and are referenced from the board-evm

Why is this omap35x?  You seem to be using this from omap34xx board
files as well.

I don't think you need the board-omap* prefix at all.  Why not just
call it twl4030-pmic.c.

There has been some proposals to unify the twl4030 scripts as well by
Lesley, and this new file would be a logical place for those as well.

Kevin


> files depending on the platform requirements. Regulator having specific
> supplies or init data structs are not changed in their respective
> board-evms.
>
> The main advantages of having one common file for these structures
> are redundant code removal, easy maintainability and single copy of 
> common structure(s) in case uImage for multiple platforms is built.
>
> Please see the following links for previous discussions:
>   http://marc.info/?l=linux-omap&m=125795487111175&w=2
>   http://marc.info/?l=linux-omap&m=125795068502904&w=2 
>
> I have tested these patches on OMAP3EVM and the image boots fine. I
> have compile-tested them for SDP3430 and all OMAP platforms (using
> omap3_defconfig) and the build went fine. If someone can test them
> on their hardware, that would be great !!!
>
> Anuj Aggarwal (6):
>   Regulator: Creating TWL4030 specific file having supplies & init data
>   Regulator: Removing the common supplies and regulator init data
>     structs
>   Regulator: Use common regulator supplies and init data structs
>   Regulator: Modifying Kconfig to choose from the available PMICs
>   Regulator: Kconfig modified to select TWL4030 for OMAP3 based
>     platforms
>   Regulator: Makefile modified to include TWL4030-PMIC specific file
>
>  arch/arm/mach-omap2/Kconfig                      |   20 +++
>  arch/arm/mach-omap2/Makefile                     |    1 +
>  arch/arm/mach-omap2/board-3430sdp.c              |  146 +++---------------
>  arch/arm/mach-omap2/board-cm-t35.c               |   52 ++-----
>  arch/arm/mach-omap2/board-igep0020.c             |   26 +---
>  arch/arm/mach-omap2/board-ldp.c                  |   26 +---
>  arch/arm/mach-omap2/board-omap35x-twl4030-pmic.c |  175 ++++++++++++++++++++++
>  arch/arm/mach-omap2/board-omap3beagle.c          |   52 ++-----
>  arch/arm/mach-omap2/board-omap3evm.c             |   63 ++------
>  arch/arm/mach-omap2/board-omap3pandora.c         |   52 ++-----
>  arch/arm/mach-omap2/board-omap3touchbook.c       |   52 ++-----
>  arch/arm/mach-omap2/board-overo.c                |   26 +---
>  arch/arm/mach-omap2/board-zoom-peripherals.c     |   78 ++--------
>  13 files changed, 304 insertions(+), 465 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-omap35x-twl4030-pmic.c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
