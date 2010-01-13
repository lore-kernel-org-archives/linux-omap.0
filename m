From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [PATCHv2 0/4] Regulator: OMAP: Removing common code for TWL4030
 from OMAP3- board-evms
Date: Wed, 13 Jan 2010 22:25:59 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E2EB3E3@dbde02.ent.ti.com>
References: <1263287625-10094-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52583 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754931Ab0AMQ4M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 11:56:12 -0500
In-Reply-To: <1263287625-10094-1-git-send-email-anuj.aggarwal@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

Any comments on this version?

Regards,
Anuj Aggarwal

> -----Original Message-----
> From: Aggarwal, Anuj
> Sent: Tuesday, January 12, 2010 2:44 PM
> To: linux-omap@vger.kernel.org
> Cc: broonie@opensource.wolfsonmicro.com; lrg@slimlogic.co.uk; Aggarwal,
> Anuj
> Subject: [PATCHv2 0/4] Regulator: OMAP: Removing common code for TWL4030
> from OMAP3- board-evms
> 
> Sending version 2 of this patch set after taking all those comments. First
> series can be found at:
>   http://marc.info/?l=linux-omap&m=126297346131188&w=2
> 
> This patch set is created to clean up various OMAP3-board-evm files
> and remove common TWL4030 specific regulator suplies and init data
> structs. These structures are instead placed in a new generic file -
> twl4030-pmic.c - and are referenced from the OMAP3 board-evm
> files depending on the platform requirements. Regulator having specific
> supplies or init data structs are not changed in their respective
> board-evms.
> 
> The main advantages of having one common file for these structures
> are redundant code removal, easy maintainability and single copy of
> common structure(s) in case uImage for multiple platforms is built.
> 
> Anuj Aggarwal (4):
>   Regulator: OMAP: Creating TWL4030 file having supplies & init data
>   Regulator: OMAP:Modifying Kconfig/Makefile to choose from available
>     PMICs
>   Regulator: OMAP: Kconfig modified to select TWL4030 for
>     OMAP3-platforms
>   Regulator: OMAP: Use common regulator supplies and init data structs
> 
>  arch/arm/mach-omap2/Kconfig                  |   20 +++
>  arch/arm/mach-omap2/Makefile                 |    1 +
>  arch/arm/mach-omap2/board-3430sdp.c          |  135 ++------------------
>  arch/arm/mach-omap2/board-cm-t35.c           |   47 +------
>  arch/arm/mach-omap2/board-igep0020.c         |   24 +---
>  arch/arm/mach-omap2/board-ldp.c              |   24 +---
>  arch/arm/mach-omap2/board-omap3beagle.c      |   47 +------
>  arch/arm/mach-omap2/board-omap3evm.c         |   47 +------
>  arch/arm/mach-omap2/board-omap3touchbook.c   |   47 +------
>  arch/arm/mach-omap2/board-overo.c            |   23 +---
>  arch/arm/mach-omap2/board-zoom-peripherals.c |   71 +----------
>  arch/arm/mach-omap2/twl4030-pmic.c           |  175
> ++++++++++++++++++++++++++
>  arch/arm/mach-omap2/twl4030-pmic.h           |   34 +++++
>  13 files changed, 277 insertions(+), 418 deletions(-)
>  mode change 100755 => 100644 arch/arm/mach-omap2/board-zoom-peripherals.c
>  create mode 100644 arch/arm/mach-omap2/twl4030-pmic.c
>  create mode 100644 arch/arm/mach-omap2/twl4030-pmic.h

