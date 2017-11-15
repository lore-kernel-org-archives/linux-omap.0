From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 2/5] DT: misc: w2sg0004: add bindings documentation (GPS module with serdev UART)
Date: Wed, 15 Nov 2017 21:36:34 +0100
Message-ID: <797D508F-5285-403E-BA9F-E9586B87D368@goldelico.com>
References: <cover.1510520397.git.hns@goldelico.com> <069ce12d5609c4e968f2a468e6c58a57f59f3ffb.1510520397.git.hns@goldelico.com> <20171115200808.2nkldpoybhv5x6a5@rob-hp-laptop>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171115200808.2nkldpoybhv5x6a5@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

Hi Rob,

> Am 15.11.2017 um 21:08 schrieb Rob Herring <robh@kernel.org>:
>=20
> On Sun, Nov 12, 2017 at 09:59:55PM +0100, H. Nikolaus Schaller wrote:
>> add bindings documentation for Wi2Wi W2SG00x4 GPS module
>=20
> Add ... module.

Ok.

>=20
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> .../devicetree/bindings/misc/wi2wi,w2sg0004.txt    | 24 =
++++++++++++++++++++++
>=20
> The path doesn't have to match the kernel. Use bindings/gps/...

Ok.

>=20
>> 1 file changed, 24 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
>>=20
>> diff --git =
a/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt =
b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
>> new file mode 100644
>> index 000000000000..ccec9361a1a4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
>> @@ -0,0 +1,24 @@
>> +Wi2Wi GPS module connected through UART
>> +
>> +Should be a subnode of the SoC UART it is connected to (serdev).
>=20
> Could be connected to any kind of UART and serdev is a Linuxism.
>=20
> With those fixed,
>=20
> Acked-by: Rob Herring <robh@kernel.org>


Fine and thanks,
Nikolaus Schaller

PS: there is already a [PATCH v3] (no changes for 1/5 and 2/5)
