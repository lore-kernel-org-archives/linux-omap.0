From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 1/4] Documentation: dt: add common bindings for
 hwspinlock
Date: Wed, 11 Feb 2015 11:35:53 +0000
Message-ID: <20150211113553.GE9154@leverpostej>
References: <20150116101746.GA21809@leverpostej>
 <CAK=WgbYBqPoUm9byx0du_g5ZmHdYaUVLpSPZYHoCVzNoatNKpw@mail.gmail.com>
 <CAJAp7Og+-KQd7bygWQjTS72Kye3fkp3s3ry+2bw7Gcv7aPF5AQ@mail.gmail.com>
 <CAK=WgbZ2986xxuAFvMSoyQLaPAxdUpZ8e5g-mSjyETfvd4KKHw@mail.gmail.com>
 <CAJAp7OjVULNRd113TtOEwaa6QO-XCDa0oxBm2H5NPvp_kLTSpA@mail.gmail.com>
 <54CFE71E.20905@ti.com>
 <CAJAp7OiHfaMrVqaZ1r6ZN0aMMpE4OUnvLhODHQJeb6EJMa+o8A@mail.gmail.com>
 <54D406BA.6060403@ti.com>
 <CAJAp7Ojud6UM97eDYdUhZxzzjNRw_47e5kqh4UxwDBMwFZpuoQ@mail.gmail.com>
 <CAK=WgbaHEbqVVBAUL1aaO3i+pPbTZM2DRB=1kSE6A6+pPmS4yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK=WgbaHEbqVVBAUL1aaO3i+pPbTZM2DRB=1kSE6A6+pPmS4yQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Bjorn Andersson <bjorn@kryo.se>, Suman Anna <s-anna@ti.com>, Rob Herring <robherring2@gmail.com>, Kumar Gala <galak@codeaurora.org>, Josh Cartwright <joshc@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

Sorry I've been away from this thread for a while.

On Wed, Feb 11, 2015 at 10:29:37AM +0000, Ohad Ben-Cohen wrote:
> On Fri, Feb 6, 2015 at 2:34 AM, Bjorn Andersson <bjorn@kryo.se> wrote:
> >> Yep, will do as soon as I hear from Ohad on what to do with the patch
> >> "hwspinlock/core: maintain a list of registered hwspinlock banks" that I
> >> dropped from v7. Without that and dropping hwlock-base-id, I can't get
> >> the translations done.
> >>
> >
> > My suggestion is to replace the global id-tree with a list of hwlocks
> > and iterate over these if we ever get more than one driver registered.
> > As long as #hwlock-drivers < log(#total-hwlocks) this should be
> > faster.
> >
> > I would however argue that clients that would notice any kind of
> > difference are using the API incorrectly.
> >
> > Unfortunately this is a somewhat larger change than just slapping DT
> > support on the framework :/
> 
> I suspect we want to wait with framework changes until there's a real
> hardware use case justifying them.
> 
> With regard to DT, however, we obviously do want to be prepared for
> multiple hwlock blocks even if they do not exist today.
> 
> So how about adopting an approach where:
> - DT fully supports multi hwlock blocks (i.e. no global id field)
> - Framework left mostly unchanged at the moment. This means issuing an
> explicit error in case a secondary hwlock block shows up, and then
> hwlock id could trivially be the lock index.
> 
> If multi hwlock hardware use case, or some new hwlock id translation
> requirements, do show up in the future, it's always easy to add
> framework support for it. At that point we'll know better what the
> requirements are, and framework changes would be justifiable.

As mentioned in my other reply I think we need to be explicit now when
defining the set of hwlocks (and their namming/numbering) shared between
a given set of processors, as we do with other resources
(GPIOs/regulators/whatever).

We also need to be explicit in describing the set of actors which use
those locks.

I think my previous proposal covered both of those.

Thanks,
Mark.
