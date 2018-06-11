From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/2] pwm-tiehrpwm: fixes for disabling PWMs
Date: Mon, 11 Jun 2018 11:39:54 +0530
Message-ID: <20180611060956.27999-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

EHRPWM has two PWM outputs. Currently with pwm-tiehrpwm driver, if PWMA
is enabled and then disabled, and then PWMB is enabled, it is seen that
PWMA turns on automatically. This series fixes the bug.

Vignesh R (2):
  pwm: pwm-tiehrpwm: Don't use emulation mode bits to control PWM output
  pwm: pwm-tiehrpwm: Fix disabling of output of PWMs

 drivers/pwm/pwm-tiehrpwm.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

-- 
2.17.1
