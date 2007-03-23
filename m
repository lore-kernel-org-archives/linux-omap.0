From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: TCM825x: Add driver.
Date: Fri, 23 Mar 2007 18:54:54 +0530
Message-ID: <5d5443650703230624h79d5b046u65fa094ee7e79719@mail.gmail.com>
References: <4602B745.7000006@nokia.com>
	<11745832253226-git-send-email-sakari.ailus@nokia.com>
	<11745832251620-git-send-email-sakari.ailus@nokia.com>
	<11745832251952-git-send-email-sakari.ailus@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11745832251952-git-send-email-sakari.ailus@nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Sakari Ailus <sakari.ailus@nokia.com>
Cc: eduardo.valentin@indt.org.br, linux-omap-open-source@linux.omap.com, ilias.biris@indt.org.br
List-Id: linux-omap@vger.kernel.org

On 3/22/07, Sakari Ailus <sakari.ailus@nokia.com> wrote:
> Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
> ---
>  drivers/media/video/omap/sensor_tcm825x.c | 1097 +++++++++++++++++++++++++++++
>  drivers/media/video/omap/tcm825x.h        |  179 +++++
>  2 files changed, 1276 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/media/video/omap/sensor_tcm825x.c
>  create mode 100644 drivers/media/video/omap/tcm825x.h
>
> diff --git a/drivers/media/video/omap/sensor_tcm825x.c b/drivers/media/video/omap/sensor_tcm825x.c
> new file mode 100644
> index 0000000..dd01851
> --- /dev/null
> +++ b/drivers/media/video/omap/sensor_tcm825x.c
> @@ -0,0 +1,1097 @@
> +/*
> + * drivers/media/video/omap/sensor_tcm825x.c
> + *
> + * TCM825X Sensor driver for OMAP camera sensor interface
> + *
> + * Author: David Cohen (david.cohen@indt.org.br)
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + *
> + * This driver was based on ov9640 sensor driver from MontaVista
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/videodev.h>
> +#include <linux/delay.h>
> +#include <media/video-buf.h>
> +
> +#include <asm/mach-types.h>
> +
> +#include <asm/arch/board.h>
> +#include <asm/arch/gpio.h>
> +
> +#include "sensor_if.h"
> +#include "tcm825x.h"
> +
> +#define OMAP24XX_CAMERA_JAM_HACK
> +
> +#ifdef OMAP24XX_CAMERA_JAM_HACK
> +/*
> + * We don't need to check every pixel to assume that the frame is
> + * corrupt and the sensor is jammed. CHECK_X and CHECK_Y are the
> + * number of u32s to check per line / row, plus there are two lines in
> + * the bottom of the frame.
> + */
> +#define CHECK_X 8
> +#define CHECK_Y 6
> +/*
> + * Start checking after this many frames since resetting the sensor.
> + * Sometimes the first frame(s) is(/are) black which could trigger
> + * unwanted reset(s).
> + */
> +#define JAM_CHECK_AFTER 3
> +/*
> + * If the sensor is quickly brough into bright conditions from dark,
> + * it may temporarily be saturated, leaving out the normal background
> + * noise. This many saturated frames may go through before the sensor
> + * is considered jammed.
> + */

typo. s/brough/brought

I will see if I can test this new sensor interface changes with ov9640 on H4.

-- 
--Trilok Soni
