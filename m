From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 5/5] ARM: omap2plus_defconfig: Enable support for
 ti-cpufreq
Date: Mon, 6 Mar 2017 17:24:30 +0100
Message-ID: <20170306172430.5e91b576@jawa>
References: <1488813822-26042-1-git-send-email-d-gerlach@ti.com>
 <1488813822-26042-6-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488813822-26042-6-git-send-email-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@linaro.org>, Yegor Yefremov <yegorslists@googlemail.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, 6 Mar 2017 09:23:42 -0600
Dave Gerlach <d-gerlach@ti.com> wrote:

> AM335x, AM437x, DRA7xx, and AM57xx platforms all now depend on
> ti-cpufreq driver to enable proper OPPs for use with cpufreq, so
> enable the same.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Reviewed-by: Lukasz Majewski <lukma@denx.de>

> ---
>  arch/arm/configs/omap2plus_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig
> b/arch/arm/configs/omap2plus_defconfig index
> f2462a6bdba6..62a4b6cf16f0 100644 ---
> a/arch/arm/configs/omap2plus_defconfig +++
> b/arch/arm/configs/omap2plus_defconfig @@ -64,6 +64,7 @@
> CONFIG_CPU_FREQ_GOV_POWERSAVE=y CONFIG_CPU_FREQ_GOV_USERSPACE=y
>  CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
>  CONFIG_CPUFREQ_DT=m
> +CONFIG_ARM_TI_CPUFREQ=y
>  # CONFIG_ARM_OMAP2PLUS_CPUFREQ is not set
>  CONFIG_CPU_IDLE=y
>  CONFIG_BINFMT_MISC=y




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
