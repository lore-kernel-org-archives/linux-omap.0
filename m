From: Rob Herring <robh@kernel.org>
Subject: Re: [Patch 1/3] dt-bindings: media: ti-vpe: Document VPE driver
Date: Wed, 16 Oct 2019 10:36:54 -0500
Message-ID: <CAL_JsqKAGE=CytS89ET+r4+mSGfYPR5FMRUo2_jjVTZgW9o=Nw@mail.gmail.com>
References: <20191009175628.20570-1-bparrot@ti.com> <20191009175628.20570-2-bparrot@ti.com>
 <20191015222947.GA13388@bogus> <20191016132239.ufptwl44ktmhvylo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191016132239.ufptwl44ktmhvylo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Parrot <bparrot@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 16, 2019 at 8:20 AM Benoit Parrot <bparrot@ti.com> wrote:
>
> Rob Herring <robh@kernel.org> wrote on Tue [2019-Oct-15 17:29:47 -0500]:
> > On Wed, Oct 09, 2019 at 12:56:26PM -0500, Benoit Parrot wrote:
> > > Device Tree bindings for the Video Processing Engine (VPE) driver.
> > >
> > > Signed-off-by: Benoit Parrot <bparrot@ti.com>
> > > ---
> > >  .../devicetree/bindings/media/ti-vpe.txt      | 48 +++++++++++++++++++
> > >  MAINTAINERS                                   |  1 +
> > >  2 files changed, 49 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/media/ti-vpe.txt
> >
> > Please convert to DT schema format.
>
> I can do that.
> Before posting/merging a .yaml, are we supposed to be able to pass these?
> # make dt_binding_check
> # make dtbs_check

Only dt_binding_check needs to be warning free. It is good to test
your schema with dtbs_check and make sure any warnings seem valid.

> Because currently with 5.4-rc3 these fails.

Yeah, still waiting on regulator and media fixes. :( linux-next is fixed.

> Is there a way to run these "test command" target a specific .yaml and not
> the whole set?

Yes, it's documented in writing-schema.rst. Use DT_SCHEMA_FILES  to
test just your schema file.

[...]

> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 8598f49fa2c8..63dcda51f8ae 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -16299,6 +16299,7 @@ W:  http://linuxtv.org/
> > >  Q: http://patchwork.linuxtv.org/project/linux-media/list/
> > >  S: Maintained
> > >  F: drivers/media/platform/ti-vpe/
> > > +F: Documentation/devicetree/bindings/media/ti-vpe.txt
>
> Now with the dt_schemas, I noticed that the maintainer's name is part of
> the yaml file. Do we still need to add this to the MAINTAINERS file as
> well?

Within the schema is really preparation for having schema outside of
the kernel tree and because lots of bindings don't have a MAINTAINERS
entry. So yes, you can still have both.

Rob
