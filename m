From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/6] mfd: dm355evm_msp: Refactoring for add_child()
Date: Tue, 28 Jun 2016 17:31:46 +0100
Message-ID: <20160628163146.GG29166@dell>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5682D228.7070902@users.sourceforge.net>
 <20160111082922.GB14104@x1>
 <05b7db2a-437a-60ac-d289-71d2150e7f5f@users.sourceforge.net>
 <de3598c4-f85a-6807-303a-55ee0ac707f2@users.sourceforge.net>
 <20160608111442.GB14888@dell>
 <e4eaf0b4-e539-b400-c8a2-70f210cee1fa@users.sourceforge.net>
 <75c1cc23-3a2d-db78-d0f2-b5934b18e828@users.sourceforge.net>
 <20160628150725.GL24982@dell>
 <c220895b-e56f-dc95-500d-0cf9d2f51777@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c220895b-e56f-dc95-500d-0cf9d2f51777@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

On Tue, 28 Jun 2016, SF Markus Elfring wrote:

> >> @@ -222,19 +222,21 @@ static struct device *add_child(struct i2c_c=
lient *client, const char *name,
> >>  		status =3D platform_device_add_resources(pdev, &r, 1);
> >>  		if (status < 0) {
> >>  			dev_dbg(&pdev->dev, "can't add irq\n");
> >> -			goto err;
> >> +			goto put_device;
> >>  		}
> >>  	}
> >> =20
> >>  	status =3D platform_device_add(pdev);
> >> =20
> >=20
> > Remove this line too.
>=20
> Do you propose the deletion of a blank line here?

Yes.

> Did you skip this update suggestion while the other patches were fina=
lly accepted?

I don't know what this means.

The other patches in the set have been accepted.  Please fix this one
and send it again on its own.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
