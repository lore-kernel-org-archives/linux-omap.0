From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Subject: Re: [Qemu-devel] Running linux on qemu omap
Date: Thu, 23 May 2019 14:00:41 +0200
Message-ID: <c2972889-fe60-7614-fb6e-e57ddf780a54@redhat.com>
References: <20190520190533.GA28160@Red>
 <20190521232323.GD3621@darkstar.musicnaut.iki.fi>
 <20190522093341.GA32154@Red>
 <20190522181904.GE3621@darkstar.musicnaut.iki.fi>
 <8977e2bb-8d9e-f4fd-4c44-b4f67e0e7314@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="N3gK20x9xpooVg0mf1GhPnBDZSkp1nIkO"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8977e2bb-8d9e-f4fd-4c44-b4f67e0e7314@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Huth <thuth@redhat.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N3gK20x9xpooVg0mf1GhPnBDZSkp1nIkO
Content-Type: multipart/mixed; boundary="PdV5Opk5aiZJQzRy0CJ7xPo7FQaFRUuX4";
 protected-headers="v1"
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
 qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <c2972889-fe60-7614-fb6e-e57ddf780a54@redhat.com>
Subject: Re: [Qemu-devel] Running linux on qemu omap
References: <20190520190533.GA28160@Red>
 <20190521232323.GD3621@darkstar.musicnaut.iki.fi>
 <20190522093341.GA32154@Red>
 <20190522181904.GE3621@darkstar.musicnaut.iki.fi>
 <8977e2bb-8d9e-f4fd-4c44-b4f67e0e7314@redhat.com>
In-Reply-To: <8977e2bb-8d9e-f4fd-4c44-b4f67e0e7314@redhat.com>

--PdV5Opk5aiZJQzRy0CJ7xPo7FQaFRUuX4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/23/19 1:27 PM, Thomas Huth wrote:
> On 22/05/2019 20.19, Aaro Koskinen wrote:
>> Hi,
>>
>> On Wed, May 22, 2019 at 11:33:41AM +0200, Corentin Labbe wrote:
>>> qemu-system-arm -M help |grep OMAP
>>> cheetah              Palm Tungsten|E aka. Cheetah PDA (OMAP310)
>>> n800                 Nokia N800 tablet aka. RX-34 (OMAP2420)
>>> n810                 Nokia N810 tablet aka. RX-44 (OMAP2420)
>>> sx1                  Siemens SX1 (OMAP310) V2
>>> sx1-v1               Siemens SX1 (OMAP310) V1
>>>
>>>>> The maximum I can get with omap1_defconfig is
>>>>> qemu-system-arm -kernel zImage -nographic -machine cheetah -append =
'root=3D/dev/ram0 console=3DttyO0'
>>>>> Uncompressing Linux... done, booting the kernel.
>>>>> then nothing more.
>>
>> With N800/N810 omap2plus_defconfig should be used instead. However,
>> I don't think that works either (but haven't tried recently). Also wit=
h
>> N800/N810 you need to append the DTB file to the kernel image.
>=20
> FWIW, Philippe recently posted a mail how to run older kernels on n810:=

>=20
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg610653.html

What I use as reference for testing ARM boards [*] is the work of
Guenter Roeck:
https://github.com/groeck/linux-build-test/blob/master/rootfs/arm/run-qem=
u-arm.sh

However I can see than none of the board listed by Corentin are tested
=2E.. That reminder me I never succeed at using the Cheetah PDA. So the
OMAP310 is probably bitroting in QEMU...

[*] and slowly add to upstream patches he sent that fell through the
cracks of qemu-devel.

Regards,

Phil.


--PdV5Opk5aiZJQzRy0CJ7xPo7FQaFRUuX4--

--N3gK20x9xpooVg0mf1GhPnBDZSkp1nIkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlzmi20ACgkQoqP9bt6t
wN5i6xAAuRhP+m1TluijQk+H4g7hsK/vz9VkbGudZ6gk2C/UtPJg2KvLWw1lMCuL
sy2snYHuKXs90yRbe1D4Ivf0HHzekXCPi94YxEckWh4UQO5J3SqCB5CSlq4HoMcj
frBtor0Zfn3pKxHSIvIse+kcAem/JR5NJAqWALlpZz2vz+SOQ9IrhFfDgCr8ez0z
oaFQ1JC93fGzGfXdTa/LkvANHt2f0JSknpqu7yJpN2ZmNVizpDkGo1bbHsPJqotv
P+EUSvihxvNjkQz0hXALVoXG1WKQeGHCi6+ZnoeQnV029DVQdj5tJIL3wGAANXNY
o584oXdqeJ3bRvqUi945CyGhrvTqPDL85t6AEuRln31we2LcnB/Rq+iA7M+UX7ZM
9xF63BmSEDZxHpBBi4EYc4DpVmDJXhZjYSiVCQbXVoMCFt6RbFHCKxIyFlmjod+S
i/lRnzNbTEj1+5LuYHiN09ILJqjQqp7oVhDcBevKLwT1N8TTNpuwQwx31nL54tBa
Y8InAsmpjgduXTu9vpDvK68F5TpoY0I0RROdj+Z5wrFJ9sTIfo7E58p+w9XivXww
+v6oCr6Dod3t5UwvxyAZTQuOce6Sqk1i4oBMNCZ8OIP8tVM9Pi90pwfOgtb62EEj
czDvTUF8Bt5W6/3Px5fW8FDR0HhejhunK4B0s40hH1ZqT/TXyog=
=LlYn
-----END PGP SIGNATURE-----

--N3gK20x9xpooVg0mf1GhPnBDZSkp1nIkO--
