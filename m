From: Imre Deak <imre.deak@nokia.com>
Subject: Re: OMAP5912 touchscreen irq not working
Date: Sat, 27 May 2006 23:10:53 +0300
Message-ID: <1148760653.7041.19.camel@mammoth.research.nokia.com>
References: <4477F2BA.3080907@gmail.com>
	<200605270851.22051.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <200605270851.22051.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Sat, 2006-05-27 at 08:51 -0700, ext David Brownell wrote:
> On Friday 26 May 2006 11:33 pm, Dirk Behme wrote:
> 
> > Can anybody else reproduce this?
> 
> Just tried it ... /proc/interrupts shows a few IRQs, but I get no
> touchscreen data.

I noticed that the ads7846 sampling rate is set too high in board-osk.c.
The spec allows a maximum bus frequency of 2.5MHz which gives a ~96k
sample rate. There is also the uwire clock patch in my previous post,
which might have an effect on this issue.

--Imre

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index e0711d2..bc4269b 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -317,7 +317,7 @@ static struct spi_board_info __initdata 
 	.modalias		= "ads7846",
 	.platform_data		= &mistral_ts_info,
 	.irq			= OMAP_GPIO_IRQ(4),
-	.max_speed_hz		= 120000 /* max sample rate at 3V */
+	.max_speed_hz		= 96000 /* max sample rate at 3V */
 					* 26 /* command + data + overhead */,
 	.bus_num		= 2,
 	.chip_select		= 0,


> 
> - Dave
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
