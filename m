From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH v2 0/9] wilink: add device tree support
Date: Wed, 3 Jul 2013 16:45:32 +0300
Message-ID: <1372859132.21065.111.camel@cumari.coelho.fi>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
	 <CANOLnOPBHesTiV61zpQ_QS9c7E91K50EnbMnGhvgaViuA_3=Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CANOLnOPBHesTiV61zpQ_QS9c7E91K50EnbMnGhvgaViuA_3=Bw@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com, mturquette@linaro.org, mark.rutland@arm.com, Felipe Balbi <balbi@ti.com>, grant.likely@linaro.org, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, pavel@ucw.cz
List-Id: linux-omap@vger.kernel.org

On Wed, 2013-07-03 at 13:13 +0300, Grazvydas Ignotas wrote:
> Hi,

Hi Gra=C5=BEvydas,


> On Tue, Jul 2, 2013 at 5:55 PM, Luciano Coelho <coelho@ti.com> wrote:
> > Hi,
> >
> > This is a follow-up on a previous patch set that had a smaller
> > audience.  This time, I added the lists and people who were involve=
d
> > in the review of the bindings documentation, since most of my chang=
es
> > in v2 are coming from discussions there.
> >
> > This patch series adds device tree support to the wlcore_sdio drive=
r,
> > which is used by WiLink6, WiLink7 and WiLink8.
>=20
> Could you perhaps consider doing device tree conversion for wl1251
> too? With the knowledge you have from working on this series, it woul=
d
> be much easier for you to do it than for someone else, and I don't
> have much hope someone will do it at all. It's WiLink series chip
> after all. Without this pandora and N900 are going to lose wifi
> support after the switch to dt-only kernel.

Unfortunately I don't have much time to work on wl1251.  I think it
wouldn't be too difficult to do though, so patches are welcome. ;)

Maybe you could try to make this change and I could support you if
needed?


> I can offer you my help testing things on pandora and I'm sure someon=
e
> here could try it on N900.

I could try it on the N900, if it is still bootable easily with the
mainline. ;)

--
Cheers,
Luca.

