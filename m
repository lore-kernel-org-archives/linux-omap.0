From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: dts: omap3-gta04: Fix graph_port warning
Date: Wed, 9 Jan 2019 13:39:03 -0800
Message-ID: <20190109213903.GV5544@atomide.com>
References: <97349a696b43af65d62b5d8e795ec3771b5e78bd.1547060514.git.hns@goldelico.com>
 <CAL_JsqLhGGx_amtDSZh3OJ+Tq-Oziu450NOt4Z+aoQMt-JY46Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqLhGGx_amtDSZh3OJ+Tq-Oziu450NOt4Z+aoQMt-JY46Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, devicetree <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh@kernel.org> [190109 19:38]:
> On Wed, Jan 9, 2019 at 1:02 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >
> > From: Tony Lindgren <tony@atomide.com>
> >
> > We're currently getting a warning with make dtbs:
> >
> > arch/arm/boot/dts/omap3-gta04.dtsi:720.7-727.4: Warning (graph_port):
> > /ocp@68000000/dss@48050000/encoder@48050c0 0/port: graph node unit
> > address error, expected "0"
> >
> > Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Acked-by: Rob Herring <robh@kernel.org>

Nikolaus, care to reply with your Signed-off-by since
you also edited the patch?

Regards,

Tony
