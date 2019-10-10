From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] ARM: dts: omap4+: Add PRM nodes for reset support
Date: Thu, 10 Oct 2019 07:31:33 -0700
Message-ID: <20191010143133.GW5610@atomide.com>
References: <20191010082108.15448-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191010082108.15448-1-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, Stephen Boyd <swboyd@chromium.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [191010 01:21]:
> Hi Tony,
> 
> This series adds the OMAP PRM nodes for reset support for am3, am4,
> omap4, omap5 and dra7 SoCs. The driver support has been queued up by
> Santosh [1].

OK planning on applying these into omap-for-v5.5/prm on top of
Santosh's immutable branch.

But I'm wondering if we should also have an immutable branch for the
clkctrl changes that I can merge in too?

Then with the prm driver changes, clkctrl changes and these, we
have things working for applying some rstctrl using device patches
like the old am335x sgx ti-sysc patch?

Regards,

Tony

> [1] https://patchwork.kernel.org/cover/11179573/
