From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 0/3] Drop more omap3 legacy board-*.c files for v4.2
Date: Tue, 5 May 2015 12:58:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1505051252010.7750@knanqh.ubzr>
References: <1430769717-4088-1-git-send-email-tony@atomide.com> <20150505145407.GK18002@pali> <20150505150638.GC21061@atomide.com> <201505051839.36882@pali>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1918982293-1430844749=:7750"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35253 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbbEEQ66 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 May 2015 12:58:58 -0400
Received: by qcbgu10 with SMTP id gu10so50926899qcb.2
        for <linux-omap@vger.kernel.org>; Tue, 05 May 2015 09:58:57 -0700 (PDT)
In-Reply-To: <201505051839.36882@pali>
Content-ID: <alpine.LFD.2.11.1505051256000.7750@knanqh.ubzr>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1918982293-1430844749=:7750
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LFD.2.11.1505051256001.7750@knanqh.ubzr>

On Tue, 5 May 2015, Pali Rohár wrote:

> On Tuesday 05 May 2015 17:06:38 Tony Lindgren wrote:
> > * Pali Rohár <pali.rohar@gmail.com> [150505 07:55]:
> > > On Tuesday 05 May 2015 07:43:08 Tony Lindgren wrote:
> > > > * Arnd Bergmann <arnd@arndb.de> [150505 03:56]:
> > > > > On Monday 04 May 2015 13:01:54 Tony Lindgren wrote:
> > > > > > For dropping the remaining omap3 legacy boot support,
> > > > > > we still have the following board-*.c files:
> > > > > > 
> > > > > > BOARD                   REASON NEEDED
> > > > > > board-ldp.c             Still used in RMKs boot test
> > > > > > system board-omap3logic.c      Getting a .dts file
> > > > > > for v4.2 board-omap3pandora.c    Got a .dts file for
> > > > > > v4.1 board-rx51-*.c          Needs /proc/atags
> > > > > > support for user space
> > > > > > 
> > > > > > I'm hoping we can drop those for v4.3 merge window,
> > > > > > then keep the platform data around for one more merge
> > > > > > window in case of reverting needed, then drop the
> > > > > > platform data too for v4.4 if no issues needing
> > > > > > reverting are found.
> > > > > 
> > > > > Sounds great. Has there been a conclusion about what to
> > > > > do for the rx51 /proc/atags support?
> > > > 
> > > > I believe we just need to enable /proc/atags also for
> > > > device tree based booting if CONFIG_ARM_ATAG_DTB_COMPAT.
> > > > Pali may have more info on that.
> > > > 
> > > > Then looks like Pali's two patches for showing the
> > > > revision are still pending in thread "[PATCH v2 0/2] ARM:
> > > > /proc/cpuinfo: DT: Add support for Revision":
> > > > 
> > > > http://www.spinics.net/lists/arm-kernel/msg401535.html
> > > 
> > > I think I already sent all need patches to ML. But I did not
> > > check if you merged them or not. I did not get any new
> > > comments for them for a while and right now I do not have
> > > time for looking at it again.
> > 
> > Oh OK, do you have link to the /proc/atags patch somewhere?
> > 
> > Maybe Arnd and Nico can pick them up and sort out how we
> > should queue them with Russell?
> > 
> 
> https://lkml.org/lkml/2015/1/26/648

Rather than shoving the whole ATAGs inside DT, why not simply picking 
the relevant data and convert it into the appropriate DT binding?


Nicolas
--8323328-1918982293-1430844749=:7750--
