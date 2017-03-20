From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 5/9] ARM: OMAP2+: hwmod: assign main clock from DT if
 available
Date: Mon, 20 Mar 2017 07:36:05 -0700
Message-ID: <20170320143605.GI20572@atomide.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
 <1489741781-12816-6-git-send-email-t-kristo@ti.com>
 <20170317154126.GU20572@atomide.com>
 <f7c795dc-13db-9157-cdcc-b61892cc73f9@ti.com>
 <20170317221728.GX20572@atomide.com>
 <95b7142f-8cc7-5909-764e-05dbad434298@ti.com>
 <20170320143433.GG20572@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170320143433.GG20572@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: mturquette@baylibre.com, linux-omap@vger.kernel.org, sboyd@codeaurora.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [170320 07:37]:
> * Tero Kristo <t-kristo@ti.com> [170320 06:25]:
> > On 18/03/17 00:17, Tony Lindgren wrote:
> > > I don't quite follow you, what breaks if you fall back to the old clock
> > > lookup if no "ti,hwmods" is set?
> > 
> > I think I misunderstood your earlier comment. So basically the code already
> > bails out early if ti,hwmods is not set. In this case, the earlier lookup
> > done by hwmod core sets the node pointer for this code to be NULL, and this
> > just parses the existing main_clk info.
> 
> OK thanks for confirming that.

And also for this patch:

Acked-by: Tony Lindgren <tony@atomide.com>
