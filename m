From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP baseline test results for v3.10-rc6
Date: Tue, 2 Jul 2013 04:29:20 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83ECCC435@DBDE04.ent.ti.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com>
 <20130625160243.GE22312@arwen.pp.htv.fi>
 <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com>
 <51C9F0A8.1050607@ti.com> <87fvw6t136.fsf@linaro.org>
 <79CD15C6BA57404B839C016229A409A83ECC952D@DBDE04.ent.ti.com>
 <51CAEB33.5010101@ti.com>
 <alpine.DEB.2.02.1306261722520.6135@utopia.booyaka.com>
 <51CBBCD8.5030600@ti.com>
 <alpine.DEB.2.02.1306281844090.8767@utopia.booyaka.com>
 <alpine.DEB.2.02.1307010211580.3741@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.02.1307010211580.3741@utopia.booyaka.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>, "Vutla, Lokesh" <lokeshvutla@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "Rini, Tom" <trini@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Monday, July 01, 2013 7:46 AM
> To: Vutla, Lokesh
> Cc: Nayak, Rajendra; Hiremath, Vaibhav; Kevin Hilman; Rini, Tom; linux-
> omap@vger.kernel.org; Balbi, Felipe; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: OMAP baseline test results for v3.10-rc6
> 
> On Fri, 28 Jun 2013, Paul Walmsley wrote:
> 
> > On Thu, 27 Jun 2013, Lokesh Vutla wrote:
> >
> > > Here is the catch..
> > > Your dtb is generated in arch/arm/boot/dts/ folder(before V3.8 dtb
> was
> > > generated in arch/arm/boot).
> >
> > Ugh... that's probably it :-(
> 
> Indeed, this was at least one major problem.  With this fixed, and with
> CONFIG_MACH_OMAP_GENERIC=y in the v3.10-rc Kconfigs, the BeagleBone
> white
> boots here now with v3.10-rc7.  Will test the previous releases going
> back

Surely it will boot. :)

Thanks,
Vaibhav
