From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 0/4] clk: dt: add support for default rate/parent
Date: Thu, 20 Mar 2014 14:23:08 -0700
Message-ID: <20140320212308.21989.36094@quantum>
References: <1392282048-6284-1-git-send-email-t-kristo@ti.com>
 <53172239.3030705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <53172239.3030705@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Tero Kristo (2014-03-05 05:10:17)
> Ping.
> 
> Mike, any feedback on this?

Hi Tero,

Have you seen Sylwester's approach[1]? I prefer it since it is more
device-oriented and less "centralized". The clock consumer enumerates
the default parent or rate of a consumed clock. This can be made to work
like your approach by having the clock driver consume these clocks and
set them up with default rates or parents. What do you think?

Regards,
Mike

[1] https://lkml.org/lkml/2014/3/3/324

> 
> -Tero
> 
> On 02/13/2014 11:00 AM, Tero Kristo wrote:
> > Hi,
> >
> > This set is a mix-match of new DT properties for generic and TI specific
> > clock drivers. Basically provided for commenting purposes. The patches
> > provide a way to configure clock parents / rates during boot through DT.
> >
> > "default-rate" : sets rate of a clock during boot, supported for any DT
> >                clock type (through generic clock driver)
> > "ti,default-parent" : selects a default parent for a multiplexer clock,
> >                     only supported for TI specific mux clock for now,
> >                     as generic mux clock does not support DT clocks
> >
> > Patch #4 provided as a reference how to move the default rates / parents
> > from kernel code to DT.
> >
> > Default-rate logic in patch #2 looks somewhat complicated, as the clocks
> > need to be sorted based on their parents to avoid cases where a child clock
> > would set its rate first, just to be overridden by its parent changing
> > rate later and resulting in incorrect rate for the child clock.
> >
> > If the default-rate generic property is not going to fly, it can be moved
> > to TI only drivers also.
> >
> > -Tero
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> 
