From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 00/14] Add support for FM radio in hcill and kill TI_ST
Date: Thu, 3 Oct 2019 15:42:59 +0200
Message-ID: <20191003134259.bmrhgkvvkyjdvsr3@earth.universe>
References: <20181221011752.25627-1-sre@kernel.org>
 <4f47f7f2-3abb-856c-4db5-675caf8057c7@xs4all.nl>
 <20190319133154.7tbfafy7pguzw2tk@earth.universe>
 <CAHCN7xLffcvC0LVnfrhf4cA=y1PRMx+COa3c8rBm1xOj179vEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3hs23bfjj5434d43"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7xLffcvC0LVnfrhf4cA=y1PRMx+COa3c8rBm1xOj179vEA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Mauro Carvalho Chehab <mchehab@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-media@vger.kernel.org, Linux-OMAP <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--3hs23bfjj5434d43
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Adam,

On Wed, Oct 02, 2019 at 02:03:52PM -0500, Adam Ford wrote:
> On Tue, Mar 19, 2019 at 8:33 AM Sebastian Reichel <sre@kernel.org> wrote:
> After a bunch of testing, I think the issue I was having was the BTS
> file being pulled in from linux-firmware.  I was able to successfully
> load a BTS file that I have from Logic PD with working BLE and BT
> working together.  I have to run some tests, but if you wouldn't mind
> re-basing your code and pushing it again for review, I can most likely
> add my 'tested-by'.
>
> I am not sure who to discuss my perceived bug in the BTS blob.  I have
> to go find the old BTS editor and see if I can determine the cause,
> but the fact that I can use the BTS file that corresponds to the FCC
> certified file that Logic PD used is more important to me than using
> the generic BTS file provided by TI, however it would be nice for the
> reference BTS file to operate without error.

nice :) I just send a rebased partial series. I need some more time
for the FM radio part (I plan to work on that within the next 3
weeks).

-- Sebastian

--3hs23bfjj5434d43
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2V+t4ACgkQ2O7X88g7
+pqntw//XWtlZbSO/mbBluBjdqneqq8If142mAI8pY6Z1yv9hZV4H4ybUiS4czE8
5aWvAeye7uUZYbj85bELesffkWiKDShkT2K0mmfnY+apgcRRRsGhNMVN0+lNOHrV
Ekm2sVokpe+BKHu2hPPiCTsMMSfd4Z6Xga7KeClQJgJFYtmst3e4/k0pTTNNu9tV
O6J1j+baQzjiJEs7rz24vIrE6PoSvYmh8VRzOv2VwZ3kfcABu2vnz1JPxCSJvDfD
swO2nW3uZiMdeTDvI027iHCWupdkCc+XReqVHKu7VhiwnEiUg/8YuUxFL43bnFvY
vVRhJarFYkTvarwA2d1phCPH8DfH+uQ3nvFhpCjHUs+5KEEYWmiZhxkC7urL6xFY
KvvKQVm0bvNnWtHLOSwrkQD0nRVYEAm3Cjk9DtnwjMemVs7F1vYq9OA6u6GDflty
FSBlOZMplAA34TzvS3AcFjnKwzfmQqp43britTK1k+FDWcsBM2NWBN6aEOfcxmTs
hGmFfOOzckx2cf6xPnkkjhzpvMsZHWMcdKp67MWBJxglOBMRpvY+0+JtaXbvDoXQ
p7GfLTdLP7xkCMcTwXLFD6VvN2lbLioCPBQXCY+HbZ9AseDrHZlSzIM4MXE8nr/v
qRQ8UFg2GG+KfwxV5uM4IEFOfAdPAtCcWClbYvmcOsJxrbBmqt4=
=MOKK
-----END PGP SIGNATURE-----

--3hs23bfjj5434d43--
