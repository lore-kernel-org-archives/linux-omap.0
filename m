From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 2/4] Documentation: dt: add bindings for ti-cpufreq
Date: Wed, 18 Jan 2017 08:46:57 +0530
Message-ID: <20170118031657.GB11478@vireshk-i7>
References: <20170117131808.29798-1-d-gerlach@ti.com>
 <20170117131808.29798-3-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170117131808.29798-3-d-gerlach@ti.com>
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 17-01-17, 07:18, Dave Gerlach wrote:
> Add the device tree bindings document for the TI CPUFreq/OPP driver
> on AM33xx, AM43xx, DRA7xx, and AM57xx SoCs. The operating-points-v2
> binding allows us to provide an opp-supported-hw property for each OPP
> to define when it is available. This driver is responsible for reading
> and parsing registers to determine which OPPs can be selectively enabled
> based on the specific SoC in use by matching against the opp-supported-hw
> data.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
> v3->v4:
> 	Update to simplify binding, only use "syscon" now to pass control
> 	module register space and let driver handle offsets.
> 
>  .../devicetree/bindings/cpufreq/ti-cpufreq.txt     | 128 +++++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
