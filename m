From: Paul Walmsley <paul@pwsan.com>
Subject: RE: clock regression and note.
Date: Fri, 10 Aug 2007 23:37:23 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0708102331390.29082@utopia.booyaka.com>
References: <3B6D69C3A9EBCA4BA5DA60D913027429019C4F91@dlee13.ent.ti.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429019C4FAD@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429019C4FAD@dlee13.ent.ti.com>
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

On Fri, 10 Aug 2007, Woodruff, Richard wrote:

> This fixes it.  Patch #2 of #22 was not right.
>
> What is happening is the u-boot (or other) flash is expected to set the 
> APLL field properly via gauging at boot.  It must do this before 
> enabling the APLLs.
>
> Therefore when you start up you can look at the APLL value to see what 
> your sys_clk rate is actually set to.  From there you multiply the upper 
> divider a 1 or 2 to the sys_clk rate to get the osc_clk rate.

Thanks - makes sense.  That patch should be replaced with the original 
code.  omap2_get_crystal_rate() has to work backwards from the APLL rate 
backwards (towards the root of the clock tree, rather than from the root 
outwards), since there doesn't seem to be any way to query the sys_clk 
rate directly.

Might be nice if we put a comment to that effect on the function.  It's a 
little counterintuitive to be multiplying by 'div'...

- Paul
