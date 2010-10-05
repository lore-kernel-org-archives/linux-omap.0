From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 00/10] OMAP: SCM/McBSP/clock: branch integration patches
 for 2.6.37
Date: Tue, 5 Oct 2010 15:52:42 +0300
Message-ID: <20101005155242.20900538.jhnikula@gmail.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36464 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab0JEMwH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 08:52:07 -0400
Received: by ewy23 with SMTP id 23so2443288ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 05 Oct 2010 05:52:06 -0700 (PDT)
In-Reply-To: <20101001213119.1408.65395.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Fri, 01 Oct 2010 15:34:45 -0600
Paul Walmsley <paul@pwsan.com> wrote:

> mach-omap2 (as the SCM only exists on OMAP2+ systems).  The McBSP
> parent fclk and signal muxing changes have received only light
> testing, so any help from OMAP ASoc experts here is appreciated.
> 
Looks good to me. I pointed out one bug but as these are already in
linux-omap I sent a fix for it and two minor cleanups [1].

> Paul Walmsley (10):
>       OMAP2+: Kconfig: disallow builds for boards that don't use the currently-selected SoC
>       OMAP2420: CTRL: fix OMAP242X_CTRL_REGADDR macro
>       OMAP2420: clock: add MCBSP_CLKS node and clkdev aliases
>       OMAP2430: clock: add MCBSP_CLKS node and clkdev aliases
>       OMAP3xxx: clock: add clkdev aliases for McBSP fclk source switching
>       OMAP: McBSP: implement McBSP CLKR and FSR signal muxing via mach-omap2/mcbsp.c
>       OMAP: McBSP: implement functional clock switching via clock framework
>       OMAP: split plat-omap/common.c
>       OMAP: control: move plat-omap/control.h to mach-omap2/control.h
>       OMAP2+: clock: reduce the amount of standard debugging while disabling unused clocks
> 
Patches 3-5 are doing the right thing AFAIK the OMAP clock framework.

For patches 6-7 you could have my ack.
Acked-by: Jarkko Nikula <jhnikula@gmail.com>

As they are touching also sound/soc/omap/omap-mcbsp.c, an ack from Mark
and Liam are needed. Links to patches 6 and 7 below and my fixes on top
of them [1].

http://marc.info/?l=linux-omap&m=128596931117788&w=2
http://marc.info/?l=linux-omap&m=128596931417805&w=2


-- 
Jarkko
1. http://marc.info/?l=linux-omap&m=128628175107214&w=2
