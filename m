From: Tony Lindgren <tony@atomide.com>
Subject: [PATCHv2 0/4] improved support for runtime muxing for pinctrl
Date: Thu, 18 Jul 2013 08:15:01 -0700
Message-ID: <20130718151213.30990.45828.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here's this series again with hopefully all the comments addressed.

As discussed earlier, the pinctrl support for changing some of the
consumer device pins during runtime needs some improvment.
                                                                                                                
Regards,

Tony

---

Tony Lindgren (4):
      pinctrl: Remove duplicate code in pinctrl_pm_select_state functions
      pinctrl: Allow pinctrl to have multiple active states
      pinctrl: Add support for additional dynamic states
      drivers: Add pinctrl handling for dynamic pin states


 Documentation/pinctrl.txt             |   77 ++++++++-
 drivers/base/pinctrl.c                |   39 ++++
 drivers/pinctrl/core.c                |  291 +++++++++++++++++++++++++++------
 drivers/pinctrl/core.h                |   10 +
 include/linux/pinctrl/consumer.h      |   46 +++++
 include/linux/pinctrl/devinfo.h       |    4 
 include/linux/pinctrl/pinctrl-state.h |   15 +-
 7 files changed, 420 insertions(+), 62 deletions(-)

-- 
Signature
