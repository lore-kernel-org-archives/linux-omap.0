From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 0/3] OMAP/pinmux: remove misuse of IRQF_NO_SUSPEND flag
Date: Mon,  1 Feb 2016 18:28:16 +0000
Message-ID: <1454351299-27440-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony/Grygorii,

Just revieving the old threads [1][2]. I have put all the necessary
patches together so that it can tested. Can you give it a go ?

Regards,
Sudeep

[1] https://www.spinics.net/lists/linux-gpio/msg09879.html
[2] http://lkml.iu.edu/hypermail/linux/kernel/1509.2/03937.html

Sudeep Holla (3):
  pinctrl: single: Use a separate lockdep class
  pinctrl: single: remove misuse of IRQF_NO_SUSPEND flag
  ARM: OMAP2+: remove misuse of IRQF_NO_SUSPEND flag

 arch/arm/mach-omap2/mux.c        |  4 ++--
 arch/arm/mach-omap2/pm34xx.c     |  9 ++++-----
 arch/arm/mach-omap2/prm_common.c |  1 +
 drivers/pinctrl/pinctrl-single.c | 15 ++++++++++++---
 4 files changed, 19 insertions(+), 10 deletions(-)

-- 
1.9.1

