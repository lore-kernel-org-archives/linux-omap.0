From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: DRA722: Add ID detect for Silicon Rev 2.0
Date: Wed, 30 Mar 2016 13:56:45 -0700
Message-ID: <20160330205644.GB9329@atomide.com>
References: <1457556991-10729-1-git-send-email-vishalm@ti.com>
 <56E1F8C6.4020906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <56E1F8C6.4020906@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [160310 14:44]:
> On 03/09/2016 02:56 PM, Vishal Mahaveer wrote:
> > From: Vishal Mahaveer <vishalm@ti.com>
> > 
> > Silicon Rev 2.0 is a minor variant of Rev 1.0. Rev 2.0 is an incremental revision
> > with various fixes including the following:
> >     - Reset logic fixes
> >     - Few asymetric aging logic fixes
> minor:
> s/asymetric/asymmetric/

I'll update that while applying.

> >     - Ethernet speed fixes
> >     - EDMA fixes for McASP
> > 
> > Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
> > ---
> >  arch/arm/mach-omap2/id.c  |    4 ++--
> >  arch/arm/mach-omap2/soc.h |    1 +
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > index 8a2ae82..84ee602 100644
> > --- a/arch/arm/mach-omap2/id.c
> > +++ b/arch/arm/mach-omap2/id.c
> > @@ -667,9 +667,9 @@ void __init dra7xxx_check_revision(void)
> >  		case 0:
> >  			omap_revision = DRA722_REV_ES1_0;
> >  			break;
> > +		case 1:
> >  		default:
> > -			/* If we have no new revisions */
> > -			omap_revision = DRA722_REV_ES1_0;
> > +			omap_revision = DRA722_REV_ES2_0;
> >  			break;
> >  		}
> >  		break;
> > diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
> > index 83d3547..464e73f 100644
> > --- a/arch/arm/mach-omap2/soc.h
> > +++ b/arch/arm/mach-omap2/soc.h
> > @@ -471,6 +471,7 @@ IS_OMAP_TYPE(3430, 0x3430)
> >  #define DRA752_REV_ES1_1	(DRA7XX_CLASS | (0x52 << 16) | (0x11 << 8))
> >  #define DRA752_REV_ES2_0	(DRA7XX_CLASS | (0x52 << 16) | (0x20 << 8))
> >  #define DRA722_REV_ES1_0	(DRA7XX_CLASS | (0x22 << 16) | (0x10 << 8))
> > +#define DRA722_REV_ES2_0	(DRA7XX_CLASS | (0x22 << 16) | (0x20 << 8))
> >  
> >  void omap2xxx_check_revision(void);
> >  void omap3xxx_check_revision(void);
> > 
> otherwise,
> for me:
> Acked-by: Nishanth Menon <nm@ti.com>

Applying into omap-for-v4.6/fixes thanks.

Tony
