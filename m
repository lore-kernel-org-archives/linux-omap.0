From: Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH] usb: musb: call pm_runtime_{get,put}_sync before reading
 vbus registers
Date: Mon, 26 Feb 2018 18:19:30 +0100
Message-ID: <73a1de6d-6bf4-275f-aee3-85699cd6ca76@wizzup.org>
References: <20180226105609.22514-1-merlijn@wizzup.org>
 <20180226155716.GB20609@uda0271908>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="v7DLODj7yyMXF0yaV8OWKW7IM7rys82oW"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180226155716.GB20609@uda0271908>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v7DLODj7yyMXF0yaV8OWKW7IM7rys82oW
Content-Type: multipart/mixed; boundary="ZxcOfYQgk538GczIH3XlQ1XTQx1BbNV8o";
 protected-headers="v1"
From: Merlijn Wajer <merlijn@wizzup.org>
To: Bin Liu <b-liu@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <73a1de6d-6bf4-275f-aee3-85699cd6ca76@wizzup.org>
Subject: Re: [PATCH] usb: musb: call pm_runtime_{get,put}_sync before reading
 vbus registers
References: <20180226105609.22514-1-merlijn@wizzup.org>
 <20180226155716.GB20609@uda0271908>
In-Reply-To: <20180226155716.GB20609@uda0271908>

--ZxcOfYQgk538GczIH3XlQ1XTQx1BbNV8o
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

On 26/02/18 16:57, Bin Liu wrote:
> Hi,
>=20
> On Mon, Feb 26, 2018 at 11:56:08AM +0100, Merlijn Wajer wrote:
>> Without pm_runtime_{get,put}_sync calls in place, reading
>> vbus status via /sys causes the following error:
>>
>> Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0ab06=
0
>> pgd =3D b333e822
>> [fa0ab060] *pgd=3D48011452(bad)
>>
>> [<c05261b0>] (musb_default_readb) from [<c0525bd0>] (musb_vbus_show+0x=
58/0xe4)
>> [<c0525bd0>] (musb_vbus_show) from [<c04c0148>] (dev_attr_show+0x20/0x=
44)
>> [<c04c0148>] (dev_attr_show) from [<c0259f74>] (sysfs_kf_seq_show+0x80=
/0xdc)
>> [<c0259f74>] (sysfs_kf_seq_show) from [<c0210bac>] (seq_read+0x250/0x4=
48)
>> [<c0210bac>] (seq_read) from [<c01edb40>] (__vfs_read+0x1c/0x118)
>> [<c01edb40>] (__vfs_read) from [<c01edccc>] (vfs_read+0x90/0x144)
>> [<c01edccc>] (vfs_read) from [<c01ee1d0>] (SyS_read+0x3c/0x74)
>> [<c01ee1d0>] (SyS_read) from [<c0106fe0>] (ret_fast_syscall+0x0/0x54)
>>
>> Solution was suggested by Tony Lindgren <tony@atomide.com>.
>>
>> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
>> ---
>>  drivers/usb/musb/musb_core.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core=
=2Ec
>> index eef4ad578b31..ceaa40ef0e73 100644
>> --- a/drivers/usb/musb/musb_core.c
>> +++ b/drivers/usb/musb/musb_core.c
>> @@ -1760,6 +1760,8 @@ vbus_show(struct device *dev, struct device_attr=
ibute *attr, char *buf)
>>  	val =3D musb->a_wait_bcon;
>>  	vbus =3D musb_platform_get_vbus_status(musb);
>>  	if (vbus < 0) {
>> +		pm_runtime_get_sync(dev);
>> +
>>  		/* Use default MUSB method by means of DEVCTL register */
>>  		devctl =3D musb_readb(musb->mregs, MUSB_DEVCTL);
>>  		if ((devctl & MUSB_DEVCTL_VBUS)
>> @@ -1767,6 +1769,8 @@ vbus_show(struct device *dev, struct device_attr=
ibute *attr, char *buf)
>>  			vbus =3D 1;
>>  		else
>>  			vbus =3D 0;
>> +
>> +		pm_runtime_put_sync(dev);
>>  	}
>>  	spin_unlock_irqrestore(&musb->lock, flags);
>=20
> Thanks for the patch, but I got spinlock deadlock when testing it. I
> think the function pair should be at the outside scope of the
> spin_lock/unlock, doesn't it?

I see - sorry. Weird, it worked for me on my Nokia N900. What did you
test this on?

I will try to submit an improved version tonight (you seem to have a
good idea on what is wrong, so I will follow that), but it would help me
if I can reproduce the issue.

Cheers,
Merlijn


--ZxcOfYQgk538GczIH3XlQ1XTQx1BbNV8o--

--v7DLODj7yyMXF0yaV8OWKW7IM7rys82oW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCWpRBowAKCRAGN09rynK8
WsJ2AQCFTepleUmO+hp6g2z88hbLON6tpRFFkCLGamoyJkUZigEAiPE6v00LuuOu
8iPD3QEknN21HdFlDE+/WkOPqw9/LAw=
=8PVH
-----END PGP SIGNATURE-----

--v7DLODj7yyMXF0yaV8OWKW7IM7rys82oW--
