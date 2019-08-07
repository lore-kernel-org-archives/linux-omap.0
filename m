From: David Lechner <david@lechnology.com>
Subject: [PATCH v2 0/5] counter: new TI eQEP driver
Date: Wed,  7 Aug 2019 14:40:18 -0500
Message-ID: <20190807194023.15318-1-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-iio@vger.kernel.org, linux-omap@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This series adds device tree bindings and a new counter driver for the Texas
Instruments Enhanced Quadrature Encoder Pulse (eQEP).

As mentioned in one of the commit messages, to start with, the driver only
supports reading the current counter value and setting the min/max values.
Other features can be added as the counter subsystem gains support for them.

v2 changes:
- New patch to move TI PWMSS driver from drivers/pwm/ to drivers/bus/
- Device tree bindings converted to .yaml format
- Device tree clock renamed from "fck" to "sysclkout"
- Dropped unused index and strobe signals from counter driver
- Added synapses and actions to counter driver
- Fixed base in of kstrtouint()
- Clarifications in commit messages

This series has been tested on a BeagleBone Blue with the following script:

#!/usr/bin/env python3

from os import path
from time import sleep

COUNTER_PATH = '/sys/bus/counter/devices'
COUNTERS = ['counter0', 'counter1', 'counter2']
COUNT0 = 'count0'
COUNT = 'count'
FUNCTION = 'function'
CEILING = 'ceiling'
FLOOR = 'floor'
ENABLE = 'enable'

cnts = []

for c in COUNTERS:
    function_path = path.join(COUNTER_PATH, c, COUNT0, FUNCTION)
    with open(function_path, 'w') as f:
        f.write('quadrature x4')
    floor_path = path.join(COUNTER_PATH, c, COUNT0, FLOOR)
    with open(floor_path, 'w') as f:
        f.write(str(0))
    ceiling_path = path.join(COUNTER_PATH, c, COUNT0, CEILING)
    with open(ceiling_path, 'w') as f:
        f.write(str(0xffffffff))
    enable_path = path.join(COUNTER_PATH, c, COUNT0, ENABLE)
    with open(enable_path, 'w') as f:
        f.write('1')

    cnt_path = path.join(COUNTER_PATH, c, COUNT0, COUNT)
    cnts.append(open(cnt_path, 'r'))

while True:
    for c in cnts:
        c.seek(0)
        val = int(c.read())
        if val >= 0x80000000:
            val -= 0x100000000
        print(val, end=' ')
    print()
    sleep(1)

David Lechner (5):
  bus/ti-pwmss: move TI PWMSS driver from PWM to bus subsystem
  dt-bindings: counter: new bindings for TI eQEP
  counter: new TI eQEP driver
  ARM: dts: am33xx: Add nodes for eQEP
  ARM: dts: am335x-boneblue: Enable eQEP

 .../devicetree/bindings/counter/ti-eqep.yaml  |  50 ++
 MAINTAINERS                                   |   6 +
 arch/arm/boot/dts/am335x-boneblue.dts         |  54 ++
 arch/arm/boot/dts/am33xx-l4.dtsi              |  27 +
 drivers/bus/Kconfig                           |   9 +
 drivers/bus/Makefile                          |   1 +
 drivers/{pwm/pwm-tipwmss.c => bus/ti-pwmss.c} |   0
 drivers/counter/Kconfig                       |  12 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/ti-eqep.c                     | 460 ++++++++++++++++++
 drivers/pwm/Kconfig                           |   9 -
 drivers/pwm/Makefile                          |   1 -
 12 files changed, 620 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/counter/ti-eqep.yaml
 rename drivers/{pwm/pwm-tipwmss.c => bus/ti-pwmss.c} (100%)
 create mode 100644 drivers/counter/ti-eqep.c

-- 
2.17.1
