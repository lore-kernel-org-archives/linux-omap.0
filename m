From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/7] dt-bindings: gpu: pvrsgx: add initial bindings
Date: Wed, 30 Oct 2019 17:39:11 +0100
Message-ID: <61AAD023-6B22-4F81-A3B3-7C9571F967B2@goldelico.com>
References: <cover.1571424390.git.hns@goldelico.com> <f0fb68dc7bc027e5e911721852f6bc6fa2d77a63.1571424390.git.hns@goldelico.com> <20191030161604.GA5610@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191030161604.GA5610@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

Hi,

> Am 30.10.2019 um 17:16 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [191018 18:47]:
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpu/img,pvrsgx.txt
>> @@ -0,0 +1,76 @@
>> +Imagination PVR/SGX GPU
>> +
>> +Only the Imagination SGX530, SGX540 and SGX544 GPUs are currently =
covered by this binding.
>> +
>> +Required properties:
>> +- compatible:	Should be one of
>> +		"img,sgx530-121", "img,sgx530", =
"ti,omap-omap3-sgx530-121";
>> +		  - BeagleBoard ABC, OpenPandora 600MHz
>> +		"img,sgx530-125", "img,sgx530", =
"ti,omap-omap3-sgx530-125";
>> +		  - BeagleBoard XM, GTA04, OpenPandora 1GHz
>> +		"img,sgx530-125", "img,sgx530", =
"ti,omap-am3517-sgx530-125";
>> +		"img,sgx530-125", "img,sgx530", =
"ti,omap-am335x-sgx530-125";
>> +		  - BeagleBone Black
>> +		"img,sgx540-120", "img,sgx540", =
"ti,omap-omap4-sgx540-120";
>> +		  - Pandaboard (ES)
>> +		"img,sgx544-112", "img,sgx544", =
"ti,omap-omap4-sgx544-112";
>> +		"img,sgx544-116", "img,sgx544", =
"ti,omap-omap5-sgx544-116";
>> +		  - OMAP5 UEVM, Pyra Handheld
>> +		"img,sgx544-116", "img,sgx544", =
"ti,omap-dra7-sgx544-116";
>=20
> FYI, the compatible names above have unnecessary omap in them:
>=20
> "ti,omap-omap3-sgx530-121" should be "ti,omap3-sgx530-121"
> "ti,omap-am335x-sgx530-125" should be "ti,am335x-sgx530-125";
> "ti,omap-dra7-sgx544-116" should be "ti,dra7-sgx544-116"
>=20
> And so on.

Yes,
Rob already noted a while ago and our latest private code has it fixed.

There is no progress towards a v2 since I am still fighting with the new
yaml format he also requested...

BR and thanks,
Nikolaus
