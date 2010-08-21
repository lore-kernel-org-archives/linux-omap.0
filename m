From: hvaibhav@ti.com
Subject: [PATCH-V2 0/3] RTC:A35390A: Add Interrupt API interfaces
Date: Sat, 21 Aug 2010 18:00:26 +0530
Message-ID: <1282393829-7326-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, byron.bbradley@gmail.com, linux-omap@vger.kernel.org, felipe.balbi@nokia.com, Vaibhav Hiremath <hvaibhav@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Vaibhav Hiremath <hvaibhav@ti.com>

This patch adds support for interrupt API interfaces like,
	- Alarm interrupt
	- Periodic interrupt
	- Per minute interrupt

Changes from V1 :-
	- Converted work-queue to threaded irq
	- Fixed comments from Felipe Balbi

Vaibhav Hiremath (3):
  RTC:s35390a: Add Alarm interrupt support
  RTC:s35390a: Add Periodic interrupt support
  RTC:s35390a: Add update_irq (per Min interrupt) support

 drivers/rtc/rtc-s35390a.c |  281 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 278 insertions(+), 3 deletions(-)
