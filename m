From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 1/8] RFC: dt-bindings: add img,pvrsgx.yaml for Imagination GPUs
Date: Thu, 7 Nov 2019 17:37:54 +0100
Message-ID: <65C6747A-982A-4179-95AF-4061733978A1@goldelico.com>
References: <cover.1573124770.git.hns@goldelico.com> <4292cec1fd82cbd7d42742d749557adb01705574.1573124770.git.hns@goldelico.com> <20191107155401.GC5610@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107155401.GC5610@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Paul Cercueil <paul@crapouillou.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, openpvrsgx-devgroup@letux.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-mips@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


> Am 07.11.2019 um 16:54 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [191107 11:07]:
>> +        - const: "ti,am335x-sgx530-125", "img,sgx530-125", =
"img,sgx530", "img,sgx5"
>=20
> This should be without the x, maybe use the earliest one here
> for "ti,am3352-sgx530-125" like we have for "ti,am3352-uart".

Ok, fine. Will update accordingly.

> We could use "ti,am3-sgx530-125" but that can get confused
> then with am3517 then.

Indeed.

BR and thanks,
Nikolaus
