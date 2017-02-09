From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 2/4] Documentation: dt: add bindings for ti-cpufreq
Date: Thu, 09 Feb 2017 01:02:53 +0100
Message-ID: <5995162.mH49F4H7nS@aspire.rjw.lan>
References: <20170203172929.23940-1-d-gerlach@ti.com>
 <CAL_Jsq+955fra0P8FFWd4-f2rLyJVMwo-FBRfeqqeO=a8m0NnA@mail.gmail.com>
 <2aba1159-9a48-329f-2a54-8079b32b06e2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2aba1159-9a48-329f-2a54-8079b32b06e2@ti.com>
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
Cc: Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Majewski <lukma@denx.de>, Rob Herring <robh+dt@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday, February 08, 2017 08:45:55 AM Dave Gerlach wrote:
> On 02/08/2017 08:44 AM, Rob Herring wrote:
> > On Fri, Feb 3, 2017 at 11:29 AM, Dave Gerlach <d-gerlach@ti.com> wrote:
> >> Add the device tree bindings document for the TI CPUFreq/OPP driver
> >> on AM33xx, AM43xx, DRA7xx, and AM57xx SoCs. The operating-points-v2
> >> binding allows us to provide an opp-supported-hw property for each OPP
> >> to define when it is available. This driver is responsible for reading
> >> and parsing registers to determine which OPPs can be selectively enabled
> >> based on the specific SoC in use by matching against the opp-supported-hw
> >> data.
> >>
> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> >> ---
> >
> > [...]
> >
> >> +/*
> >> + * cpu0 has different OPPs depending on SoC revision and some on revisions
> >> + * 0x2 and 0x4 have eFuse bits that indicate if they are available or not
> >> + */
> >> +cpu0_opp_table: opp_table {
> >
> > One step closer, but as I showed last time, use a '-', not '_'.
> 
> I apologize I thought the comment was only about the 0, completely missed the 
> underscore, you are correct, thanks.

Please send an update of this patch, then.

Thanks,
Rafael
