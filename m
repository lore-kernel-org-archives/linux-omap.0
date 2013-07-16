From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] improved support for runtime muxing for pinctrl
Date: Tue, 16 Jul 2013 02:05:24 -0700
Message-ID: <20130716090310.5541.36777.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

As discussed earlier, the pinctrl support for changing some of the
consumer device pins during runtime needs some improvment.

Here are the patches to do that, I'll also post a minimal sample
patch as a reply to this thread on how to do the muxing for
runtime PM.

Regards,

Tony

---

Tony Lindgren (4):
      pinctrl: Remove duplicate code in pinctrl_pm_select_state functions
      pinctrl: Allow pinctrl to have multiple active states
      pinctrl: Add support for additional dynamic states
      drivers: Add pinctrl handling for dynamic pin states


 drivers/base/pinctrl.c                |   39 +++++
 drivers/pinctrl/core.c                |  250 ++++++++++++++++++++++++++++-----
 drivers/pinctrl/core.h                |   10 +
 include/linux/pinctrl/consumer.h      |   46 ++++++
 include/linux/pinctrl/devinfo.h       |    4 +
 include/linux/pinctrl/pinctrl-state.h |   15 ++
 6 files changed, 321 insertions(+), 43 deletions(-)

-- 
Signature
