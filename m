From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 0/5] New mux code for 34xx
Date: Sun, 01 Nov 2009 12:29:53 +0200
Message-ID: <4AED6321.7020002@compulab.co.il>
References: <20091029203124.11843.89983.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:55535 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbZKAK3v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 1 Nov 2009 05:29:51 -0500
In-Reply-To: <20091029203124.11843.89983.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, mike.rapoport@gmail.com

Hi Tony,

Tony Lindgren wrote:
> Hi all,
> 
> Here's an initial version of the new mux code to play with.
> Big thanks to Paul & Benoit for the 34xx mux data!

I've tried your patches, they seem to work just fine on CM-T35.

> To try out the new code, compile a kernel with CONFIG_OMAP_MUX
> and CONFIG_DEBUG_FS and these patches. The series is also
> availabe in the l-o git in mux branch.

[ snip ]

> 
> Comments welcome as always.

There are some comments on patches 2 (Add new style pin multiplexing code for
omap3) and 3 (Add new style pin multiplexing data for 34xx). No nitpicking for
now, but checkpatch.pl is unhappy with the patchset :)


> Regards,
> 
> Tony
> 
> 
> ---
> 
> Mike Rapoport (1):
>       omap2: mux: intoduce omap_mux_{read,write}
> 
> Tony Lindgren (4):
>       omap: mux: Add debugfs support for new mux code
>       omap: mux: Add new style init functions to omap3 board-*.c files
>       omap: mux: Add new style pin multiplexing data for 34xx
>       omap: mux: Add new style pin multiplexing code for omap3
> 
> 
>  arch/arm/mach-omap2/Makefile             |    4 
>  arch/arm/mach-omap2/board-3430sdp.c      |    9 
>  arch/arm/mach-omap2/board-cm-t35.c       |    9 
>  arch/arm/mach-omap2/board-ldp.c          |    9 
>  arch/arm/mach-omap2/board-omap3beagle.c  |    9 
>  arch/arm/mach-omap2/board-omap3evm.c     |    9 
>  arch/arm/mach-omap2/board-omap3pandora.c |    9 
>  arch/arm/mach-omap2/board-overo.c        |    8 
>  arch/arm/mach-omap2/board-rx51.c         |   10 
>  arch/arm/mach-omap2/board-zoom2.c        |    8 
>  arch/arm/mach-omap2/mux.c                |  424 ++++++++
>  arch/arm/mach-omap2/mux.h                |  127 ++
>  arch/arm/mach-omap2/mux34xx.c            | 1552 ++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/mux34xx.h            |  352 +++++++
>  14 files changed, 2533 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/mux.h
>  create mode 100644 arch/arm/mach-omap2/mux34xx.c
>  create mode 100644 arch/arm/mach-omap2/mux34xx.h
> 

-- 
Sincerely yours,
Mike.

