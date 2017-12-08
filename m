From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2] usb: host: Implement workaround for Erratum A-009611
Date: Fri, 08 Dec 2017 12:44:11 +0200
Message-ID: <87vahhpkhw.fsf@linux.intel.com>
References: <20171208094942.46748-1-yinbo.zhu@nxp.com> <20171208094942.46748-2-yinbo.zhu@nxp.com> <20171208102111.GA16245@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171208102111.GA16245-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, yinbo.zhu-3arQi8VN3Tc@public.gmane.org
Cc: Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, xiaobo.xie-3arQi8VN3Tc@public.gmane.org, jerry.huang-3arQi8VN3Tc@public.gmane.org, ran.wang_1-3arQi8VN3Tc@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> writes:
> On Fri, Dec 08, 2017 at 05:49:41PM +0800, yinbo.zhu-3arQi8VN3Tc@public.gmane.org wrote:
>> From: "yinbo.zhu" <yinbo.zhu-3arQi8VN3Tc@public.gmane.org>
>>=20
>> Description: This is a occasional problem where the software
>
> No need for a "Description:" word.  That's just assumed here, right?
>
>> issues an End Transfer command while a USB transfer is in progress,
>> resulting in the TxFIFO  being flushed when the lower layer is waiting
>> for data,causing the super speed (SS) transmit to get blocked.
>> If the End Transfer command is issued on an IN endpoint to
>> flush out the pending transfers when the same IN endpoint
>> is doing transfers on the USB, then depending upon the timing
>> of the End Transfer (and the resulting internal FIFO flush),the
>> lower layer (U3PTL/U3MAC) could get stuck waiting for data
>> indefinitely. This blocks the transmission path on the SS, and no
>> DP/ACK/ERDY/DEVNOTIF packets can be sent from the device.
>> Impact: If this issue happens and the transmission gets blocked,
>> then the USB host aborts and resets/re-enumerates the device.
>> This unblocks the transmitt engine and the device functions normally.
>>=20
>> Workaround: Software must wait for all existing TRBs to complete before
>> issuing End transfer command.
>>=20
>> Configs Affected:
>> LS1088-48A-R1.0, LS2081A-R1.1, LS2088-48A-R1.0, LS2088-48A-R1.1,
>> LX2160-2120-2080A-R1.
>
> What are these Configs?  That doesn't seem to match up with anything
> that is in the kernel tree that I can see.
>
>>=20
>> Signed-off-by: yinbo.zhu <yinbo.zhu-3arQi8VN3Tc@public.gmane.org>
>> ---
>>  drivers/usb/dwc3/core.c      |  3 +++
>>  drivers/usb/dwc3/core.h      |  3 +++
>>  drivers/usb/dwc3/host.c      |  3 +++
>>  drivers/usb/host/xhci-plat.c |  4 ++++
>>  drivers/usb/host/xhci.c      | 24 ++++++++++++++++++------
>>  drivers/usb/host/xhci.h      |  1 +
>>  6 files changed, 32 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 5cb3f6795b0b..071e7cea8cbb 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1106,6 +1106,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>>=20=20
>>  	dwc->quirk_reverse_in_out =3D device_property_read_bool(dev,
>>  				"snps,quirk_reverse_in_out");

This was generated on vendor tree. This quirk doesn't exist in
dwc3. Also, update your tree and review MAINTAINERS file. It has been
almost 2 years since I left TI :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAloqbP0ACgkQzL64meEa
mQZKaQ/8D3bFXoBYZSnDT/+jU7fhrc69cqvg/PiGgkw/TMyv7pK0vP0AZFNwhyY3
jgW3mXN4F+dhqDonVpUs9c4YbawWJUZCSqbUKPYCP8ag21QHlmJv3h5nKfjx67wC
zLjpYYyjrUBbD1+RWrYKfpKf1O1tzANbIZ4h0LUIXW3Ts1MJybT6/KdIrC4MGQRO
1Jc1v73J6zXp4bPfEliiFxtLzJCCeprvayWE7WyTsYveiGENPWv377UR4Bn7OG4R
hwWoZEUMFkL/r4RXdDhmvjCGdacJLSBmyBAwKo3X+z5ax9EBswMwfECCQ+3akcZG
/oyFp+5G0ZakS7VNG2AAdWZ0JRGI2zWhz3CU5/GGoamCXmunoGHWMxPHowjbtHWm
0zf2mZQQr5hbubGT+kW8kjJRLXQbROZlFN2AMA0JzWXzZaxGSxPU/aNmo4TNy7Ze
/yqv0T5WWn1jn0u8oqiwHJgwUGqbfdj6xn5xFYZoPQ8xieU+UITHMPqAJeTLRHhN
LYdB2BCZollwM85kD037MAqEpa5RSHfI8+xUTrwMRAJw/oyti+5gSVO+ctjYL+pT
Y1Q7yCirl169eY+v1SE2kDu7rTc1c736rS3bhPkCgiUjZt51S8lIpkQHKbGcSJbi
joqyOpB3B0S4O22UmAeuy73FxljgbWjMa0jeeLRaILtZOZgjZQc=
=DIOf
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
