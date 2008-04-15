From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 00/19] Update and clean up on sound/arm/omap/omap-alsa*[c,h]
Date: Tue, 15 Apr 2008 10:02:04 -0400
Message-ID: <1208268143-8789-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48063 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758674AbYDOOCc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 10:02:32 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3FE2PD2018693
	for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2008 17:02:29 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Hi all,

This patch series cleans up most of the errors and warnings reported
by checkpatch.pl on sound/arm/omap/omap-alsa*[c,h]. Some checks reported
by checkpatch.pl were ignored, such as removing #if 0 codes. Not all were
eligible for remotion.

There is also one patch that updates the alsa driver for H2.
Since tsc2101 i2c driver was updated, this alsa driver stop
working.

As Carlos already sent a patch to remove old #includes into these files [1],
this series does not include this fix.

Cheers,

---
Eduardo Valentin

[1] - http://marc.info/?l=linux-omap&m=120813065101654&w=2

Eduardo Valentin (19):
  Update audio driver for H2 board
  Code clean-up for sound/arm/omap/omap-alsa.h
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

 arch/arm/mach-omap1/board-h2.c           |   72 ++--
 include/asm-arm/arch-omap/omap-alsa.h    |   14 +-
 sound/arm/omap/omap-alsa-aic23-mixer.c   |  138 ++++---
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
 19 files changed, 1045 insertions(+), 788 deletions(-)

