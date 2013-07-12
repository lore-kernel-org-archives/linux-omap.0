From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [PATCH v1 0/2] PM / AVS: interrupt handling fixes
Date: Fri, 12 Jul 2013 16:52:01 +0300
Message-ID: <1373637123-1152-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Kevin,

Could you please take a look to the following patch series.
It consists of two patches, which are needed for proper
SmartReflex Interrupt handling.

Based on Linux v3.10. Verified on OMAP4430.

Thank you in advance.

Regards,
Andrii

Nishanth Menon (2):
  PM / AVS: SmartReflex: fix interrupt disable sequence
  PM / AVS: SmartReflex: disable spamming interrupts

 drivers/power/avs/smartreflex.c |   31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

-- 
1.7.9.5
