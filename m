From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Update am437x and am335x dts to probe with ti-sysc
Date: Thu, 27 Sep 2018 14:43:28 -0700
Message-ID: <20180927214327.GF5662@atomide.com>
References: <e9afe736-c2f0-6182-afd0-08279e09a35e@ti.com>
 <20180925144021.GN5662@atomide.com>
 <20180925175537.GQ5662@atomide.com>
 <d98aa7c1-5131-34c5-51e5-c7ef57cbc31e@ti.com>
 <20180926155911.GT5662@atomide.com>
 <20180926162303.GU5662@atomide.com>
 <cfc3f1db-9468-ed92-a673-882b51b4dec8@ti.com>
 <20180926233111.GY5662@atomide.com>
 <305bf1c3-915d-dac1-95e4-4d32621247e1@ti.com>
 <20180927145332.GA5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180927145332.GA5662@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180927 14:58]:
> * Keerthy <j-keerthy@ti.com> [180927 05:00]:
> > On Thursday 27 September 2018 05:01 AM, Tony Lindgren wrote:
> > > The following works for me, does it look OK to you?
> > 
> > This works pretty well with DS0 on am437x-gp-evm. Tested rtc wakeup,
> > wakeup using uart and touch. All of the work well.
> > 
> > https://pastebin.ubuntu.com/p/RJhJJKhJHX/
> 
> OK good to hear and thanks for testing again.
> 
> > Also tested on beaglebone black DS0 works fine. Although there seems to
> > be an additional warning which was not seen before:
> > 
> > "l4-wkup-clkctrl:0008:0: failed to disable"
> > 
> > log: https://pastebin.ubuntu.com/p/Ns2WRdVkXS/
> > 
> > Also the above warning is present without/with this patch on [0].
> > No such warnings on am4 though.
> 
> OK. For am335x I'll post an updated version of the am335x
> changes to fix the gpio dbck offset.

FYI I have pushed updated patches into a new temporary test
branch omap-for-v4.20/dt-ti-sysc-tmp-testing-v2 with initial
dra7 dts changes too.

Regards,

Tony
