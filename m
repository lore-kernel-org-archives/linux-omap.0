From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] nand support on omap3 boards
Date: Fri, 28 May 2010 19:18:49 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030DAA08AD@dbde02.ent.ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
 <1271180246-31779-1-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51735 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757273Ab0E1Nsz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 May 2010 09:48:55 -0400
In-Reply-To: <1271180246-31779-1-git-send-email-s-ghorai@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Vimal Singh <vimal.newwork@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hello Tony,

I need your comment/input - whether we need an additional file for NAND support in ZOOM2/3?

In current codebase has a board-sdp-flash.c file. I think we can remove "-sdp-" from board-sdp-flash.c and reuse the file for ZOOM boards or any other upcoming board(s).

Advantage: 
  a. No need to add any additional file like board-zoom-flash.c 
  b. And the existing board-sdp-flash.c is very small and easily re-use for zoom boards easily.

Disadvantage:
  a. Few additional functions in the same file for NOR and OneNAND is not applicable for zoom.
  b. rename the file board-sdp-flash.c to board-flash.c
  c. Remove the static of board_nand_init() and additional one line for zoom board checking.

Please let me know your opinion. 

Regards,
Ghorai

> -----Original Message-----
> From: Ghorai, Sukumar
> Sent: Tuesday, April 13, 2010 11:07 PM
> To: linux-omap@vger.kernel.org
> Cc: Ghorai, Sukumar
> Subject: [PATCH] nand support on omap3 boards
> 
>    The following set of patches applies on top of the Tony's master
> branch.
>    And these are the patches required to enable nand (nor and onenand for
> sdp
>    only) for different platform.
> 
> Sukumar Ghorai (3):
>   OMAP: ZOOM: Introducing 'board-zoom-flash.c'
>   omap3: add support for NAND on zoom2 board
>   omap3: add support for NAND on zoom3 board
>   omap-3630-sdp : Add support for Flash
>   omap-3630-sdp: enable Flash device support
>   omap3: add support for NAND on LDP board
>   zoom2: enable NAND support
>   zoom3: enable NAND support
> 
>  arch/arm/configs/omap_3630sdp_defconfig       |   77 +++++++++++++++++-
>  arch/arm/configs/omap_zoom2_defconfig         |   90
> ++++++++++++++++++++-
>  arch/arm/configs/omap_zoom3_defconfig         |   90
> ++++++++++++++++++++-
>  arch/arm/mach-omap2/Makefile                  |    4 +
>  arch/arm/mach-omap2/board-3630sdp.c           |  110
> +++++++++++++++++++++++++
>  arch/arm/mach-omap2/board-ldp.c               |   41 +++++++++
>  arch/arm/mach-omap2/board-sdp-flash.c         |    2 +
>  arch/arm/mach-omap2/board-zoom-flash.c        |   82 ++++++++++++++++++
>  arch/arm/mach-omap2/board-zoom2.c             |   49 +++++++++++
>  arch/arm/mach-omap2/board-zoom3.c             |   48 +++++++++++
>  arch/arm/mach-omap2/include/mach/board-zoom.h |   11 +++
>  11 files changed, 601 insertions(+), 3 deletions(-) create mode 100644
> arch/arm/mach-omap2/board-zoom-flash.c

