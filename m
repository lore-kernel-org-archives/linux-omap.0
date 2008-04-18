From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 00/19] Update and clean up on sound/arm/omap/omap-alsa*[c,h] (take #2)
Date: Fri, 18 Apr 2008 04:00:47 -0400
Message-ID: <1208505666-13744-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18771 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755776AbYDRIBU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 04:01:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <me@felipebalbi.com>, Ragner Magalhaes <ragner.magalhaes@indt.org.br>, Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Hi all,

This patch series cleans up most of the errors and warnings reported
by checkpatch.pl on sound/arm/omap/omap-alsa*[c,h]. Some checks reported
by checkpatch.pl were ignored, such as removing #if 0 codes. Not all were
eligible for remotion.

There is also one patch that updates the alsa driver for H2.
Since tsc2101 i2c driver was updated, this alsa driver stop
working.

Cheers,

---
Eduardo Valentin

Eduardo Valentin (19):
  Update audio driver for H2 board
  Code clean-up for include/asm-arm/arch-omap/omap-alsa.h
  Code clean-up for sound/arm/omap/omap-alsa-aic23.c
  Code clean-up for sound/arm/omap/omap-alsa-aic23.h
  Code clean-up for sound/arm/omap/omap-alsa-aic23-mixer.c
  Code clean-up for sound/arm/omap/omap-alsa-dma.c
  Code clean-up for sound/arm/omap/omap-alsa-dma.h
  Code clean-up for sound/arm/omap/omap-alsa-sx1-mixer.c
  Code clean-up for sound/arm/omap/omap-alsa-sx1-mixer.h
  Code clean-up for sound/arm/omap/omap-alsa-sx1.c
  Code clean-up for sound/arm/omap/omap-alsa-sx1.h
  Code clean-up for sound/arm/omap/omap-alsa-tsc2101-mixer.c
  Code clean-up for sound/arm/omap/omap-alsa-tsc2101-mixer.h
  Code clean-up for sound/arm/omap/omap-alsa-tsc2101.c
  Code clean-up for sound/arm/omap/omap-alsa-tsc2101.h
  Code clean-up for sound/arm/omap/omap-alsa-tsc2102-mixer.c
  Code clean-up for sound/arm/omap/omap-alsa-tsc2102.c
  Code clean-up for sound/arm/omap/omap-alsa-tsc2102.h
  Code clean-up for sound/arm/omap/omap-alsa.c

 arch/arm/mach-omap1/board-h2.c           |   71 ++--
 include/asm-arm/arch-omap/omap-alsa.h    |   29 +-
 sound/arm/omap/omap-alsa-aic23-mixer.c   |  144 ++++---
 sound/arm/omap/omap-alsa-aic23.c         |   59 ++--
 sound/arm/omap/omap-alsa-aic23.h         |   12 +-
 sound/arm/omap/omap-alsa-dma.c           |  171 ++++-----
 sound/arm/omap/omap-alsa-dma.h           |   22 +-
 sound/arm/omap/omap-alsa-sx1-mixer.c     |   22 +-
 sound/arm/omap/omap-alsa-sx1-mixer.h     |    6 +-
 sound/arm/omap/omap-alsa-sx1.c           |   72 +++-
 sound/arm/omap/omap-alsa-sx1.h           |    3 +-
 sound/arm/omap/omap-alsa-tsc2101-mixer.c |  631 ++++++++++++++++--------------
 sound/arm/omap/omap-alsa-tsc2101-mixer.h |   31 +-
 sound/arm/omap/omap-alsa-tsc2101.c       |  320 ++++++++++-----
 sound/arm/omap/omap-alsa-tsc2101.h       |   11 +-
 sound/arm/omap/omap-alsa-tsc2102-mixer.c |   14 +-
 sound/arm/omap/omap-alsa-tsc2102.c       |   70 ++--
 sound/arm/omap/omap-alsa-tsc2102.h       |    2 +-
 sound/arm/omap/omap-alsa.c               |  163 ++++----
 19 files changed, 1056 insertions(+), 797 deletions(-)

