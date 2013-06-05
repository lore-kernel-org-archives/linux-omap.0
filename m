From: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 0/3] first pass converting omap4 clock data to DT
Date: Tue, 04 Jun 2013 23:45:45 -0700
Message-ID: <20130605064545.10233.72880@quantum>
References: <1370327958-19776-1-git-send-email-mturquette@linaro.org>
 <1370352534.25965.52.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370352534.25965.52.camel@sokoban>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: t-kristo-l0cyMroinI0@public.gmane.orgTero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Quoting Tero Kristo (2013-06-04 06:28:54)
> Hi Mike,
> 
> On Mon, 2013-06-03 at 23:39 -0700, Mike Turquette wrote:
> > This is a very incomplete conversion of a handful of OMAP4 PRCM clocks
> > from the statically defined clock data in
> > arch/arm/mach-omap2/cclock44xx_data.c to a new dts file in
> > arch/arm/boot/dts/omap4-clocks.dtsi.
> 
> I gave a quick try for this set and it seems to be working nicely, so
> for at least me this approach is fine. Feel free to add tested-by me if
> you like (for the basic clock bindings also.) Can't comment much on the
> DT stuff though as my experience is rather limited on it.
> 
> > I am not a DT expert so many of the choices here may be quite disgusting
> > to look at, or may be on the right path.  In particular I simply include
> > the new omap4-clocks.dtsi from omap4.dtsi, which feels a bit kludgey.
> > Also this series depends on the basic clock bindings RFC I posted
> > earlier today[1].
> > 
> > I actually have an omap4-clock.dtsi file with many more clocks converted
> > to the mux-clock, divider-clock, fixed-clock, fixed-factor and
> > (unpublished) gate-clock bindings in my local repo, but it is not
> > currently booting.  I wanted to get this early preview out regardless.
> 
> Any way I can get access to your local tree? Can you push a branch
> somewhere? I could provide you debugging support on this at least, as I
> spent quite a bit of time earlier moving the clock data under
> drivers/clk... I guess you are probably seeing similar issues I faced.
> 

I'll be pushing changes to my github tree:
git://github.com/mturquette/linux.git clk-next-omap-dt
https://github.com/mturquette/linux/tree/clk-next-omap-dt

For now it is just this series based on the prerequisites, based on
clk-next, based on -rc3.

Regards,
Mike

> -Tero
> 
> > 
> > [1] http://article.gmane.org/gmane.linux.kernel/1501216
> > 
> > Mike Turquette (3):
> >   clk: omap: introduce clock driver
> >   ARM: dts: omap4 clock data
> >   ARM: omap4: register DT clocks & remove old data
> > 
> >  arch/arm/boot/dts/omap4-clocks.dtsi   | 128 ++++++++++++++++++++++++++++++++++
> >  arch/arm/boot/dts/omap4.dtsi          |   2 +
> >  arch/arm/mach-omap2/cclock44xx_data.c |  54 ++------------
> >  drivers/clk/Makefile                  |   1 +
> >  drivers/clk/omap/Makefile             |   1 +
> >  drivers/clk/omap/clk.c                |  55 +++++++++++++++
> >  include/linux/clk/omap.h              |  24 +++++++
> >  7 files changed, 217 insertions(+), 48 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/omap4-clocks.dtsi
> >  create mode 100644 drivers/clk/omap/Makefile
> >  create mode 100644 drivers/clk/omap/clk.c
> >  create mode 100644 include/linux/clk/omap.h
> >
