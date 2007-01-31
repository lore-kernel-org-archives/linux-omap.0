From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Convert irq flags SA_* to IRQF_*
Date: Wed, 31 Jan 2007 11:16:19 -0800
Message-ID: <20070131191619.GN27224@atomide.com>
References: <45BDEC2B.3000601@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <45BDEC2B.3000601@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux_omap_open_source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Dirk Behme <dirk.behme@googlemail.com> [070129 04:45]:
> Convert remaining interrupt flags SA_* to IRQF_* style.
> 
> Documentation/feature-removal-schedule.txt tells us:
> 
> What:    Interrupt only SA_* flags
> When:    Januar 2007
> Why:    The interrupt related SA_* flags are replaced by 
> IRQF_* to move them
>     out of the signal namespace.
> 
> and in linux/interrupt.h regarding SA_* we find
> 
> "Migration helpers. Scheduled for removal in 1/2007 Do not 
> use for new code !"
> 
> Current -rt patches remove SA_* already, so seems to be time 
> to convert all OMAP stuff.
> 
> In attachment there are 12 patches for this (feel free to 
> regroup them):
> 
> 01 plat-omap directory conversion
> 02 mach-omap1 directory conversion
> (Note: mach-omap2 has no SA_*)
> 03 ads7846 conversion
> 04 omap-ts directory conversion
> 05 i2c-chips directory conversion
> 06 rtc-omap conversion
> 07 tsc2102 conversion
> 08 musbhsdma conversion
> 09 tahvo-usb conversion
> 10 omap-rtc conversion
> 11 innovator-ps2 conversion
> 12 omap16xxcam conversion

Thanks, I've pushed them in two parts and added the omap core changes to
the linux-omap-upstream tree too.

Regards,

Tony
