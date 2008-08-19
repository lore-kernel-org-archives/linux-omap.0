From: Tony Lindgren <tony@atomide.com>
Subject: git-pull request for omap2-clock branch
Date: Tue, 19 Aug 2008 11:39:51 +0300
Message-ID: <1219135201-10282-1-git-send-email-tony@atomide.com>
References: <20080818163429.GF16455@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63210 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbYHSIkH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 04:40:07 -0400
In-Reply-To: <20080818163429.GF16455@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080818 19:34]:
> On Wed, Jul 16, 2008 at 06:19:05PM +0300, Tony Lindgren wrote:
> > This patch series contains power domain and clock domain specific p=
atches
> > for omap posted to linux-arm-kernel list during 2.6.25-rc5.
> >
> > I'm reposting the series to a wider audience as Russell King suspec=
ted that
> > other archs may be interested in reviewing these too, or at least s=
ome
> > parts of the code.
>
> Okay, I'll merge this set of 10 patches now.  Could you update them f=
or
> the new include layout please, and send me a pull request for them.

Great! Following is the pull request for you, I'll also send the
refreshed patches as a reply to this thread for reference.

Thanks,

Tony

The following changes since commit 1fca25427482387689fa27594c992a961d98=
768f:
  Linus Torvalds (1):
        Merge branch 'release' of git://git.kernel.org/.../aegl/linux-2=
=2E6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.g=
it omap2-clock

H=C3=B6gander Jouni (1):
      ARM: OMAP2: Clock: Combine 34xx l3_icks and l4_icks

Paul Walmsley (9):
      ARM: OMAP2: Powerdomain: Add base OMAP2/3 powerdomain code
      ARM: OMAP2: Powerdomain: Add OMAP2/3 common powerdomains
      ARM: OMAP2: Powerdomain: Add OMAP2 powerdomains
      ARM: OMAP: Powerdomain: Add OMAP3 powerdomains
      ARM: OMAP2: Clockdomain: Add base OMAP2/3 clockdomain code
      ARM: OMAP2: Clockdomain: Connect clockdomain code to powerdomain =
code
      ARM: OMAP2: Clockdomain: Encode OMAP2/3 clockdomains
      ARM: OMAP2: Clockdomain: Associate clocks with clockdomains
      ARM: OMAP2: Clockdomain: Integrate OMAP3 clocks with clockdomain =
code

 arch/arm/mach-omap2/Makefile                  |    3 +-
 arch/arm/mach-omap2/clock.c                   |   46 +-
 arch/arm/mach-omap2/clock.h                   |    1 +
 arch/arm/mach-omap2/clock24xx.h               |  238 +++++--
 arch/arm/mach-omap2/clock34xx.c               |   31 +-
 arch/arm/mach-omap2/clock34xx.h               |  248 +++++--
 arch/arm/mach-omap2/clockdomain.c             |  607 ++++++++++++++
 arch/arm/mach-omap2/clockdomains.h            |  305 +++++++
 arch/arm/mach-omap2/cm-regbits-24xx.h         |   24 +-
 arch/arm/mach-omap2/cm-regbits-34xx.h         |   42 +-
 arch/arm/mach-omap2/io.c                      |    9 +
 arch/arm/mach-omap2/powerdomain.c             | 1045 +++++++++++++++++=
++++++++
 arch/arm/mach-omap2/powerdomains.h            |  187 +++++
 arch/arm/mach-omap2/powerdomains24xx.h        |  200 +++++
 arch/arm/mach-omap2/powerdomains34xx.h        |  327 ++++++++
 arch/arm/mach-omap2/prcm-common.h             |    3 +-
 arch/arm/mach-omap2/prm-regbits-24xx.h        |   12 +-
 arch/arm/mach-omap2/prm-regbits-34xx.h        |   11 +-
 arch/arm/mach-omap2/prm.h                     |    3 +-
 arch/arm/plat-omap/Kconfig                    |   24 +
 arch/arm/plat-omap/include/mach/clock.h       |    3 +
 arch/arm/plat-omap/include/mach/clockdomain.h |  106 +++
 arch/arm/plat-omap/include/mach/powerdomain.h |  155 ++++
 23 files changed, 3483 insertions(+), 147 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomain.c
 create mode 100644 arch/arm/mach-omap2/clockdomains.h
 create mode 100644 arch/arm/mach-omap2/powerdomain.c
 create mode 100644 arch/arm/mach-omap2/powerdomains.h
 create mode 100644 arch/arm/mach-omap2/powerdomains24xx.h
 create mode 100644 arch/arm/mach-omap2/powerdomains34xx.h
 create mode 100644 arch/arm/plat-omap/include/mach/clockdomain.h
 create mode 100644 arch/arm/plat-omap/include/mach/powerdomain.h


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
