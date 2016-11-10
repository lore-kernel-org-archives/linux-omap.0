From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH v2 0/3] increase TSCADC clock to 24MHz and fix ti,charge-delay to represent in nS
Date: Thu, 10 Nov 2016 22:05:12 +0530
Message-ID: <20161110163515.27598-1-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch series enables ADC to be clocked at 24MHz as the
TI AM335x ADC driver has already adopted to use DMA to transfer
ADC samples. Now ADC can generated upto 800K Samples per second
with the patch [1] on AM335x BBB and AM437x GP EVM.

when ADC ref clock is set at 24MHz, I am seeing some issue with
touch screen pointer as the pointer jumps to random locations
with free draw application. The issue is due to increase in ADC
clock and charge delay for the touchscreen ADC line duration
reduced.

So the notation of ti,charge-delay in terms of ADC clock is
wrong, it has to be represented in time and driver has to convert
the charge delay time to ADC clocks based on what ADC clock
frequency is set.

Measured the performance with the iio_generic_buffer with the
patch [2] applied

Verified the touch screen on AM335x GP EVM and AM335x BBB LCD7
cape with [3] dts for display and touch screen to work.

Changes from initial version:
* Removed modification to STEPCONFIG_OPENDLY defined as it
  doesn't affect/improve touchscreen performance.
* Changed ti,charge-delay to ti,charge-delay-ns

[1] - http://pastebin.ubuntu.com/23357935/
[2] - http://pastebin.ubuntu.com/23357939/
[3] - http://pastebin.ubuntu.com/23456616/

Mugunthan V N (3):
  dt/binding: ti-tsc-adc: deprecate ti,charge-delay and add binding doc
    for ti,charge-delay-ns
  Input: ti_am335x_tsc: Add support for ti,charge-delay-ns
  drivers: mfd: ti_am335x_tscadc: increase ADC ref clock to 24MHz

 .../bindings/input/touchscreen/ti-tsc-adc.txt      | 32 ++++++++++++++--------
 drivers/input/touchscreen/ti_am335x_tsc.c          | 31 +++++++++++++++------
 include/linux/mfd/ti_am335x_tscadc.h               |  2 +-
 3 files changed, 45 insertions(+), 20 deletions(-)

-- 
2.11.0.rc0.7.gbe5a750
