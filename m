From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/2] regulator: palmas: Reemove open coded functions with helper functions
Date: Thu, 22 May 2014 14:48:28 +0530
Message-ID: <1400750310-20925-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

The patch series makes use of the helper functions and remove open coded
functions. The patch set also formats the palmas header file. Converts all
the offset values to hexadecimal. 

Boot Tested on omap5-uevm board.

Keerthy (2):
  regulator: palmas: Make use of helper functions and remove open coded
    functions
  mfd: palmas: Format the header file

 drivers/regulator/palmas-regulator.c |  158 +--
 include/linux/mfd/palmas.h           | 2166 +++++++++++++++++-----------------
 2 files changed, 1109 insertions(+), 1215 deletions(-)

-- 
1.7.9.5
