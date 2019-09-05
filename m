From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v3 0/6] counter: new TI eQEP driver
Date: Thu, 5 Sep 2019 22:37:21 +0900
Message-ID: <20190905133721.GA728346@icarus>
References: <20190901225827.12301-1-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190901225827.12301-1-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun, Sep 01, 2019 at 05:58:21PM -0500, David Lechner wrote:
> This series adds device tree bindings and a new counter driver for the Texas
> Instruments Enhanced Quadrature Encoder Pulse (eQEP).
> 
> As mentioned in one of the commit messages, to start with, the driver only
> supports reading the current counter value and setting the min/max values.
> Other features can be added as the counter subsystem gains support for them.
> 
> v3 changes:
> - Minor changes to device tree bindings (style and generic node name)
> - Drop action in initializer
> - Fix ordering of pm runtime disable
> v2 changes:
> - New patch to move TI PWMSS driver from drivers/pwm/ to drivers/bus/
> - Device tree bindings converted to .yaml format
> - Device tree clock renamed from "fck" to "sysclkout"
> - Dropped unused index and strobe signals from counter driver
> - Added synapses and actions to counter driver
> - Fixed base in of kstrtouint()
> - Clarifications in commit messages
> 
> This series has been tested on a BeagleBone Blue with the following script:
> 
> #!/usr/bin/env python3
> 
> from os import path
> from time import sleep
> 
> COUNTER_PATH = '/sys/bus/counter/devices'
> COUNTERS = ['counter0', 'counter1', 'counter2']
> COUNT0 = 'count0'
> COUNT = 'count'
> FUNCTION = 'function'
> CEILING = 'ceiling'
> FLOOR = 'floor'
> ENABLE = 'enable'
> 
> cnts = []
> 
> for c in COUNTERS:
>     function_path = path.join(COUNTER_PATH, c, COUNT0, FUNCTION)
>     with open(function_path, 'w') as f:
>         f.write('quadrature x4')
>     floor_path = path.join(COUNTER_PATH, c, COUNT0, FLOOR)
>     with open(floor_path, 'w') as f:
>         f.write(str(0))
>     ceiling_path = path.join(COUNTER_PATH, c, COUNT0, CEILING)
>     with open(ceiling_path, 'w') as f:
>         f.write(str(0xffffffff))
>     enable_path = path.join(COUNTER_PATH, c, COUNT0, ENABLE)
>     with open(enable_path, 'w') as f:
>         f.write('1')
> 
>     cnt_path = path.join(COUNTER_PATH, c, COUNT0, COUNT)
>     cnts.append(open(cnt_path, 'r'))
> 
> while True:
>     for c in cnts:
>         c.seek(0)
>         val = int(c.read())
>         if val >= 0x80000000:
>             val -= 0x100000000
>         print(val, end=' ')
>     print()
>     sleep(1)
> 
> David Lechner (6):
>   bus/ti-pwmss: move TI PWMSS driver from PWM to bus subsystem
>   dt-bindings: counter: new bindings for TI eQEP
>   counter: new TI eQEP driver
>   ARM: dts: am33xx: Add nodes for eQEP
>   ARM: dts: am335x-boneblue: Enable eQEP
>   ARM: dts: am335x-boneblue: Use of am335x-osd335x-common.dtsi
> 
>  .../devicetree/bindings/counter/ti-eqep.yaml  |  50 ++
>  MAINTAINERS                                   |   6 +
>  arch/arm/boot/dts/am335x-boneblue.dts         | 146 +++---
>  arch/arm/boot/dts/am33xx-l4.dtsi              |  27 +
>  drivers/bus/Kconfig                           |   9 +
>  drivers/bus/Makefile                          |   1 +
>  drivers/{pwm/pwm-tipwmss.c => bus/ti-pwmss.c} |   0
>  drivers/counter/Kconfig                       |  11 +
>  drivers/counter/Makefile                      |   1 +
>  drivers/counter/ti-eqep.c                     | 473 ++++++++++++++++++
>  drivers/pwm/Kconfig                           |   9 -
>  drivers/pwm/Makefile                          |   1 -
>  12 files changed, 634 insertions(+), 100 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/counter/ti-eqep.yaml
>  rename drivers/{pwm/pwm-tipwmss.c => bus/ti-pwmss.c} (100%)
>  create mode 100644 drivers/counter/ti-eqep.c
> 
> -- 
> 2.17.1

I'm satisfied with this version of the patchset.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Jonathan, if you have no objections please pick up this up so that it
can make it to the 5.4 merge window coming in soon. Alternatively, I can
merge it into my repository instead and hold it for a while longer
there, if you prefer that route.

Thank you,

William Breathitt Gray
