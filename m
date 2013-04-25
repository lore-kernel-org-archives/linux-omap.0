From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH V4 1/6] clk: OMAP: introduce device tree binding to kernel
 clock data
Date: Thu, 25 Apr 2013 12:31:22 +0530
Message-ID: <5178D4C2.7080400@ti.com>
References: <1365807278-554-1-git-send-email-nm@ti.com>
 <1365807278-554-2-git-send-email-nm@ti.com>
 <20130412233142.GE10155@atomide.com> <20130412233900.GA1599@kahuna>
 <20130413172210.GM10155@atomide.com> <20130414211917.GA3275@snafu>
 <20130424162847.8998.73264@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130424162847.8998.73264@quantum>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 24 April 2013 09:58 PM, Mike Turquette wrote:
> Quoting Nishanth Menon (2013-04-14 14:19:17)
>> Overall strategy introduced here is simple: a clock node described in
>> device tree blob is used to identify the exact clock provided in the
>> SoC specific data. This is then linked back using of_clk_add_provider
>> to the device node to be accessible by of_clk_get.
>>
>> Based on discussion contributions from Roger Quadros, Grygorii Strashko
>> and others.
>>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Cc: Mike Turquette <mturquette@linaro.org>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> [tony@atomide.com: co-developed]
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> I can take this into clk-next after the merge window.  Please refresh it
> for -rc1 as we discussed on irc.
> 
> As an aside, will Tero's series for migrating to drivers/clk/omap[1] and
> Rajendra's patch for registering clocks late[2] be refreshed after the

[2] is already in mainline.

> merge window?  It would be nice to combine these efforts.
> 
> Thanks,
> Mike
> 
> [1] http://article.gmane.org/gmane.linux.ports.arm.omap/95948
> [2] http://www.spinics.net/lists/arm-kernel/msg231288.html
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
