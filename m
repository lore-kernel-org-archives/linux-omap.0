From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: dts: am57xx-beagle-x15: Add support for rev B1
Date: Tue, 6 Sep 2016 13:05:53 -0700
Message-ID: <20160906200553.wqkvwsfww3rllhd5@atomide.com>
References: <20160902090600.27262-1-nm@ti.com>
 <20160902090600.27262-3-nm@ti.com>
 <dd74f5e1-304f-661e-7fd9-f5f81bcfc55e@ti.com>
 <CAOCHtYiFjB-cuABmCiw96spc-De+qNNQYGrjp-MmNDuH2mJ9Bw@mail.gmail.com>
 <84be68f4-c5a6-0afe-c402-1adba9172918@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <84be68f4-c5a6-0afe-c402-1adba9172918@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux kernel <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Jason Kridner <jkridner@beagleboard.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Sekhar Nori <nsekhar@ti.com> [160906 03:11]:
> On Friday 02 September 2016 07:22 PM, Robert Nelson wrote:
> > On Fri, Sep 2, 2016 at 5:41 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> >> + Robert Nelson
> >>
> >> On Friday 02 September 2016 02:36 PM, Nishanth Menon wrote:
> >>
> >> I understand that there are existing users of A2 boards and so we simply
> >> cannot remove support for those boards (at least yet).
> >>
> >> But given the small numbers of A2 boards, its also quite likely that we
> >> will not have enough test coverage for those boards. Especially as years
> >> pass and there are fewer and fewer people with access to working A2 boards.
> > 
> > I have a A1, A2 and a B1, that i use for testing for
> > beagleboard.org...  The A1 use to be ssh-accessible for developers,
> > but since moving to my new house, I haven't "yet" got that one setup
> > for developers.  Right now i'm using the A2 & B1 for development of
> > our default images.
> > 
> > Jason Kridner also has a number of boards
> 
> Availability of hardware _somewhere_ is one aspect. I am still worried
> about the big difference in scale. A2 are ~200 in number where as the
> production version should be in thousands.
> 
> Reuse is meant to reduce maintenance cost. In this case though, it seems
> like it will do exactly the opposite - making anyone with a production
> version rely on few with a non-production version to make any updates at
> all.
> 
> IMHO, a common .dtsi made sense if both the boards went to production
> and are largely available.

Shared dtsi files are essential for us from maintenance point of view
as maintaining non-shared dtsi files is way more work and churn.

> device-tree sources continue to get updates even though hardware itself
> is pretty much frozen. am335x-bone-common.dtsi created 3 years back is
> receiving updates still - as recently as 3 months back. So, I do expect
> that A2 will need to get tested in many years to come. Not sure if it
> really worth that much effort.

And the am335x shared dtsi files are not enough. It's silly how many
times we're duplicating the same things over and over again for USB
setup for various am335x boards for example.

So my take is that we need more shared dtsi files, not less.

Regards,

Tony
