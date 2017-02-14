From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/14] ARM: OMAP2+: Remove legacy data from hwmod for omap3
Date: Tue, 14 Feb 2017 09:47:11 -0800
Message-ID: <20170214174710.GK21809@atomide.com>
References: <20161111191711.5079-1-tony@atomide.com>
 <20161111191711.5079-11-tony@atomide.com>
 <CAHCN7x+XEnu2agB6mjre8-RdS-MAE3Zh2HGPQcpohfxhmMM0PA@mail.gmail.com>
 <20170214174446.GJ21809@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170214174446.GJ21809@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adam Ford <aford173@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [170214 09:46]:
> * Adam Ford <aford173@gmail.com> [170214 09:01]:
> > On Fri, Nov 11, 2016 at 1:17 PM, Tony Lindgren <tony@atomide.com> wrote:
> > > This data is now coming from device tree so we can remove the
> > > duplicate data. Let's keep the DSS and DMA related things for now
> > > until those have been converted to device tree completely.
> > >
> > > While at it, let's also add the trailing commas to data structures
> > > so further processing with scripts will be a bit easier.
> > >
> > Tony,
> > 
> > I am having some errors with this patch.
> > 
> > Smartreflex on a DM3730 drops a few errors:
> > 
> > [    1.209747] smartreflex smartreflex.0: invalid resource
> > [    1.215301] smartreflex smartreflex.0: omap_sr_probe: ioremap fail
> > [    1.221832] smartreflex smartreflex.1: invalid resource
> > [    1.227294] smartreflex smartreflex.1: omap_sr_probe: ioremap fail
> > [    1.233856] sr_init: platform driver register failed for SR
> > 
> > I used Git bisect to narrow it down to this patch, and I confirmed it
> > manually.  Sorry it took so long to get feedback on this, but I was on
> > vacation.
> 
> Oh OK sorry about that.
> 
> > I attempted to just add back the smartreflex stuff for the omap36xx,
> > but that didn't work.  I am going to assume something is missing or
> > wrong in the device tree, but I could be wrong. If you  have any
> > suggestions before I go down a rabbit hole, I am open for ideas.
> 
> That's all there is to it :) You must have missed some part of it.
> Below is a fix that seems to work for me, care to test?
>
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -1946,6 +1946,7 @@ static struct omap_hwmod_ocp_if omap3xxx_dss__l3 = {
>  };
>  
>  /* l3_core -> usbhsotg interface */
> +
>  static struct omap_hwmod_ocp_if omap3xxx_usbhsotg__l3 = {
>  	.master		= &omap3xxx_usbhsotg_hwmod,
>  	.slave		= &omap3xxx_l3_main_hwmod,

This extra line should not be there, will remove.

Tony
