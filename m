From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 2/4] Documentation: dt: add bindings for ti-cpufreq
Date: Thu, 9 Feb 2017 23:03:21 +0100
Message-ID: <CAJZ5v0hT4peuRQUrLHC32GmVSoa6Npv2qutNo2WEhne72hHi6A@mail.gmail.com>
References: <20170203172929.23940-3-d-gerlach@ti.com>
 <20170209153549.8354-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170209153549.8354-1-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lukasz Majewski <lukma@denx.de>, Rob Herring <robh+dt@kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 9, 2017 at 4:35 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
> Add the device tree bindings document for the TI CPUFreq/OPP driver
> on AM33xx, AM43xx, DRA7xx, and AM57xx SoCs. The operating-points-v2
> binding allows us to provide an opp-supported-hw property for each OPP
> to define when it is available. This driver is responsible for reading
> and parsing registers to determine which OPPs can be selectively enabled
> based on the specific SoC in use by matching against the opp-supported-hw
> data.
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---

I applied this (with the Rob's ACK) along with the rest of the series
and I fixed up things that didn't apply and didn't build and I was not
amused by that at all.

In particular, Viresh, if you ACK something, please make sure that it
doesn't conflict with your own patches.

Thanks,
Rafael
