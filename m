From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 0/3] omap3: cm-t35: enable display subsystem
Date: Sun, 06 Dec 2009 17:33:41 +0200
Message-ID: <4B1BCED5.7050908@compulab.co.il>
References: <cover.1259666203.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:33314 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933824AbZLFPdj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 6 Dec 2009 10:33:39 -0500
In-Reply-To: <cover.1259666203.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mike Rapoport <mike@compulab.co.il>

Tony,
Any chance this can go to 2.6.33?

Mike Rapoport wrote:
> This patchset adds display support for CM-T35 board.
> 
> The following changes since commit 82f1d8f22f2c65e70206e40a6f17688bf64a892c:
>   Tony Lindgren (1):
>         Merge branch 'for-next' of git://gitorious.org/linux-omap-dss2/linux
> 
> Mike Rapoport (3):
>   OMAP: DSS2: add Toppoly TDO35S panel
>   omap3: cm-t35: add DSS2 display support
>   omap3: cm-t35: update defconfig for DSS2
> 
>  arch/arm/configs/cm_t35_defconfig                  |   82 +++++++-
>  arch/arm/mach-omap2/board-cm-t35.c                 |  234 +++++++++++++++++++-
>  drivers/video/omap2/displays/Kconfig               |    6 +
>  drivers/video/omap2/displays/Makefile              |    1 +
>  .../video/omap2/displays/panel-toppoly-tdo35s.c    |  112 ++++++++++
>  5 files changed, 430 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/video/omap2/displays/panel-toppoly-tdo35s.c
> 
> 

-- 
Sincerely yours,
Mike.

