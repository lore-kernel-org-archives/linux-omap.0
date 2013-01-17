From: Philip Avinash <avinashphilip@ti.com>
Subject: [PATCH v2 0/2] LOW power sleep support for TI PWM submodules
Date: Thu, 17 Jan 2013 14:50:01 +0530
Message-ID: <1358414403-13431-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@avionic-design.de
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, gururaja.hebbar@ti.com, Philip Avinash <avinashphilip@ti.com>
List-Id: linux-omap@vger.kernel.org

TI PWM sub modules like ECAP & EHRPWM can enter in low power sleep
state during low power transitions of the platforms (like in AM33XX).
This patch series support low power sleep transition support. This
patch series depend on [1] and [2] and tested for low sleep support
on AM335x-evm for ECAP based PWM backlight.

1. ARM: OMAP2+: AM33XX: Add suspend-resume support
   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg82635.html
2. HWMOD fixes for AM33xx PWM submodules and device tree nodes.
   https://lkml.org/lkml/2013/1/2/87

Philip Avinash (2):
  pwm: pwm-tiehrpwm: Low power sleep support
  pwm: pwm-tiecap: Low power sleep support

 drivers/pwm/pwm-tiecap.c   |   53 ++++++++++++++++++++++++++++
 drivers/pwm/pwm-tiehrpwm.c |   83 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

-- 
1.7.9.5
