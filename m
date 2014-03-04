From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/5] drivers: bus: omap_l3: Convert to use devm_request_and_ioremap()
Date: Tue, 4 Mar 2014 12:50:34 +0200
Message-ID: <5315AFFA.40101@ti.com>
References: <1393923710-10377-1-git-send-email-peter.ujfalusi@ti.com> <1393923710-10377-3-git-send-email-peter.ujfalusi@ti.com> <1393924359.866301359@f148.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393924359.866301359@f148.i.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 03/04/2014 11:12 AM, Alexander Shiyan wrote:
> =D0=92=D1=82=D0=BE=D1=80=D0=BD=D0=B8=D0=BA,  4 =D0=BC=D0=B0=D1=80=D1=82=
=D0=B0 2014, 11:01 +02:00 =D0=BE=D1=82 Peter Ujfalusi <peter.ujfalusi@t=
i.com>:
>> We can then remove the iounmap() calls from probe and remove.
>> Since the driver requests the resources via index we can do the mem =
resource
>> request within a for loop.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti>
>> ---
>=20
>> +	/* Get mem resources */
>> +	for (i =3D 0; i < 3; i++) {
>> +		struct resource	*res =3D platform_get_resource(pdev,
>> +							     IORESOURCE_MEM, i);
>> +		if (!res) {
>> +			dev_err(&pdev->dev, "couldn't find resource %d\n", i);
>> +			return -ENODEV;
>> +		}
>=20
> No need to check "res". devm_request_and_ioremap() do all for us.
>=20
>> -	l3->l3_base[2] =3D ioremap(res->start, resource_size(res));
>> -	if (!l3->l3_base[2]) {
>> -		dev_err(&pdev->dev, "ioremap failed\n");
>> -		ret =3D -ENOMEM;
>> -		goto err2;
>> +		l3->l3_base[i] =3D devm_request_and_ioremap(&pdev->dev, res);
>> +		if (!l3->l3_base[i]) {
>=20
> if (IS_ERR(l3->l3_base[i]))
>=20
>> +			dev_err(&pdev->dev, "ioremap %d failed\n", i);
>=20
> Unnecessary.

I'm going to keep this since it tells which resource of the three has f=
ailed.

>=20
>> +			return -ENOMEM;
>=20
> return PTR_ERR(l3->l3_base[i]);
>=20
> ---
>=20


--=20
P=C3=A9ter
