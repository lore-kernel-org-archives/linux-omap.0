From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: [PATCH v2 0/4] Add support for twl6025 PMIC
Date: Thu, 12 May 2011 14:27:54 +0100
Message-ID: <1305206878-18094-1-git-send-email-gg@slimlogic.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sameo@linux.intel.com, balbi@ti.com, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com
List-Id: linux-omap@vger.kernel.org

This patch series starts to add support for the twl6025 chip to the
twl driver. This series contains patches for the MFD device and the
regulator device to support the twl6025.

Since V1

Series has been altered to pass features via platform data rather
than via a get function on a global variable.
Regulator style was change so some ifs were replaced with switch.
There has been some discussion about regulator definition and naming
and TI have agreed to take on the cleanup internally.

Graeme
