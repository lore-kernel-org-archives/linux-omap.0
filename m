From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: usb-related linux-next boot failures
Date: Thu, 29 Jun 2017 08:54:48 +0300
Message-ID: <878tkb5oev.fsf@linux.intel.com>
References: <0d1a491c-41c4-a02d-cdf8-e1a95a1fe989@ti.com> <20170628045543.GA28759@kroah.com> <87r2y45x97.fsf@linux.intel.com> <20170628103014.GC3730@atomide.com> <34a37d06-1929-814b-3476-6eaa5a45cd39@ti.com> <87k23w5qn2.fsf@linux.intel.com> <71bae311-f85b-4fe1-06c2-d43bfee42b88@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <71bae311-f85b-4fe1-06c2-d43bfee42b88-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Carlos Hernandez <ceh-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> writes:
>> Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> writes:
>>> On Wednesday 28 June 2017 04:00 PM, Tony Lindgren wrote:
>>>>  Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> [170628 01:32]:
>>>>> Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> writes:
>>>>>> On Tue, Jun 27, 2017 at 02:28:56PM -0400, Carlos Hernandez wrote:
>>>>>>> Still seeing AM57xx/DRA72/DRA7x usb-related boot failures on linux-=
next...
>>>>>>
>>>>>> Is this a regression?  If so, any specific commit that caused it?
>>>>>
>>>>> I did ask for a bisection last time but nobody from TI replied ;-)
>>>>>
>>>>> https://marc.info/?i=3D87h8zi4gmx.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
>>>>>
>>>>> Can't really help without bisection logs :-)
>>>>
>>>> Seems this warning got add with 04c848d39879 ("genirq: Warn when
>>>> IRQ_NOAUTOEN is used with shared interrupts"). The fix is to get
>>>> rid of IRQ_NOAUTOEN and enable_irq for a shared interrupt. Hard
>>>> to say as the warning line does not match the version of next I
>>>> have so this should be verified.
>>>>
>>>
>>> There seems to be two different problems here.
>>> One is what Tony is pointing to above that throws a first warn dump
>>> during dwc3_omap_probe().
>>>
>>> Second one is the imprecise external abort that happens later:
>>> [   24.809939] Unhandled fault: imprecise external abort (0x1406) at
>>> 0x00000000
>>>
>>> Bisecting the second issue lead to the first bad commit as:
>>> commit f54edb539c1167e7a96073848d0afad100df4580
>>> Author: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>> Date:   Mon Jun 5 17:03:18 2017 +0300
>>>
>>>     usb: dwc3: core: initialize ULPI before trying to get the PHY
>>>
>>>     If don't reorder initialization like this, we will never be able to
>>>     get a reference to ULPI PHYs.
>>>
>>>     Signed-off-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>>
>>>
>>>
>>> Reverting above commit from -next seems to help.
>>=20
>> reverting will break other things. Seems like we should move
>> pm_runtime_* operations a little earlier to ensure clocks are enabled
>> early enough.
>>=20
>
> Looking at the above commit, I see that call to dwc3_core_get_phy() is
> now moved from dwc3_probe() to dwc3_core_init() after
> dwc3_core_soft_reset(). But dwc3_core_soft_reset() calls phy_init(),
> therefore dwc3_core_get_phy() needs to be called before
> dwc3_core_soft_reset().
>
> Below diff fixes the issue on DRA7xx platforms. I can submit a formal
> patch, if it looks fine.
>
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 326b302fc440..03474d3575ab 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -766,15 +766,15 @@ static int dwc3_core_init(struct dwc3 *dwc)
>                         dwc->maximum_speed =3D USB_SPEED_HIGH;
>         }
>
> -       ret =3D dwc3_core_soft_reset(dwc);
> +       ret =3D dwc3_core_get_phy(dwc);
>         if (ret)
>                 goto err0;
>
> -       ret =3D dwc3_phy_setup(dwc);
> +       ret =3D dwc3_core_soft_reset(dwc);
>         if (ret)
>                 goto err0;
>
> -       ret =3D dwc3_core_get_phy(dwc);
> +       ret =3D dwc3_phy_setup(dwc);
>         if (ret)
>                 goto err0;

cool, thanks for figuring this one out ;-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAllUligACgkQzL64meEa
mQYLrA//erniUVkrFQqYzUaR6KSXS3Nb/cOJoklwJK8ya5NmlOBSxkekQEIc0OtM
m4rWmTGW30a/bp7ZS4f5O8puBA6WxgRzxFI7p06GyChew8C04kJVF57mIKbzO7jD
1+ZwJ4j63ukIC6yBC8xQPNpLxIqLerhDHwx2jG8f3C2SUQCWzC0BAAI9veQaldbq
1R5vLyPb61i2wGSyEDKGc5qOFqxvaywDMRdYcmfh/8UyCFolgb6H53kkbuVEpWN5
xLa38vAVDts8d7FszUP0jPWg2FwalEbe3Qx6+R+qgRlTDjZRsondwmGFI9hAvFfM
TOTV5Fd6nF5BJzLkO6VpQiksV5ItmdSfZs9wnoF6/RPdqN29aFVnABwW1ZT5dpDU
jHhVMbmwjT31bd1KFs0ke6UcfBY7r/7jhs+LIdKeJ+w97gGyulDbgRmV35tQyMbf
cLP+tYCzyuYE/yJT/W0hOLegqZLqnkoRi7n5mudRmv1sHnOV2OBjGKgMw8MXP4p+
Or5jjCEPcx684DR4NYjbeggtoU5KSgQE4TPQoMKBzWsNKOgRb7sV99mxmZrdkPox
tc6CEXFByO9mq4mjM4ldQBlKxXGZvEuJBMsOH7k9g/ewWxRh2EazJSDBbL03rpKO
GBuGwI7bqeDVHroR9i55OHoqY8BAHCT8eFTD1EAcGMSQjZliJ+w=
=cnN2
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
