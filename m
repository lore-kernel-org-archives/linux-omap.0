From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/10] OMAP DSS related board changes
Date: Mon, 26 Sep 2011 09:37:33 +0300
Message-ID: <1317019053.1956.10.camel@deskari>
References: <1316506706-18941-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:52298 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751099Ab1IZGhi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 02:37:38 -0400
Received: by mail-fx0-f54.google.com with SMTP id 9so10227824fxg.27
        for <linux-omap@vger.kernel.org>; Sun, 25 Sep 2011 23:37:37 -0700 (PDT)
In-Reply-To: <1316506706-18941-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

On Tue, 2011-09-20 at 11:18 +0300, Tomi Valkeinen wrote:
> Hi Tony,
> 
> Here is a bunch of board file patches related to DSS. They have all been sent
> for review earlier, and are currently in my tree. Some of them depend on DSS
> driver changes, so I'd like to keep them there to avoid compilation errors
> (these won't compile if you apply them without patches from DSS tree).
> 
> Can you give your ack for these? Alternatively we can see which of these could
> go through your tree and I can make a new set.

Tony, ping. I'd like to get these in for 3.2, as many DSS driver patches
depend on some of these.

 Tomi

> 
>  Tomi
> 
> Thomas Weber (1):
>   OMAP: Devkit8000: Change lcd driver to AT070TN83
> 
> Tomi Valkeinen (9):
>   OMAP: DSS2: Change DSI device naming
>   OMAP4: TWL: Add common omapdss supplies
>   OMAP: DSS2: HDMI: use default dividers
>   OMAP: use dvi panel driver instead of generic-dpi
>   OMAP: stalker: Remove LCD device from board file
>   OMAP: Add DDC i2c_bus_num to board files
>   OMAP: 4430SDP: Remove unneeded lcd config
>   OMAP4: 4430SDP: Add panel support to board file
>   OMAP4: 4430SDP: Add picodlp support to board file
> 
>  arch/arm/mach-omap2/board-3430sdp.c      |    7 +-
>  arch/arm/mach-omap2/board-4430sdp.c      |  208 ++++++++++++++++++++++++++----
>  arch/arm/mach-omap2/board-am3517evm.c    |    6 +-
>  arch/arm/mach-omap2/board-cm-t35.c       |    6 +-
>  arch/arm/mach-omap2/board-devkit8000.c   |   10 +-
>  arch/arm/mach-omap2/board-igep0020.c     |    8 +-
>  arch/arm/mach-omap2/board-omap3beagle.c  |    8 +-
>  arch/arm/mach-omap2/board-omap3evm.c     |    7 +-
>  arch/arm/mach-omap2/board-omap3pandora.c |    2 +-
>  arch/arm/mach-omap2/board-omap3stalker.c |   40 +------
>  arch/arm/mach-omap2/board-omap4panda.c   |    8 +-
>  arch/arm/mach-omap2/board-overo.c        |    7 +-
>  arch/arm/mach-omap2/display.c            |    6 +-
>  arch/arm/mach-omap2/twl-common.c         |   11 ++-
>  14 files changed, 230 insertions(+), 104 deletions(-)
> 


