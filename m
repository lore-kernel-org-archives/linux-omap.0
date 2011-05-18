From: "Will Deacon" <will.deacon@arm.com>
Subject: RE: [PATCH] ARM: fix mistaken dependency for CPU_HAS_PMU
Date: Wed, 18 May 2011 09:47:33 +0100
Message-ID: <39321.6859818951$1305708491@news.gmane.org>
References: <1305686080-13182-1-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1305686080-13182-1-git-send-email-tom.leiming@gmail.com>
Content-Language: en-gb
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tom.leiming@gmail.com, linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

> From: Ming Lei <tom.leiming@gmail.com>
> 
> Obviously it is mistake for CPU_HAS_PMU to depend on
> (!ARCH_OMAP3 || OMAP3_EMU).

It's not that obvious!
 
> No mattery it is omap3 or not, we can build pmu.o into
> kernel safely. In fact, arm-v7 of omap3 has pmu inside
> also.

Yes, but the PMU on Omap3 doesn't work unless you enable the emu clk, which
is done in kernel/etm.c. Rather than duplicate that code (which only seems
to be needed for Omap anyway) I decided to add a dependency on OMAP3_EMU so
the clock gets enabled in etb_probe.

> So fix it that we can build pmu into kernel to support perf
> for some valid config(such as enable both omap4 and omap3,
> but OMAP3_EMU).

No, I don't like this. The reason I don't like it is because it will lead to
lots of bug reports that perf doesn't work on Omap3 because they haven't got
the emu clock ticking. It was this scenario that led to the dependency being
introduced in the first place:

8954bb0d ("OMAP3: pmu: make CPU_HAS_PMU dependent on OMAP3_EMU")

Is there a problem building the etm support for Omap4?

Will
