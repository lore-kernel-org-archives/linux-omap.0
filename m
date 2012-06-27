From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Current state of AM33xx patches
Date: Wed, 27 Jun 2012 19:21:01 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA5C1F7@DBDE01.ent.ti.com>
References: <4FD5BA4C.9070706@gmail.com> <4FD5FD9E.5040203@ti.com>
 <CADjby3UTVBKWRZUBRNTX9Bh4TqQJsoWQrrBxW6HuqSNZCUcvCw@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA5B7DE@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1206271218540.27496@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA5C1AB@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1206271306170.27496@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1206271306170.27496@utopia.booyaka.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Domenico Andreoli <cavokz@gmail.com>, Daniel Mack <zonque@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 28, 2012 at 00:42:16, Paul Walmsley wrote:
> On Wed, 27 Jun 2012, Hiremath, Vaibhav wrote:
> 
> > On Thu, Jun 28, 2012 at 00:01:06, Paul Walmsley wrote:
> > > On Wed, 27 Jun 2012, Hiremath, Vaibhav wrote:
> > > 
> > > The branch used was your am335x-upstream-staging branch, plus a minor 
> > > patch to allow the kernel to build on an am335x-only config (although for 
> > > the purposes of this test, omap2plus_defconfig was used).
> >
> > Something seems to be wrong here???
> > The HEAD is,
> > 
> > commit 67e686682dc286d90a0ed47b7dc68fb54944d3d9
> > Author: AnilKumar Ch <anilkumar@ti.com>
> > Date:   Thu Jun 21 12:33:58 2012 +0530
> > 
> >     arm/dts: Add support for AM335x BeagleBone
> 
> As I wrote earlier, there's an extra patch on there to get a kernel built 
> with an AM33xx-only config to link, used here for build testing.  It 
> shouldn't affect the kernel's ability to start at all.  It's included 
> below.
> 
> 
> - Paul
> 
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index d09ccc1..e6f4117 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -385,8 +385,12 @@ void __init omap2430_init_late(void)
>  /*
>   * Currently only board-omap3beagle.c should call this because of the
>   * same machine_id for 34xx and 36xx beagle.. Will get fixed with DT.
> + *
> + * XXX Due to the fact that the 33xx machine_init section is incorrectly
> + * incorporated as part of an AM35xx board file, we had to expand the
> + * following test to include CONFIG_SOC_AM33XX :-(
>   */
> -#ifdef CONFIG_SOC_OMAP3430
> +#if defined(CONFIG_SOC_OMAP3430) || defined(CONFIG_SOC_AM33XX)
>  void __init omap3_init_early(void)
>  {
>         omap2_set_globals_3xxx();
> 
> 

Shouldn't impact, but  still will apply now...will update you on this.
Can you also share me the .config file of yours??

Thanks,
Vaibhav
