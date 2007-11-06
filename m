From: Paul Walmsley <paul@booyaka.com>
Subject: RE: [PATCH 1/5] mach:omap: some correction in Clock 34XX
Date: Tue, 6 Nov 2007 02:48:42 -0700 (MST)
Message-ID: <Pine.LNX.4.64.0711060243080.25907@utopia.booyaka.com>
References: <AC2D475575504148943F5EB0938951C4010B0C42@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <AC2D475575504148943F5EB0938951C4010B0C42@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Choraria, Rohit" <rohitkc@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Rohit,

On Mon, 5 Nov 2007, Choraria, Rohit wrote:

> When we were debugging the clock code, we found that the change in clock.c was required to reflect the correct rate of dpll4_x2_ck.
> 
>  	v = cm_read_reg(dd->control_reg) & dd->enable_mask;
>  -	if (v != DPLL_LOCKED)
>  +	if (v != dd->enable_mask)
>  		clk->rate = clk->parent->rate;
>  	else
>  		clk->rate = clk->parent->rate * 2;
> 
> Previously, DPLL_LOCKED was defined as 0x7 - this worked for DPLL3 but for DPLL4, the value is supposed to be 0x7000. 

Good point.  That code was broken.

> If there was an enable_bit in dpll_data structure, we could have shifted DPLL_LOCKED by enable_bit and compared with the register value.
> Since the current implementation will return wrong rate for DPLL4, we made this modification. 
> Can you suggest some other way of implementing this.

I would suggest: 

	v = cm_read_reg(dd->control_reg) & dd->enable_mask;
+       v >>= mask_to_shift(dd->enable_mask);
	if (v != DPLL_LOCKED)
		clk->rate = clk->parent->rate;
	else
		clk->rate = clk->parent->rate * 2;


- Paul
