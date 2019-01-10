From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2] ARM: dts: omap3-gta04: Fix graph_port warning
Date: Thu, 10 Jan 2019 06:31:31 +0100
Message-ID: <8674356B-8688-49B6-AB72-16A991124A73@goldelico.com>
References: <97349a696b43af65d62b5d8e795ec3771b5e78bd.1547060514.git.hns@goldelico.com> <CAL_JsqLhGGx_amtDSZh3OJ+Tq-Oziu450NOt4Z+aoQMt-JY46Q@mail.gmail.com> <20190109213903.GV5544@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109213903.GV5544@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, devicetree <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org


> Am 09.01.2019 um 22:39 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * Rob Herring <robh@kernel.org> [190109 19:38]:
>> On Wed, Jan 9, 2019 at 1:02 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>>=20
>>> From: Tony Lindgren <tony@atomide.com>
>>>=20
>>> We're currently getting a warning with make dtbs:
>>>=20
>>> arch/arm/boot/dts/omap3-gta04.dtsi:720.7-727.4: Warning =
(graph_port):
>>> /ocp@68000000/dss@48050000/encoder@48050c0 0/port: graph node unit
>>> address error, expected "0"
>>>=20
>>> Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>=20
>> Acked-by: Rob Herring <robh@kernel.org>
>=20
> Nikolaus, care to reply with your Signed-off-by since
> you also edited the patch?

Sorry, I forgot (too busy with other topics)...

Here:

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

BR and thanks,
Nikolaus
