From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 0/2] improve pwm lookup support without device tree
Date: Wed,  9 Apr 2014 20:04:07 +0200
Message-ID: <1397066649-3767-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:34432 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933354AbaDISFw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2014 14:05:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

Hi,

a small patch set as suggested byt Thierry to make lokkup with the lookup table
instead of device tree bahve more like when using device tree.

The first patch adds a period annd a polarity member to the lookup table and use
those to set period and polarity.

The second patch changes PWM_LOOKUP to set period an polarity. I was wondering
about adding a new macro to d that but the number of boards using it is limited
(only 3) so I guess it is ok to do that now.

The final goal would be to get rid of .pwm_period_ns in leds-pwm and pwm_bl.

Alexandre Belloni (2):
  pwm: add period and polarity to struct pwm_lookup
  pwm: use PWM_LOOKUP to set the period and polarity

 Documentation/pwm.txt                          | 3 ++-
 arch/arm/mach-omap2/board-omap3beagle.c        | 3 ++-
 arch/arm/mach-pxa/hx4700.c                     | 3 ++-
 arch/arm/mach-shmobile/board-armadillo800eva.c | 3 ++-
 drivers/pwm/core.c                             | 5 +++++
 include/linux/pwm.h                            | 6 +++++-
 6 files changed, 18 insertions(+), 5 deletions(-)

-- 
1.8.3.2

