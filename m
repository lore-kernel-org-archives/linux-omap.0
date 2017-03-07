From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/5] ARM: OMAP2+: Add and enable operating-points-v2
Date: Tue, 7 Mar 2017 10:17:37 +0530
Message-ID: <20170307044737.GG8206@vireshk-i7>
References: <1488813822-26042-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1488813822-26042-1-git-send-email-d-gerlach@ti.com>
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Lukasz Majewski <lukma@denx.de>, Yegor Yefremov <yegorslists@googlemail.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 06-03-17, 09:23, Dave Gerlach wrote:
> Hi,
> This series adds the necessary changes to get proper operating-points-v2 tables
> for AM335x/AM437x/DRA7xx/AM57xx TI SoCs. Doing this enables the ti-cpufreq
> driver and allows the platform to detect which CPU OPPs are valid for the
> configuration in use and enable them.
> 
> This series adds complete tables for am335x and adds 1GHz support for all
> beaglebone black boards and updates the already merged but unused am437x table
> to match the finalized DT bindings. It also moves the existing dra7xx/am57xx
> OPPs to OPPv2 but does not enable 1.5GHz yet as this requires multiregulator
> support which will come at a later date.
> 
> Also, now that so many TI platforms will depend on the ti-cpufreq driver let's
> add CONFIG_ARM_TI_CPUFREQ to omap2plus_defconfig to enable it as part of the
> default configuration.
> 
> Pushed a branch containing these patches on top of v4.11-rc1 if anyone wants
> to try it out [1].

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
