From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 8/9] ARM: dts: omap4: add clkctrl nodes
Date: Mon, 20 Mar 2017 08:07:39 -0700
Message-ID: <20170320150738.GJ20572@atomide.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
 <1489741781-12816-9-git-send-email-t-kristo@ti.com>
 <20170317154333.GW20572@atomide.com>
 <9456caee-4f45-044a-0b2e-305fa2d0d274@ti.com>
 <b602ccba-489f-e78f-0011-6d808bca9f84@ti.com>
 <20170320143538.GH20572@atomide.com>
 <3a82add5-7d85-458c-f8c1-9e58db6a8949@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <3a82add5-7d85-458c-f8c1-9e58db6a8949@ti.com>
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

* Tero Kristo <t-kristo@ti.com> [170320 07:54]:
> - You can introduce the DTS changes on a clkctrl module basis, e.g.
> introduce the node for l4_per_clkctrl along with the clock node changes for
> the same

I don't mind introducing them all at once, I'm worried about
reverting in case of trouble. But as long as we can revert things on
a clkctrl module basis in case of trouble, we should be good to go as
far as I'm concerned.

Regards,

Tony
