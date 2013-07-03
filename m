From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH v2 0/9] wilink: add device tree support
Date: Wed, 3 Jul 2013 13:13:08 +0300
Message-ID: <CANOLnOPBHesTiV61zpQ_QS9c7E91K50EnbMnGhvgaViuA_3=Bw@mail.gmail.com>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372776948-24840-1-git-send-email-coelho@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com, mturquette@linaro.org, mark.rutland@arm.com, Felipe Balbi <balbi@ti.com>, grant.likely@linaro.org, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, pavel@ucw.cz
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Jul 2, 2013 at 5:55 PM, Luciano Coelho <coelho@ti.com> wrote:
> Hi,
>
> This is a follow-up on a previous patch set that had a smaller
> audience.  This time, I added the lists and people who were involved
> in the review of the bindings documentation, since most of my changes
> in v2 are coming from discussions there.
>
> This patch series adds device tree support to the wlcore_sdio driver,
> which is used by WiLink6, WiLink7 and WiLink8.

Could you perhaps consider doing device tree conversion for wl1251
too? With the knowledge you have from working on this series, it would
be much easier for you to do it than for someone else, and I don't
have much hope someone will do it at all. It's WiLink series chip
after all. Without this pandora and N900 are going to lose wifi
support after the switch to dt-only kernel.

I can offer you my help testing things on pandora and I'm sure someone
here could try it on N900.


--
Gra=C5=BEvydas
