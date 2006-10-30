From: Juha Yrjola <juha.yrjola@solidboot.com>
Subject: Re: Recent additions to omap2 clock.c
Date: Mon, 30 Oct 2006 19:04:23 +0200
Message-ID: <45463097.4000405@solidboot.com>
References: <EA12F909C0431D458B9D18A176BEE4A5082AD7D7@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5082AD7D7@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Richard,

Thanks for reviewing the changes, and sorry for the late reply -- I was 
out-of-office for two weeks.

Woodruff, Richard wrote:
> Juha,
> 
> I was looking to do some merging and I see you added the following:
> 	1: Force APLL always on control
> 	2: Enable/Disable for osc_clk
> 	3: addition delays: clk_wait_ready, wmb
> 
> For 1 and 2:
> Aren't these more functions of idle control? I was looking at porting
> over some of the omap1 idle api's and I though that associating the auto
> idle's of APLLs and the like would map to this. Is there any reason you
> didn't take this route also?

It looks like the idle control of the APLLs by hardware is pretty 
efficient, so we didn't see any reason to manually control their usage. 
  Can you think of a use case?

osc_clk is a different story.  It's an external clock, and other 
peripherals besides OMAP might be using it.  The external oscillator 
control might be controlled by only OMAP, however.  In my opinion, if 
the driver says clk_enable to a clock, it should be guaranteed that the 
clock remains active until a matching clk_disable is called.

> For 3: 
> the original clock code had a clk_safe() api which was called after
> clock enables to synchronize and let the caller know if all was ok. You
> might find when the functional clock was slow (32KHz) it might take a
> cycle for the peripheral to be accessible, generally after a wake up. If
> you are talking about a timer, you must also watch posting vs.
> non-posting and the interconnect ratio during DVFS.

I believe that clk_enable() should make sure the clock is indeed active 
and usable, and not return before it is so.

> Also, status isn't always as you would infer. Some blocks didn't hook
> up the OCP control signals so they don't consult with the module before
> setting status. Other combined target/initiators like DSS only tie to
> mstandby state for idle, so you must stop mute before access works properly.

Thanks for your info.  Could you elaborate on what clocks exactly need 
special handling?

Cheers,
Juha
