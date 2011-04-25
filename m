From: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
Subject: Re: [Regression?] Removed regulator support in ehci-omap
Date: Mon, 25 Apr 2011 10:11:20 -0400
Message-ID: <4DB58108.4040708@signal11.us>
References: <20110411093214.GA18215@rainbow> <4DA3350E.2060400@gmail.com> <BANLkTinDMZ+CyGCmzZu8cSz1L_yFXxm+vg@mail.gmail.com> <112ef82aebc719ef25cde126f2014ebc@mail.gmail.com> <20110412040420.GB25239@rainbow> <bcd954a468e6a07bd673b7d0731e9344@mail.gmail.com> <4DB0D58E.4030508@signal11.us> <8712165194c49f0b4d8c1bd1fe717b8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDDDECD471EEA27955D04B07F"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8712165194c49f0b4d8c1bd1fe717b8a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: Dmitry Artamonow <mad_soft-aPYA7nAdAYY@public.gmane.org>, Steve Sakoman <sakoman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Steve Calfee <stevecalfee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDDDECD471EEA27955D04B07F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/24/2011 02:37 AM, Keshava Munegowda wrote:
>> -----Original Message-----
>> From: Alan Ott [mailto:alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org]
>> Sent: Friday, April 22, 2011 6:41 AM
>> To: Keshava Munegowda
>> Cc: Dmitry Artamonow; Steve Sakoman; Steve Calfee; Felipe Balbi;
> linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>> omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Subject: Re: [Regression?] Removed regulator support in ehci-omap
>>
>> On 04/12/2011 12:20 PM, Keshava Munegowda wrote:
>>>> Ah, so EHCI/OHCI common code was moved into drivers/mfd... Good.
>>>> But seems regulators support was lost somewhere during transition -
> the
>>>> only mentioning about regulators in omap-usb-host.c is "#include" :
>>>>
>>>> mad@macmini:~/kernel-hack/linux-2.6(master)$ grep -i regulator
>>> drivers/mfd/omap-usb-host.c
>>> Thanks ! I will add some time next week!
>> I have confirmed this on my BeagleBoard-xM. 2.6.38 works, but the
>> 2.6.39-rc4+ head from yesterday did not. It seems that the regulator
>> does not turn the power on for the USB hub which the ethernet is
>> attached to.
>>
>> I connected this issue to bug 33092 in bugzilla[1].
>>
>> Alan.
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D33092
> I have posted the patches on April 22, 2011.
> If possible I request you to test this.

Hi Keshava,

If you mean this patch[1], then I tested it against the head and it
didn't fix my problem. I couldn't convince myself that your patch was
supposed to be the whole fix to my problem (since it wasn't mentioned on
this thread) so I didn't reply with my findings. Sorry about that.

Thanks for taking a look,

Alan.

[1] http://www.spinics.net/lists/linux-usb/msg45618.html



--------------enigDDDECD471EEA27955D04B07F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJNtYEIAAoJEFZEOVT5235iExUH/RWT54gH4d1TcMXxjSzqW4JJ
K7h0WzKymyZPGSLPKGYWJN+xfM4HdFl/L1HLdP8pRFTL9gj6ZBE/BgsQxCU8wpxE
/XvL3IMPl+dA6W5ZLsFVYeTllp/4rXBCPZNSB0AQ7BTxiRqSRJxmZZ0Av2oNweIA
ANzEHBJqfhKbz+HkFpihgl12+BU7kRaVCZ2Y65k5VgyK0EhyaVDmbPR2l6xuRtAf
I8raPpEavoJiAEqD8pz1TJAIpOw0r20fqXgIlD4+ljWw581b9KNvqHbQVhkZwWRx
H50Cvct7VPY+S39Nnttn4WPxV32j7McswMiGz0RGyMZ6b62es1lgZKhNarpCRCg=
=N0RY
-----END PGP SIGNATURE-----

--------------enigDDDECD471EEA27955D04B07F--


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
