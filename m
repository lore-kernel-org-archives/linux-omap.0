From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 0/2] mfd: twl6040: Small clean-ups
Date: Tue, 25 Feb 2014 14:28:18 +0100
Message-ID: <1393334900-29740-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>
List-Id: linux-omap@vger.kernel.org

Hi,

Here is two cleanups patches for the TWL6040 audio codec. The first
one checks for an error when reading the revision register (first read
in the probe path). The second removes a duplicate I2C writes.

Regards,
Florian

Florian Vaussard (2):
  mfd: twl6040: Check for error when reading revision register
  mfd: twl6040: Remove duplicate register write

 drivers/mfd/twl6040.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
1.8.1.2
