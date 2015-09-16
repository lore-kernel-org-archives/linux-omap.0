From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [GIT PULL] omap fixes against v4.3-rc1
Date: Wed, 16 Sep 2015 09:33:14 -0700
Message-ID: <7hwpvqfho5.fsf@deeprootsystems.com>
References: <20150915154650.GS10928@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150915154650.GS10928@atomide.com> (Tony Lindgren's message of
 "Tue, 15 Sep 2015 08:46:50 -0700")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
>
>   Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/fixes-rc1
>
> for you to fetch changes up to 60fdcb8863d9b4a8b6c6b367886fadb50d4c0b07:
>
>   ARM: dts: Fixup model name for HP t410 dts (2015-09-14 13:33:47 -0700)
>
> ----------------------------------------------------------------
> Fixes for omaps against v4.3-rc1:
>
> - Fix long time regression on beagle for tfp410 pin muxing
>
> - Fix dm814x control base address typo and related Ethernet
>   phy configuration
>
> - Fix igepv2 Ethernet pinmuxing as only some boards have it
>
> - Fix pbias regulator compatible values as a pending regulator
>   fix needs those for MMC1 to work properly
>
> - Fix beagle-x15 MMC1 regulator and make pcf857x built-in
>
> - Fix omap5 and dra7 Kconfig options when built as the only
>   SoCs selected
>
> - Fix PM errata for omap5 and dra7 as they too need it
>
> - Fix phycore mpu voltage
>
> Also included are a few cosmetic fixes:
>
> - Remove unused of_irq macros
>
> - Fix dra7 ethernet name
>
> ----------------------------------------------------------------

Thanks, pulled into fixes.

Kevin
