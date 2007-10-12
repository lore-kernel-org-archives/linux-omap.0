From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] Make dyntick work again
Date: Fri, 12 Oct 2007 16:47:47 +0200
Message-ID: <470F8913.8070308@googlemail.com>
References: <20071011203240.GL503@atomide.com>
	<002c01c80c74$9f0f5160$e1ac580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <002c01c80c74$9f0f5160$e1ac580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: kmpark@infradead.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Kyungmin Park wrote:
> Umm, there's a problem, I can't boot with timer32k.
> It halts at here.

On OMAP 5912 OSK I get:

> <7>Calibrating delay loop... 1.05 BogoMIPS (lpj=4096)
> Mount-cache hash table entries: 512
> <6>CPU: Testing write buffer coherency:

...
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
MUX: initialized M19_1610_CAM_RSTZ
...
MUX: initialized PWL
OMAP DMA hardware version 1
DMA capabilities: 000c0000:00000000:01ff:003f:007f
Initializing OMAP McBSP system
omap_dsp_init() done
USB: hmc 16, usb2 alt 0 wires
i2c_omap i2c_omap.1: bus 1 rev2.2 at 100 kHz
tps65010: version 2 May 2005
Time: 32k_counter clocksource has been installed.
Switched to high resolution mode on CPU 0
NET: Registered protocol family 2
...

> P.S., here's the current kernel configuration (timer 32k)
> CONFIG_GENERIC_TIME=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_OMAP_32K_TIMER=y
> CONFIG_OMAP_32K_TIMER_HZ=128
> CONFIG_OMAP_DM_TIMER=y
> # Kernel Features
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
> CONFIG_PREEMPT=y
> CONFIG_HZ=128

my config:

CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_CLOCKEVENTS=y
# CONFIG_OMAP_MPU_TIMER is not set
CONFIG_OMAP_32K_TIMER=y
CONFIG_OMAP_32K_TIMER_HZ=128
# CONFIG_OMAP_DM_TIMER is not set

#
# Kernel Features
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_PREEMPT=y
CONFIG_HZ=128

As the "ok" in "CPU: Testing write buffer coherency: ok" is already 
missing in your output, maybe it is anything else?

Regards

Dirk
