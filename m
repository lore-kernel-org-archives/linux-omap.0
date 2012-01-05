From: Richard Zhao <richard.zhao@freescale.com>
Subject: Re: [PATCH v4 3/6] clk: introduce the common clock framework
Date: Thu, 5 Jan 2012 09:23:18 +0800
Message-ID: <20120105012317.GM2414@b20223-02.ap.freescale.net>
References: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
 <1323834838-2206-4-git-send-email-mturquette@linaro.org>
 <alpine.LFD.2.02.1112141007550.3020@ionos>
 <CAJOA=zO=gM2r4pCVo+orLqE9Q1SSw4h5nXsAHo-e_SHZAfvKDA@mail.gmail.com>
 <20120104021541.GI2414@b20223-02.ap.freescale.net>
 <4F0462FF.1000308@gmail.com>
 <CAJOA=zPw7UuhE4R3SsBeyzQ2_iN29Zv-ExaUTTFCah+GoFSfNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:3027
	"EHLO AM1EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750782Ab2AEBXd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jan 2012 20:23:33 -0500
Content-Disposition: inline
In-Reply-To: <CAJOA=zPw7UuhE4R3SsBeyzQ2_iN29Zv-ExaUTTFCah+GoFSfNQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Turquette, Mike" <mturquette@ti.com>
Cc: Rob Herring <robherring2@gmail.com>, andrew@lunn.ch, linaro-dev@lists.linaro.org, eric.miao@linaro.org, grant.likely@secretlab.ca, Colin Cross <ccross@google.com>, jeremy.kerr@canonical.com, linux@arm.linux.org.uk, sboyd@quicinc.com, magnus.damm@gmail.com, dsaxena@linaro.org, linux-arm-kernel@lists.infradead.org, arnd.bergmann@linaro.org, patches@linaro.org, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, richard.zhao@linaro.org, shawn.guo@freescale.com, paul@pwsan.com, linus.walleij@stericsson.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, skannan@quicinc.com

On Wed, Jan 04, 2012 at 05:01:43PM -0800, Turquette, Mike wrote:
> On Wed, Jan 4, 2012 at 6:32 AM, Rob Herring <robherring2@gmail.com> w=
rote:
> > On 01/03/2012 08:15 PM, Richard Zhao wrote:
> >> On Fri, Dec 16, 2011 at 04:45:48PM -0800, Turquette, Mike wrote:
> >>> On Wed, Dec 14, 2011 at 5:18 AM, Thomas Gleixner <tglx@linutronix=
=2Ede> wrote:
> >>>> On Tue, 13 Dec 2011, Mike Turquette wrote:
> >
> > snip
> >
> >>>>> +/**
> >>>>> + * clk_init - initialize the data structures in a struct clk
> >>>>> + * @dev: device initializing this clk, placeholder for now
> >>>>> + * @clk: clk being initialized
> >>>>> + *
> >>>>> + * Initializes the lists in struct clk, queries the hardware f=
or the
> >>>>> + * parent and rate and sets them both. =A0Adds the clk to the =
sysfs tree
> >>>>> + * topology.
> >>>>> + *
> >>>>> + * Caller must populate clk->name and clk->flags before callin=
g
> >>>>
> >>>> I'm not too happy about this construct. That leaves struct clk a=
nd its
> >>>> members exposed to the world instead of making it a real opaque
> >>>> cookie. I know from my own painful experience, that this will le=
ad to
> >>>> random fiddling in that data structure in drivers and arch code =
just
> >>>> because the core code has a shortcoming.
> >>>>
> >>>> Why can't we make struct clk a real cookie and confine the data
> >>>> structure to the core code ?
> >>>>
> >>>> That would change the init call to something like:
> >>>>
> >>>> struct clk *clk_init(struct device *dev, const struct clk_hw *hw=
,
> >>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct clk *parent)
> >>>>
> >>>> And have:
> >>>> struct clk_hw {
> >>>> =A0 =A0 =A0 struct clk_hw_ops *ops;
> >>>> =A0 =A0 =A0 const char =A0 =A0 =A0 =A0*name;
> >>>> =A0 =A0 =A0 unsigned long =A0 =A0 flags;
> >>>> };
> >>>>
> >>>> Implementers can do:
> >>>> struct my_clk_hw {
> >>>> =A0 =A0 =A0 struct clk_hw =A0 =A0hw;
> >>>> =A0 =A0 =A0 mydata;
> >>>> };
> >>>>
> >>>> And then change the clk ops callbacks to take struct clk_hw * as=
 an
> >>>> argument.
> >> We have to define static clocks before we adopt DT binding.
> >> If clk is opaque and allocate memory in clk core, it'll make hard
> >> to define static clocks. And register/init will pass a long parame=
ter
> >> list.
> >
> > DT is not a prerequisite for having dynamically created clocks. You=
 can
> > make clock init dynamic without DT.
I can not find clock info at runtime without DT. If I use static info, =
I
find it was hard/strange to define and register it, using Mike's early =
patches.
>=20
> Agreed.
>=20
> > What data goes in struct clk vs. struct clk_hw could change over ti=
me.
> > So perhaps we can start with some data in clk_hw and plan to move i=
t to
> > struct clk later. Even if almost everything ends up in clk_hw initi=
ally,
> > at least the structure is in place to have common, core-only data
> > separate from platform data.
>=20
> What is the point of this?
>=20
> The original clk_hw was defined simply as:
>=20
> struct clk_hw {
>         struct clk *clk;
> };
>=20
> It's only purpose in life was as a handle for navigation between the
> opaque struct clk and the hardware-specific struct my_clk_hw.  struct
> clk_hw is defined in clk.h and everyone can see it.  If we're suddenl=
y
> OK putting clk data in this structure then why bother with an opaque
> struct clk at all?
I think Rob meant one time a step to make it opaque. But it'll make
clk core always changing, easier mess, and let clk driver confused.
>=20
> > What is the actual data you need to be static and accessible to the
> > platform code? A ptr to parent clk is the main thing I've seen for
> > static initialization. So make the parent ptr be struct clk_hw* and
> > allow the platforms to access.
>=20
> To answer your question on what data we're trying to expose: platform
> code commonly needs the parent pointer and the clk rate (and by
> extension, the rate of the parent).  For debug/error prints it is als=
o
> nice to have the clk name.  Generic clk flags are also conceivably
> something that platform code might want.
>=20
> I'd like to spin the question around: if we're OK exposing some stuff
> (in your example above, the parent pointer), then what clk data are
> you trying to hide?
>=20
> Regards,
> Mike
>=20
> >
> > Rob
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
