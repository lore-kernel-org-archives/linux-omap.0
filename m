From: Hunyue Yau <hyau@mvista.com>
Subject: Re: [PATCH] OMAP: 2430SDP: Support LCD display as a FB device
Date: Fri, 25 May 2007 17:20:36 -0700
Message-ID: <200705251720.37116.hyau@mvista.com>
References: <200705251518.13137.hyau@mvista.com> <46576B90.2050508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <46576B90.2050508@gmail.com>
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
To: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Friday 25 May 2007 16:04, Dmitry Krivoschekov wrote:
> Hunyue Yau wrote:
> >
> > +#define TWL4030_VAUX2_DEV_GRP           0x1B 
> > +#define TWL4030_VAUX2_DEDICATED         0x1E
> > +#define TWL4030_MODULE_PM_RECIEVER  0x13
> > +
> > +
> > +
> 
> What's the reason to re-define this?
> It's already defined in asm/arch/twl4030.h.
> 
> 
> Thanks,
> Dmitry
> 
Sorry, an oversight. This goes on top of the original patch. More 
potential changes pending the mentioned discussions.

-- Hunyue

--- linux-omap-2.6/drivers/video/omap/lcd_2430sdp.c	2007-05-24 18:32:24.000000000 -0700
+++ linux-omap-2.6.work/drivers/video/omap/lcd_2430sdp.c	2007-05-25 16:11:10.000000000 -0700
@@ -35,11 +35,6 @@
 #define PM_RECEIVER             TWL4030_MODULE_PM_RECIEVER
 #define ENABLE_VAUX2_DEDICATED  0x09
 #define ENABLE_VAUX2_DEV_GRP    0x20
-#define TWL4030_VAUX2_DEV_GRP           0x1B 
-#define TWL4030_VAUX2_DEDICATED         0x1E
-#define TWL4030_MODULE_PM_RECIEVER  0x13
-
-
 
 #define t2_out(c, r, v) twl4030_i2c_write_u8(c, r, v)
 
