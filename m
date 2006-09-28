From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: correct misc 15xx and non-15xx platform code
Date: Thu, 28 Sep 2006 16:58:50 +0300
Message-ID: <20060928135849.GI29453@atomide.com>
References: <fb249edb0609221301u6fc66d0ci51ddf77449a2656f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0609221301u6fc66d0ci51ddf77449a2656f@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrog@zabor.org> [060922 23:02]:
> Disable accesses to SOFT_REQ_REG2 and ULPD_SOFT_DISABLE_REQ_REG
> registers for 15xx processors that don't have these registers. Enable
> level 2 interrupt handler for processors that identify as OMAP 15xx
> (e.g 310) and not 1510 specifically. Also fix the following compiler
> warning (only visible with CONFIG_OMAP_RESET_CLOCKS):
> 
> arch/arm/mach-omap1/clock.c: In function 'omap1_clk_disable_unused':
> arch/arm/mach-omap1/clock.c:634: warning: 'return' with a value, in
> function returning void
> 
> Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>

Pushing today.

Tony
