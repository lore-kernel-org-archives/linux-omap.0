From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] MAINTAINERS: Add logicpd-som-lv and logicpd-torpedo to
 OMAP TREE
Date: Tue, 22 Oct 2019 09:03:51 -0700
Message-ID: <20191022160351.GQ5610@atomide.com>
References: <20190923135908.23080-1-aford173@gmail.com>
 <CAHCN7xLQvYbY_Pu5hQOO8o+1o8CAVvXq_-RM78Q=jYvtLxtmbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7xLQvYbY_Pu5hQOO8o+1o8CAVvXq_-RM78Q=jYvtLxtmbg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [191021 21:41]:
> On Mon, Sep 23, 2019 at 8:59 AM Adam Ford <aford173@gmail.com> wrote:
> >
> > The OMAP DEVICE TREE SUPPORT lists a bunch of device tree files
> > with wildcard names using am3*, am4*, am5*, dra7*, and *omap*.
> > Unfortunately, the LogicPD boards do not follow this convention
> > so changes to these boards don't get automatically flagged to
> > route to the omap mailing list.  After consulting with Tony
> > Lindgren, he agreed it made sense to add these boards to the
> > list.
> >
> > This patch adds the omap based boards to the omap device tree
> > maintainer list.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> Tony,
> 
> Are you ok with this?  I am not sure who to bug, but I am guessing
> whomever it is will want/need your approval too.

Yeah looks fine to me thanks, I'll apply it into
omap-for-v5.5/maintainers branch.

Regards,

Tony

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a50e97a63bc8..0ee89575699c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11645,6 +11645,8 @@ F:      arch/arm/boot/dts/*am3*
> >  F:     arch/arm/boot/dts/*am4*
> >  F:     arch/arm/boot/dts/*am5*
> >  F:     arch/arm/boot/dts/*dra7*
> > +F:     arch/arm/boot/dts/logicpd-som-lv*
> > +F:     arch/arm/boot/dts/logicpd-torpedo*
> >
> >  OMAP DISPLAY SUBSYSTEM and FRAMEBUFFER SUPPORT (DSS2)
> >  L:     linux-omap@vger.kernel.org
> > --
> > 2.17.1
> >
