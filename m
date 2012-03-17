From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH v4 0/7] Add TI EMIF SDRAM controller driver
Date: Sat, 17 Mar 2012 15:10:58 +0900
Message-ID: <CAH9JG2XB86id0qTMUV9j6x6hJVaP=iJaEOtM_7c05QTovr4sig@mail.gmail.com>
References: <1331934707-29487-1-git-send-email-aneesh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1331934707-29487-1-git-send-email-aneesh@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aneesh V <aneesh@ti.com>
Cc: Greg KH <greg@kroah.com>, =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 3/17/12, Aneesh V <aneesh@ti.com> wrote:
> Add a driver for the EMIF SDRAM controller used in TI SoCs
>
> EMIF is an SDRAM controller that supports, based on its revision,
> one or more of LPDDR2/DDR2/DDR3 protocols.This driver adds support
> for LPDDR2.
>
> The driver supports the following features:
> - Calculates the DDR AC timing parameters to be set in EMIF
>   registers using data from the device data-sheets and based
>   on the DDR frequency. If data from data-sheets is not available
>   default timing values from the JEDEC spec are used. These
>   will be safe, but not necessarily optimal
> - API for changing timings during DVFS or at boot-up
> - Temperature alert configuration and handling of temperature
>   alerts, if any for LPDDR2 devices
>   * temperature alert is based on periodic polling of MR4 mode
>     register in DDR devices automatically performed by hardware
>   * timings are de-rated and brought back to nominal when
>     temperature raises and falls respectively
> - Cache of calculated register values to avoid re-calculating
>   them
>
> The driver will need some minor updates when it is eventually
> integrated with Dynamic Voltage and Frequency Scaling (DVFS).
> This can not be done now as DVFS support is not available in
> the mainline yet.
Do you see the devfreq? it's designed for non-cpu device frequency.
It's role is similar with cpufreq.

Now samsung exynos uses devfreq for DRAM bus frequency.

Thank you,
Kyungmin Park
>
> Discussions with Santosh Shilimkar <santosh.shilimkar@ti.com>
> were immensely helpful in shaping up the interfaces. Vibhore Vardhan
> <vvardhan@gmail.com> did the initial code snippet for thermal
> handling.
>
> Testing:
> - The driver is tested on OMAP4430 SDP.
> - The driver in a slightly adapted form is also tested on OMAP5.
> - Since mainline kernel doesn't have DVFS support yet,
>   testing was done using a test module.
> - Temperature alert handling was tested with simulated interrupts
>   and faked temperature values as testing all cases in real-life
>   scenarios is difficult.
> - Tested the driver as a module
>
> Cc: Greg KH <greg@kroah.com>
>
> v4:
> - Converted instances of EXPORT_SYMBOL to EXPORT_SYMBOL_GPL
> - Removed un-necessary "#ifndef __ASSEMBLY__'
> - Minor formatting fix
>
> v2:
> - Fixed a bug found in the implementation of errata i728
>   workaround
> - Fixed the value of frequency printed in debugfs
> - Dropped the hwmod patch as Paul has already posted a
>   a hwmod series [1] that adds hwmod for EMIF
> - Converted instances of __init to __init_or_module
>
> [1] http://thread.gmane.org/gmane.linux.ports.arm.omap/72855
>
> Aneesh V (7):
>   misc: ddr: add LPDDR2 data from JESD209-2
>   misc: emif: add register definitions for EMIF
>   misc: emif: add basic infrastructure for EMIF driver
>   misc: emif: handle frequency and voltage change events
>   misc: emif: add interrupt and temperature handling
>   misc: emif: add one-time settings
>   misc: emif: add debugfs entries for emif
>
>  Documentation/misc-devices/ti-emif.txt  |   58 ++
>  drivers/misc/Kconfig                    |   12 +
>  drivers/misc/Makefile                   |    1 +
>  drivers/misc/emif.c                     | 1670
> +++++++++++++++++++++++++++++++
>  drivers/misc/emif.h                     |  589 +++++++++++
>  include/linux/platform_data/emif_plat.h |  128 +++
>  include/misc/jedec_ddr.h                |  175 ++++
>  lib/Kconfig                             |    8 +
>  lib/Makefile                            |    2 +
>  lib/jedec_ddr_data.c                    |  135 +++
>  10 files changed, 2778 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/misc-devices/ti-emif.txt
>  create mode 100644 drivers/misc/emif.c
>  create mode 100644 drivers/misc/emif.h
>  create mode 100644 include/linux/platform_data/emif_plat.h
>  create mode 100644 include/misc/jedec_ddr.h
>  create mode 100644 lib/jedec_ddr_data.c
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
