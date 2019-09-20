From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Letux-kernel] [PATCH 2/2] DTS: ARM: gta04: introduce legacy spi-cs-high to make display work again
Date: Fri, 20 Sep 2019 17:50:06 +0200
Message-ID: <96E62EC2-2A3E-4722-A9DE-3F320B0A98B0@goldelico.com>
References: <20190724194259.GA25847@bogus> <2EA06398-E45B-481B-9A26-4DD2E043BF9C@goldelico.com> <CAL_JsqLe_Y9Z6MRt7ojgSVKAb9n95S8j=eGidSVNz2T83j-zPQ@mail.gmail.com> <CACRpkdY0AVnkRa8sV_Z54qfX9SYufvaYYhU0k2+LitXo0sLx2w@mail.gmail.com> <20190831084852.5e726cfa@aktux> <ED6A6797-D1F9-473B-ABFF-B6951A924BC1@goldelico.com> <CACRpkdZQgPVvB=78vOFsHe5n45Vwe4N6JJOcm1_vz5FbAw9CYA@mail.gmail.com> <1624298A-C51B-418A-96C3-EA09367A010D@goldelico.com> <CACRpkdZvpPOM1Ug-=GHf7Z-2VEbJz3Cuo7+0yDFuNm5ShXK8=Q@mail.gmail.com> <7DF102BC-C818-4D27-988F-150C7527E6CC@goldelico.com> <20190920142059.GO5610@atomide.com> <633E7AD9-A909-4619-BBD7-8CFD965FDFF7@goldelico.com> <20190920172947.51c1fdec@aktux>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190920172947.51c1fdec@aktux>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org


> Am 20.09.2019 um 17:29 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> On Fri, 20 Sep 2019 16:54:18 +0200
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>=20
>>> Am 20.09.2019 um 16:20 schrieb Tony Lindgren <tony@atomide.com>:
>>>=20
>>> * H. Nikolaus Schaller <hns@goldelico.com> [190920 09:19]: =20
>>>>> Am 20.09.2019 um 10:55 schrieb Linus Walleij =
<linus.walleij@linaro.org>:
>>>>> I suggest to go both way:
>>>>> apply this oneliner and tag for stable so that GTA04 works
>>>>> again.
>>>>>=20
>>>>> Then for the next kernel think about a possible more abitious
>>>>> whitelist solution and after adding that remove *all* =
"spi-cs-high"
>>>>> flags from all device trees in the kernel after fixing them
>>>>> all up. =20
>>>>=20
>>>> Ok, that looks like a viable path. =20
>>>=20
>>> Please repost the oneline so people can ack easily. At least
>>> I've already lost track of this thread. =20
>>=20
>> It is all here:
>>=20
>> https://patchwork.kernel.org/patch/11035253/
>>=20
> It is the full one (incl. documentation), not the oneline and does not
> apply.

Looks as if it was sitting too long in the queue and linux-next has =
changed
the basis in the meantime, while v5.3 has not yet.

Documentation/devicetree/bindings/spi/spi-bus.txt -> spi-controller.yaml

So it should still apply for v5.3.1 and earlier and we need both =
versions.
One for stable and one for linux-next. I don't know how to handle such =
cases.

BR,
Nikolaus
