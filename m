From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 0/2 v2] ARM: OMAP3: add support for cm-t35 board
Date: Mon, 19 Oct 2009 15:59:24 +0200
Message-ID: <4ADC70BC.1060002@compulab.co.il>
References: <cover.1255505874.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:42911 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756236AbZJSN7V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Oct 2009 09:59:21 -0400
Received: from [62.90.235.247] (helo=zimbra-mta.compulab.co.il)
	by compulab.site5.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>)
	id 1Mzslh-0002pF-Pu
	for linux-omap@vger.kernel.org; Mon, 19 Oct 2009 08:59:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id C75009A034F
	for <linux-omap@vger.kernel.org>; Mon, 19 Oct 2009 15:59:24 +0200 (IST)
In-Reply-To: <cover.1255505874.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Rapoport <mike@compulab.co.il>

Mike Rapoport wrote:
> The following patches add support for CompuLab CM-T35 board.

Any comments on these?

> --
> v2 changes:
>  remove EHCI-related code
>  move usb_musb_init to cm_t35_init
> --
> 
> Changes since commit 2caa731819a633bec5a56736e64c562b7e193666:
>   Linus Torvalds (1):
>           Merge branch 'for-linus' of git://git.kernel.org/.../jbarnes/pci-2.6
> 
> Mike Rapoport (2):
>   ARM: OMAP3: add CompuLab CM-T35 module
>   ARM: OMAP3: cm-t35: add defconfig
> 
>  arch/arm/configs/cm_t35_defconfig  | 1733 ++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/Kconfig        |    4 +
>  arch/arm/mach-omap2/Makefile       |    2 +
>  arch/arm/mach-omap2/board-cm-t35.c |  459 ++++++++++
>  4 files changed, 2198 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/configs/cm_t35_defconfig
>  create mode 100644 arch/arm/mach-omap2/board-cm-t35.c



-- 
Sincerely yours,
Mike.

