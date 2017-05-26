From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 1/3] ARM: OMAP2+: hwmod: assign main clock from DT if
 available
Date: Fri, 26 May 2017 08:44:16 -0700
Message-ID: <20170526154416.GC3717@atomide.com>
References: <1495127772-7486-1-git-send-email-t-kristo@ti.com>
 <1495127772-7486-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1495127772-7486-2-git-send-email-t-kristo@ti.com>
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [170518 10:19]:
> Fix the main clock assignment to assign clkctrl clk from DT as the main
> clock if available. If main clock is assigned via DT, the direct PRCM
> access for module handling is not used on OMAP4+ architectures either,
> as it is assumed the main clock will be doing this instead.

Is this still needed based on what we chatted last week?

I'd like to avoid adding the clkctrl clocks to the wrong node
as we then end up moving them again later on when we have support
for the wrapper device..

Regards,

Tony
