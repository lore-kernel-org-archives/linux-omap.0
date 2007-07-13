From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: Common code for TSC 2101 and 2102
Date: Fri, 13 Jul 2007 12:40:08 +0530
Message-ID: <5d5443650707130010i3327f533o9c480f249ea6d796@mail.gmail.com>
References: <fb249edb0706040644w55ac4c55k495ae2050f94aea0@mail.gmail.com>
	<5d5443650707122346n5d9e6fcfyfb3bb0fc2df54d57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5d5443650707122346n5d9e6fcfyfb3bb0fc2df54d57@mail.gmail.com>
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
To: andrzej zaborowski <balrogg@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Andrej,

On 7/13/07, Trilok Soni <soni.trilok@gmail.com> wrote:
> Hi All,
>
> On 6/4/07, andrzej zaborowski <balrogg@gmail.com> wrote:
> > Hi,
> >   here's a proposition of a common driver for TSC 2101 and 2102 based
> > on the previous 2102 code - the difference between the two chips'
> > registers turns out to be minimal, not considering the audio part.
> > 2101 provides a superset of 2102 functionality for the most part.
>
> Anybody on list who can review this approach. We need to get this
> thing sorted out and have alsa-audio ASoC support on 2420 H4 and
> finally in mainline.
>
> >
> > I will appreciate if anyone with a board using a TSC2101 could test
> > how this works for them, and even more if they can fix the parts that
> > possibly don't work. The part that needs to go into the board file is
> > similar to that in arch/arm/mach-omap1/board-palmte.c. Audio is not
> > expected to work, but touchscreen and hwmon parts work for me.
>
> I will try to review this patch, and not sure when I can test it
> touchscreen part on H4.

First cut output of checkpatch, if everyone agrees on your approach,
you can add changes suggested below:

spinlock_t definition without comment
#102: FILE: drivers/hwmon/tsc210x_sensors.c:41:
+       spinlock_t apm_lock;

no space before that '++' (ctx:WxO)
#815: FILE: drivers/spi/tsc210x.c:260:
+                       (*transfer)->rx_buf = data ++;
                                                   ^

printk() should include KERN_ facility level
#852: FILE: drivers/spi/tsc210x.c:297:
+               printk("TSC210x: data in");

need consistent spacing around '|' (ctx:WxV)
#956: FILE: drivers/spi/tsc210x.c:401:
+       if (dev->status & (TSC210X_PS_DAV | TSC210X_T1_DAV |TSC210X_T2_DAV))
                                                           ^

#if 0 -- if this code redundant remove it
#1308: FILE: drivers/spi/tsc210x.c:753:
+#if 0

printk() should include KERN_ facility level
#1704: FILE: drivers/spi/tsc210x.c:1149:
+       printk(banner);

EXPORT_SYMBOL(foo); should immediately follow its function/variable
#1729: FILE: drivers/spi/tsc210x.c:1174:
+EXPORT_SYMBOL(tsc210x_read_sync);

EXPORT_SYMBOL(foo); should immediately follow its function/variable
#1730: FILE: drivers/spi/tsc210x.c:1175:
+EXPORT_SYMBOL(tsc210x_reads_sync);

EXPORT_SYMBOL(foo); should immediately follow its function/variable
#1731: FILE: drivers/spi/tsc210x.c:1176:
+EXPORT_SYMBOL(tsc210x_write_sync);

EXPORT_SYMBOL(foo); should immediately follow its function/variable
#1732: FILE: drivers/spi/tsc210x.c:1177:
+EXPORT_SYMBOL(tsc210x_keyclick);

do not add new typedefs
#1796: FILE: include/linux/spi/tsc210x.h:54:
+typedef void (*tsc210x_touch_t)(void *context, int touching);

do not add new typedefs
#1797: FILE: include/linux/spi/tsc210x.h:55:
+typedef void (*tsc210x_coords_t)(void *context, int x, int y, int z1, int z2);

do not add new typedefs
#1798: FILE: include/linux/spi/tsc210x.h:56:
+typedef void (*tsc210x_ports_t)(void *context, int bat[], int aux[]);

do not add new typedefs
#1799: FILE: include/linux/spi/tsc210x.h:57:
+typedef void (*tsc210x_temp_t)(void *context, int temp);

Missing Signed-off-by: line(s)
Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

-- 
--Trilok Soni
