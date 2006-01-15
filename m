From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Palm TE Touchscreen and fixes
Date: Sun, 15 Jan 2006 12:19:50 -0800
Message-ID: <20060115201949.GF5905@atomide.com>
References: <fb249edb0601141306o6eb43a9o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0601141306o6eb43a9o@mail.gmail.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Good to hear you got things working against the current git tree!

* andrzej zaborowski <balrogg@gmail.com> [060115 12:00]:
> 
> - The first one fixes the compilation errors and some clock issues
> that made the kernel hang on boot on Palm Tungsten E. While these
> changes make the kernel boot and work well with the device, and
> hopefully don't affect other devices, I don't know how correct are my
> ways of fixing it, as I'm completely inexperienced in kernel insides.

Regarding changes to clock.[ch], we should have CLOCK_IN_OMAP1510 and
CLOCK_IN_OMAP3XX separate. At least the DSP clocks should not be on 310
because it does not have a DSP AFAIK. They may be also other clocks that
are not on 310.

Could you please redo the clock.[ch] patch so it adds CLOCK_IN_OMAP3XX,
and masks it only for the clocks you think you have on 310?

Or if you don't know which clocks are on both 310 and 1510, you could
just leave out DSP clocks for now, and enable all other 1510 clocks
also for 310.

Regards,

Tony
