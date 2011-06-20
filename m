From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH 0/2] video: Make omap2 support conditional
Date: Mon, 20 Jun 2011 16:15:59 +0530
Message-ID: <1308566761-2850-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: linux@arm.linux.org.uk, tony@atomide.com, lethal@linux-sh.org, linaro-dev@lists.linaro.org, patches@linaro.org
List-Id: linux-omap@vger.kernel.org

Currently drivers/video/omap2 is built by default with every configuration
of the kernel. Current patchset makes the omap2 video support conditional 
on appropriate config option. 

[Patch 2/2] was first generated, but that resulted in a build error. 
[Patch 1/2] was created to fix that build error.

These patches have only been tested for build consistency and have not been
tested on any related hardware.

Tushar Behera (2):
  config: omap2+: force fb and dss support as built-in
  video: omap2: Compile omap2 support only when needed

 arch/arm/configs/omap2plus_defconfig |    4 ++--
 drivers/video/Makefile               |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.7.4.1
