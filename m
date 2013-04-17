From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] Fix omap4 panda LED definitions
Date: Wed, 17 Apr 2013 14:09:37 -0500
Message-ID: <1366225778-6083-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The LED GPIOs between the 4430 (a1-a4) and 4460 (es) panda boards
are different.  This patch abstracts the LED definitions into the 
respective board files.
