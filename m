From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] Add hwmod data for IPU & DSP processors/MMUs
Date: Fri, 22 Sep 2017 14:19:19 -0700
Message-ID: <20170922211919.GD4394@atomide.com>
References: <20170821234818.4755-1-s-anna@ti.com>
 <d4715d1e-8113-050b-9a0f-77f4a4486081@ti.com>
 <20170922175110.GC4394@atomide.com>
 <de9b14a1-250e-c73d-d999-468a50e6b1a3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <de9b14a1-250e-c73d-d999-468a50e6b1a3@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Suman Anna <s-anna@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [170922 14:08]:
> On 09/22/2017 12:51 PM, Tony Lindgren wrote:
> > * Suman Anna <s-anna@ti.com> [170922 10:19]:
> >> Ping on this series. Tero's clkctrl series changes are orthogonal to
> >> these changes.
> > 
> > With patch 5/8 you said earlier "It will still be a shared set
> > between the MMU and remoteproc drivers, but let me look into
> > how these get integrated." So was there any conclusion there?
> > 
> > Also, what's the deal with these omap4 changes that I commented
> > on in 5/8?
> 
> Tony,
> So, looking at code, removing modulemode on hwmod does change the
> semantics as that will not plug in the clkctrl clk (_omap4_xlate_clkctrl
> will return 0) into the hwmod and will fall back. So, this should make
> it compatible to the existing code before adding the clkctrl dt nodes,
> and Patch 5 will be good to avoid the crash when disabling the processor
> nodes. That said, now that the modulemode is controlled by the
> ti-clkctrl code, I would expect to get the refcounting for free due to
> clk_enable() semantics if the same clkctrl clk is plugged under two
> nodes (MMU and processor) and I may not need to remove the modulemode.
> One of the main reasons for removing the modulemode is the lack of
> refcounting on modulemode in the original code.

OK. Sounds like you can get the refcounting for free just by modifying
the dts as done for example for musb on omap4 in "[PATCH 10/10] ARM:
dts: Use ti-sysc module driver for omap4 musb" in that series. You
will need also the rest of the patches from that series naturally :)

That is as long as MMU and processor are both child devices in the
same interconnect target module.

> In anycase, I need to retest this with all of required patches from Tero
> (current mainline does not yet have the clkctrl dt nodes).

OK

> Tero,
> Do you have these patches rebased onto 4.14-rc1 (preferable if it is
> rebased onto Tony's omap-for-v4.15/soc branch. I tried cherry-picking
> from your github test branch (based on 4.13-rc3), but am running into
> some L3Noc errors once I add the clkctrl dts node patch on Panda4 using NFS.

Yeah I noticed that and emailed Tero about it. It seems to trigger
with built-in musb and DEBUG_KERNEL disabled, not sure what triggers
it. Only happens after the clkctrl nodes are added.

Regards,

Tony
