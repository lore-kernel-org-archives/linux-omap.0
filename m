From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: twl6040: Handle mclk used for HPPLL and optional
 internal clock source
Date: Tue, 7 Jun 2016 10:17:39 +0100
Message-ID: <20160607091739.GD18047@dell>
References: <1462965209-6955-1-git-send-email-peter.ujfalusi@ti.com>
 <20160516150231.GA5527@rob-hp-laptop>
 <7d5e3117-a014-0107-bf75-775401834e02@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7d5e3117-a014-0107-bf75-775401834e02@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Rob Herring <robh@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 07 Jun 2016, Peter Ujfalusi wrote:

> Lee,
>=20
> On 05/16/16 18:02, Rob Herring wrote:
> > On Wed, May 11, 2016 at 02:13:29PM +0300, Peter Ujfalusi wrote:
> >> On some boards, like omap5-uevm the MCLK is gated by default and i=
n order
> >> to be able to use the High performance modes of twl6040 it need to=
 be
> >> enabled by SW.
> >> Add support for handling the MCLK source clock via CCF.
> >> At the same time lover the print priority of the notification that=
 the 32K
> >> clock is not proveded so it is not going to be handled by the driv=
er.
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> ---
> >>  Documentation/devicetree/bindings/mfd/twl6040.txt |  4 +--
> >=20
> > Acked-by: Rob Herring <robh@kernel.org>
>=20
> Can you take a look at this patch if it is OK to pick?

Yes, when I get around to it.

I currently have 75 patch review to conduct in my inbox.  Some of them
are quite large and complex.  They will be seen to in the order they
were sent, and you just bumped this patch to "sent today". ;)

> >>  drivers/mfd/twl6040.c                             | 34 ++++++++++=
+++++++------
> >>  include/linux/mfd/twl6040.h                       |  3 +-
> >>  3 files changed, 29 insertions(+), 12 deletions(-)
>=20
>=20
> Thanks,
> P=C3=A9ter

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
