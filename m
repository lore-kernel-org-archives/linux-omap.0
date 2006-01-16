From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Replace clk_use/unuse with clk_enable/disable,
	please test
Date: Mon, 16 Jan 2006 10:52:40 -0800
Message-ID: <20060116185239.GJ4511@atomide.com>
References: <20060114011236.GQ5499@atomide.com>
	<7AF192DA69C59243838FF62851F64F5501B00F46@toebe101.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <7AF192DA69C59243838FF62851F64F5501B00F46@toebe101.NOE.Nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Toshihiro.Kobayashi@nokia.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Toshihiro.Kobayashi@nokia.com <Toshihiro.Kobayashi@nokia.com> [060116 02:16]:
> Hi,
> 
> Here's a further patch to centralize the pm code. (patch-dsp_ckfix3)

Thanks, pushing today.
 
> >From: ext Tony Lindgren [mailto:tony@atomide.com] 
> >Sent: Saturday, January 14, 2006 10:13 AM
> 
> >Thanks for deciphering it :) I wonder if we could just take care of the
> >temporary enable in the clock framework?
> 
> I tried, please look at the one more patch.
> (patch-clk_enable_force-test)
> But I myself don't agree with this patch ;-(

OK
 
> I feel it's too arbitrate to add clk_enable_force() and
> clk_disable_force() to the clk_functions struct, only for the
> pm code. And I think it's OK to do raw register accesses within
> the pm code, including clock enableing / disabling, since anyway
> the assembler part (omapXXXX_idle_loop_suspend) does such
> operations.

Yeah, some direct register access is needed in PM code...

Tony
