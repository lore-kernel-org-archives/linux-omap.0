From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle ops
Date: Thu, 03 Jan 2019 15:39:05 -0800
Message-ID: <154655874528.15366.10423050138946294754@swboyd.mtv.corp.google.com>
References: <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com> <20181130153729.GG53235@atomide.com> <154362191595.88331.15503578806026771935@swboyd.mtv.corp.google.com> <20181203153910.GA6707@atomide.com> <20181203172246.0e767a16@kemnade.info> <20181204164556.GB6707@atomide.com> <20181227211222.5996c356@aktux> <20181228200229.GY6707@atomide.com> <76d9fc57-898b-53ba-1dca-78e5b5c9b2be@ti.com> <20181231092944.014fc1c0@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181231092944.014fc1c0@aktux>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>, Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com, letux-kernel@openphoenux.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mturquette@baylibre.com, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org

Quoting Andreas Kemnade (2018-12-31 00:30:21)
> On Mon, 31 Dec 2018 09:23:01 +0200
> Tero Kristo <t-kristo@ti.com> wrote:
>=20
> > On 28/12/2018 22:02, Tony Lindgren wrote:
> > > * Andreas Kemnade <andreas@kemnade.info> [181227 20:13]: =20
> > >> Hi,
> > >>
> > >> On Tue, 4 Dec 2018 08:45:57 -0800
> > >> Tony Lindgren <tony@atomide.com> wrote:
> > >> =20
> > >>> * Andreas Kemnade <andreas@kemnade.info> [181204 06:17]: =20
> > >>>> On Mon, 3 Dec 2018 07:39:10 -0800
> > >>>> Tony Lindgren <tony@atomide.com> wrote: =20
> > >>>>> The consumer device stays active just fine with PM runtime
> > >>>>> calls. So yes, the problem is keeping a clock controller forced
> > >>>>> active for the period of consumer device reset. Other than
> > >>>>> that typically autoidle can be just kept enabled.
> > >>>>>     =20
> > >>>> Are we still talking about the same problem? Maybe I am losing tra=
ck
> > >>>> here. Just to make sure.
> > >>>> The patch series was about disabling autoidle for devices which ca=
nnot
> > >>>> work with it during normal operation. Not during reset or something
> > >>>> like that.
> > >>>> Or is the keep-clock-active-during-reset just a requirement for bi=
gger
> > >>>> restructuring ideas? =20
> > >>>
> > >>> Yeah there are two issues: The fix needed for the issue you brought=
 up,
> > >>> and also how to let a reset driver to block autoidle for reset.
> > >>> =20
> > >> Hmm, is this set now waiting for the famous "somebody" fixing all
> > >> the stuff? =20
> > >=20
> > > Well I think we're still waiting on Tero to comment on this. =20
> >=20
> > The only item requiring immediate fixing is the point Stephen made out,=
=20
> > removing the usage of CLK_IS_BASIC from this patch.
> >=20
> > Afaics, the reset related concerns Tony has can be handled later.
> >=20
> hmm, and there we need Stephen's opinion about having the allow/deny
> autoidle functions in the main clk_ops struct.
>=20

I have unanswered questions on the list for this thread[1]. I'm not sure
what allow/deny autoidle functions mean to clk drivers. It looks like an
OMAP specific addition to the clk_ops struct, which sounds wrong to put
it plainly. Hopefully it can be done outside of the clk framework by
having the provider driver know more things about all the frameworks
it's hooking into.

[1] https://lkml.kernel.org/r/154385676593.88331.5239924154783168815@swboyd=
.mtv.corp.google.com
