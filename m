From: David Lechner <david@lechnology.com>
Subject: [PATCH 0/4] new driver for TI eQEP
Date: Mon, 22 Jul 2019 10:45:34 -0500
Message-ID: <20190722154538.5314-1-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This series adds device tree bindings and a new counter driver for the Texas
Instruments Enhanced Quadrature Encoder Pulse (eQEP).

As mentioned in one of the commit messages, to start with, the driver only
supports reading the current counter value and setting the min/max values.
Other features can be added on an as-needed basis.

The only other feature I am interested in is adding is getting time data in
order to calculate the rotational speed of a motor. However, there probably
needs to be a higher level discussion of how this can fit into the counter
subsystem in general first.

This series has been tested on a BeagleBone Blue with the following script:

#!/usr/bin/env python3

from os import path
from time import sleep

COUNTER_PATH = '/sys/bus/counter/devices'
COUNTERS = ['counter0', 'counter1', 'counter2']
COUNT0 = 'count0'
COUNT = 'count'
CEILING = 'ceiling'
FLOOR = 'floor'
ENABLE = 'enable'

cnts = []

for c in COUNTERS:
    enable_path = path.join(COUNTER_PATH, c, COUNT0, ENABLE)
    with open(enable_path, 'w') as f:
        f.write('1')
    ceiling_path = path.join(COUNTER_PATH, c, COUNT0, CEILING)
    with open(ceiling_path, 'w') as f:
        f.write(str(0xffffffff))

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

David Lechner (4):
  dt-bindings: counter: new bindings for TI eQEP
  counter: new TI eQEP driver
  ARM: dts: am33xx: Add nodes for eQEP
  ARM: dts: am335x-boneblue: Enable eQEP

 .../devicetree/bindings/counter/ti-eqep.txt   |  18 +
 MAINTAINERS                                   |   6 +
 arch/arm/boot/dts/am335x-boneblue.dts         |  54 +++
 arch/arm/boot/dts/am33xx-l4.dtsi              |  27 ++
 drivers/counter/Kconfig                       |  12 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/ti-eqep.c                     | 381 ++++++++++++++++++
 drivers/pwm/Kconfig                           |   2 +-
 8 files changed, 500 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/counter/ti-eqep.txt
 create mode 100644 drivers/counter/ti-eqep.c

-- 
2.17.1
