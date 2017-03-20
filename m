From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 8/9] ARM: dts: omap4: add clkctrl nodes
Date: Mon, 20 Mar 2017 07:35:39 -0700
Message-ID: <20170320143538.GH20572@atomide.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
 <1489741781-12816-9-git-send-email-t-kristo@ti.com>
 <20170317154333.GW20572@atomide.com>
 <9456caee-4f45-044a-0b2e-305fa2d0d274@ti.com>
 <b602ccba-489f-e78f-0011-6d808bca9f84@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <b602ccba-489f-e78f-0011-6d808bca9f84@ti.com>
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

* Tero Kristo <t-kristo@ti.com> [170320 06:27]:
> On 17/03/17 23:41, Tero Kristo wrote:
> > On 17/03/17 17:43, Tony Lindgren wrote:
> > > * Tero Kristo <t-kristo@ti.com> [170317 02:12]:
> > > > Add clkctrl nodes for OMAP4 SoC. These are going to be acting as
> > > > replacement for part of the existing clock data and the existing
> > > > clkctrl hooks under hwmod data.
> > > 
> > > It seems to be actually this patch in the series that breaks booting
> > > if the last patch in this series is not applied.
> > 
> > Yea I guess we need to squash this and patch #9, I'll double check next
> > week. Sorry about not catching this one.
> 
> Yes, patch #8 and #9 must be squashed. What happens with patch #8 alone, is
> that you get all the clkctrl clocks registered, but as nobody is using them,
> the clock core disables them later on in clk_disable_unused.

So how hard would it to do a mixed approach where we don't need
to have everything in place in the dts in order to flip a SoC?

This atomic transaction worries me..

Regards,

Tony
