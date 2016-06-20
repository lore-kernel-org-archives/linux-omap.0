From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v10 06/14] usb: gadget.h: Add OTG to gadget interface
Date: Mon, 20 Jun 2016 10:28:48 +0300
Message-ID: <57679B30.6030809@ti.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-7-git-send-email-rogerq@ti.com>
 <87k2hkxr4d.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NmORdVcQ5RW4s9GPuF1k0s77mGCKd5o3J"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k2hkxr4d.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, peter.chen@freescale.com
Cc: tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--NmORdVcQ5RW4s9GPuF1k0s77mGCKd5o3J
Content-Type: multipart/mixed; boundary="brMpXhEskQR4Hu6nVfvwxwc4OII2vxKSP"
From: Roger Quadros <rogerq@ti.com>
To: Felipe Balbi <balbi@kernel.org>, peter.chen@freescale.com
Cc: tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com,
 mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com,
 sergei.shtylyov@cogentembedded.com, jun.li@freescale.com,
 grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org,
 nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Message-ID: <57679B30.6030809@ti.com>
Subject: Re: [PATCH v10 06/14] usb: gadget.h: Add OTG to gadget interface
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-7-git-send-email-rogerq@ti.com>
 <87k2hkxr4d.fsf@linux.intel.com>
In-Reply-To: <87k2hkxr4d.fsf@linux.intel.com>

--brMpXhEskQR4Hu6nVfvwxwc4OII2vxKSP
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20/06/16 10:21, Felipe Balbi wrote:
>=20
> Hi,
>=20
> Roger Quadros <rogerq@ti.com> writes:
>> The OTG core will use struct otg_gadget_ops to
>> start/stop the gadget controller.
>>
>> The main purpose of this interface is to avoid directly
>> calling usb_gadget_start/stop() from the OTG core as they
>> wouldn't be defined in the built-in symbol table if
>> CONFIG_USB_GADGET is m.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  include/linux/usb/gadget.h | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
>> index 2dd9e6b..f4fc0aa 100644
>> --- a/include/linux/usb/gadget.h
>> +++ b/include/linux/usb/gadget.h
>> @@ -639,6 +639,22 @@ struct usb_gadget_driver {
>>  };
>> =20
>> =20
>> +/*-------------------------------------------------------------------=
------*/
>> +
>> +/**
>> + * struct otg_gadget_ops - Interface between OTG core and gadget
>> + *
>> + * Provided by the gadget core to allow the OTG core to start/stop th=
e gadget
>> + *
>> + * @start: function to start the gadget
>> + * @stop: function to stop the gadget
>> + * @connect_control: function to connect/disconnect from the bus
>> + */
>> +struct otg_gadget_ops {
>> +	int (*start)(struct usb_gadget *gadget);
>> +	int (*stop)(struct usb_gadget *gadget);
>> +	int (*connect_control)(struct usb_gadget *gadget, bool connect);
>> +};
>=20
> you shouldn't need these at all. They are already part of the gadget
> framework as ->udc_start(), ->udc_stop() and ->pullup()
>=20

This is to avoid the undefined symbol errors during build when OTG has is=

built-in because USB (host) is built-in but GADGET is still a module.

cheers,
-roger


--brMpXhEskQR4Hu6nVfvwxwc4OII2vxKSP--

--NmORdVcQ5RW4s9GPuF1k0s77mGCKd5o3J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXZ5szAAoJENJaa9O+djCTvwYQAJQ4nx6KVmNTnl/V28SQcPNZ
F2QEdfvGUHcLMYHxMd0BqGSoJ2KqbgyVG4mfORbD/jrMhEcXoEZf1vrDFIoi1WFJ
aOUNbO2GcmGMfbs5TEGjL/cyrCUKEeuof3Pb/BPdS0CrUtMM6stNc93G+uUb6z6F
cPXMse5kENlZCxkta/OFlKPzYmyeunRzeLf1dYbfwjC9qSBu/7lVVFTISLC0RoxJ
qpccGwXafFVTPIKmBn1zAhBGmCCs8267WVLkck3iBsBweyLpWb4KhE7CYrMz1Vz0
G8TJUl7exX1pmy3ULQkZxsbEhF3wyo0l9Qh/BvMqHWEHMLDyTcBwNErFuuoi+tSS
VIlozRvbV999WctE0w+jxQ/7MgIInHzogNq5crYXJ4EYnE1gEV/yaJ94K9tyWMA/
ifhLKDdLNEYDnh9x1L6jOeT3h1FI9aHnIt6B521V11goXWYt7Pat+fnOsFnIesJl
k7VUMm7IQcQsMiE5L43EEvCbLZ55r6hry+iVQ1XgLczYFFpcQF/UTUCtT8JtQKgx
SlG4eEJ7ipAUPXgt0CdtwRge0E4Q0wGHjZpKdD3HuKOwH2MBXcYihMkb/AL8dYxe
y8uRL8APzgyijuolxHnX2sHftKqdg0ZiL24DoR7bp95Mjz0sxUfRnEDSObaluxNK
eB+BPQL950OKJ+uuTGqx
=NGB4
-----END PGP SIGNATURE-----

--NmORdVcQ5RW4s9GPuF1k0s77mGCKd5o3J--
