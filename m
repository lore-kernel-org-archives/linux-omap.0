From: Deepthy Ravi <deepthy.ravi@ti.com>
Subject: [PATCH 0/2] omap3: ISP: Fix the failure of CCDC capture during suspend/resume
Date: Wed, 10 Aug 2011 19:32:59 +0530
Message-ID: <1312984979-19270-1-git-send-email-deepthy.ravi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, mchehab@infradead.org, laurent.pinchart@ideasonboard.com
Cc: linux-omap@vger.kernel.org, Deepthy Ravi <deepthy.ravi@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Abhilash K V <abhilash.kv@ti.com>
List-Id: linux-omap@vger.kernel.org

This patchset fixes the occasional failure of CCDC capture during 
suspend/resume.

Cc: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Abhilash K V <abhilash.kv@ti.com>
---
Abhilash K V (2):
  omap3: ISP: Fix the failure of CCDC capture during suspend/resume
  omap3: ISP: Kernel crash when attempting suspend

 drivers/media/video/omap3isp/isp.c      |   22 +++++++++++-
 drivers/media/video/omap3isp/isp.h      |    4 ++
 drivers/media/video/omap3isp/ispvideo.c |   58 ++++++++++++++++++++++++++++++-
 drivers/media/video/omap3isp/ispvideo.h |    2 +
 4 files changed, 84 insertions(+), 2 deletions(-)
