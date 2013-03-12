From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/8] usb: phy: nop: Add some parameters to platform data
Date: Tue, 12 Mar 2013 17:06:48 +0100
Message-ID: <513F5298.6000500@pengutronix.de>
References: <1363087466-32444-1-git-send-email-rogerq@ti.com>
 <1363087466-32444-2-git-send-email-rogerq@ti.com>
 <513F177D.40500@pengutronix.de> <513F37DD.9030301@ti.com>
 <513F38DF.5040404@pengutronix.de> <513F3B7E.8000002@ti.com>
 <513F3EF0.3030609@pengutronix.de> <513F47B4.2060004@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8345099681152115203=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <513F47B4.2060004-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, "Ujfalusi,
 Peter" <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============8345099681152115203==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2CGKASVCESFBPGLHQVWVG"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2CGKASVCESFBPGLHQVWVG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/12/2013 04:20 PM, Roger Quadros wrote:
> On 03/12/2013 04:42 PM, Marc Kleine-Budde wrote:
>> On 03/12/2013 03:28 PM, Roger Quadros wrote:
>>> On 03/12/2013 04:17 PM, Marc Kleine-Budde wrote:
>>>> On 03/12/2013 03:12 PM, Roger Quadros wrote:
>>>>> On 03/12/2013 01:54 PM, Marc Kleine-Budde wrote:
>>>>>> On 03/12/2013 12:24 PM, Roger Quadros wrote:
>>>>>>> Add clk_rate parameter to platform data. If supplied, the
>>>>>>> NOP phy driver will program the clock to that rate during probe.
>>>>>>>
>>>>>>> Also add 2 flags, needs_vcc and needs_reset.
>>>>>>> If the flag is set and the regulator couldn't be found
>>>>>>> then the driver will bail out with -EPROBE_DEFER.
>>>>>>
>>>>>> Is there a platform which fills out pdata.needs_vcc and
>>>>>> pdata.needs_reset? IMHO it makes no sense to add features for the =
non DT
>>>>>> case, if there isn't any user for it.
>>>>>>
>>>>>
>>>>> There can be a user in the non DT case as well. Consider the follow=
ing example:
>>>>
>>>> I'm just saying, let the implementation up to a real user for the no=
n DT
>>>> case. Beagleboard is ARM and there's no point of implementing non DT=

>>>> fall backs for ARM, IMHO.
>>>>
>>>
>>> Why do you say so?
>>>
>>> It doesn't depend on the CPU architecture. It depends on how the boar=
d designer
>>> wired the board. A non ARM platform could also face the same problem =
as beagle.
>>
>> Using -EPROBE_DEFER ist the way to solve the problem.
>=20
> did you mean isn't? If you did then what is the other option?

You're using -EPROBE_DEFER, that's all perfectly fine.

>>> It is not a non DT fallback. I believe many are still using non DT bo=
ot and it
>>> needs to work at least till we move all functionality to purely DT.
>>
>> From my point of view, it makes no sense today to implement new featur=
es
>> which have a fallback for the non-DT case, if there isn't a real user =
of
>> this feature. So IMHO don't add needs_vcc and needs_reset flags to the=

>> pdata, just take the information from the DT. As soon as there is a
>> non-DT user of this feature she/he can implement it or even better
>> switch to DT.
>=20
> Adding Peter to the loop. I faintly remember him mentioning this issue =
before
> for beagle. We really need the deferred probe mechanism or we need to r=
esort
> to device registering order.

> The first user for needs_vcc flag will be the beagleboard file. I just =
didn't
> implement it in this patch [1].

Okay, I wrongly assumed that there wouldn't be added any new features to
the old non-DT board files.

> On second thoughts, since [1] does work on beagleboard without requirin=
g the
> needs_vcc flag, I think we can just live without it.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2CGKASVCESFBPGLHQVWVG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE/UpsACgkQjTAFq1RaXHPoPgCfYxKeyNZejjADDKEVIFvuoEZL
eSMAnAs+6wcktL34QPVqPjcoPvxKGca6
=bv+y
-----END PGP SIGNATURE-----

------enig2CGKASVCESFBPGLHQVWVG--

--===============8345099681152115203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============8345099681152115203==--
