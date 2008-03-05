From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Resending PATCH 2/2] ARM: OMAP2: rtc board specific code
Date: Wed, 5 Mar 2008 11:44:33 +0200
Message-ID: <20080305094432.GB8106@atomide.com>
References: <20080124223246.GH13765@atomide.com>
	<028b01c85f0e$c9353f30$988818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <028b01c85f0e$c9353f30$988818ac@ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Girish <girishsg@ti.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Girish,

* Girish <girishsg@ti.com> [080125 06:57]:
>  
> 
> >-----Original Message-----
> >From: Tony Lindgren [mailto:tony@atomide.com] 
> 
>  msecure/gpio-22 line 
> >connected to T2 */
> >> +	if (is_device_type_gp() && 
> >is_sil_rev_less_than(OMAP3430_REV_ES2_0)) {
> >> +		u32 msecure_pad_config_reg = omap2_ctrl_base + 0xA3C;
> >> +		int mux_mask = 0x04;
> >> +		u16 tmp;
> >
> >Let's wait a bit on this one until we have the 
> >omap_ctrl_read/write stuff merged, then update this patch for it.
> 
> Yes, we can do that.

Could you please refresh your RTC patch now?

Tony
