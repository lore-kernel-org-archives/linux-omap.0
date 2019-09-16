From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Letux-kernel] [PATCH 2/2] DTS: ARM: gta04: introduce legacy spi-cs-high to make display work again
Date: Mon, 16 Sep 2019 12:59:19 +0200
Message-ID: <ED6A6797-D1F9-473B-ABFF-B6951A924BC1@goldelico.com>
References: <cover.1562597164.git.hns@goldelico.com> <8ae7cf816b22ef9cecee0d789fcf9e8a06495c39.1562597164.git.hns@goldelico.com> <20190724194259.GA25847@bogus> <2EA06398-E45B-481B-9A26-4DD2E043BF9C@goldelico.com> <CAL_JsqLe_Y9Z6MRt7ojgSVKAb9n95S8j=eGidSVNz2T83j-zPQ@mail.gmail.com> <CACRpkdY0AVnkRa8sV_Z54qfX9SYufvaYYhU0k2+LitXo0sLx2w@mail.gmail.com> <20190831084852.5e726cfa@aktux>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190831084852.5e726cfa@aktux>
Sender: stable-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

ping.

Device omap3-gta04 is neither working with v5.3 nor linux-next quite a =
while and we need a solution.

> Am 31.08.2019 um 08:48 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> Hi,
>=20
> On Mon, 5 Aug 2019 12:29:19 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:
>=20
>> On Fri, Jul 26, 2019 at 12:43 AM Rob Herring <robh@kernel.org> wrote:
>>> On Thu, Jul 25, 2019 at 12:23 AM H. Nikolaus Schaller =
<hns@goldelico.com> wrote: =20
>>=20
>>>> I tried to convince Linus that this is the right way but he =
convinced
>>>> me that a fix that handles all cases does not exist.
>>>>=20
>>>> There seem to be embedded devices with older DTB (potentially in =
ROM)
>>>> which provide a plain 0 value for a gpios definition. And either =
with
>>>> or without spi-cs-high.
>>>>=20
>>>> Since "0" is the same as "GPIO_ACTIVE_HIGH", the absence of
>>>> spi-cs-high was and must be interpreted as active low for these
>>>> devices. This leads to the inversion logic in code.
>>>>=20
>>>> AFAIR it boils down to the question if gpiolib and the bindings
>>>> should still support such legacy devices with out-of tree DTB,
>>>> but force in-tree DTS to add the legacy spi-cs-high property.
>>>>=20
>>>> Or if we should fix the 2 or 3 cases of in-tree legacy cases
>>>> and potentially break out-of tree DTBs. =20
>>>=20
>>> If it is small number of platforms, then the kernel could handle =
those
>>> cases explicitly as needed.
>>>=20
>>>> IMHO it is more general to keep the out-of-tree DTBs working
>>>> and "fix" what we can control (in-tree DTS). =20

>>>=20
>>> If we do this, then we need to not call spi-cs-high legacy because
>>> we're stuck with it forever. =20
>>=20
>> I agree. The background on it is here:
>> https://lkml.org/lkml/2019/4/2/4
>>=20
>> Not using the negatively defined (i.e. if it is no there, the line is
>> by default active low) spi-cs-high would break
>> PowerPC, who were AFAICT using this to ship devices.
>>=20
> is this thing now just waiting for someone to do a s/legacy//?
>=20
> Regards,
> Andreas
