From: =?ISO-8859-1?Q?Andreas_Bie=DFmann?=
	<andreas.biessmann@corscience.de>
Subject: Re: OMAP3 NAND ECC selection
Date: Fri, 06 Dec 2013 18:35:02 +0100
Message-ID: <52A20AC6.9060200@corscience.de>
References: <alpine.DEB.2.01.1312051000270.17561@pmeerw.net> <CAFqH_50vhgJ=ktqmYRo+ZO1bbRmiME+kXVt6sLJL91q9A2S7TA@mail.gmail.com> <52A04E75.3010609@corscience.de> <alpine.DEB.2.01.1312051711410.20976@pmeerw.net> <20131205171326.GA26766@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IKCdnde46RKgR5j1CfdkxkxTUs0HdWDod"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:51691 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758159Ab3LFRfe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Dec 2013 12:35:34 -0500
In-Reply-To: <20131205171326.GA26766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-mtd@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IKCdnde46RKgR5j1CfdkxkxTUs0HdWDod
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/05/2013 06:13 PM, Tony Lindgren wrote:
> * Peter Meerwald <pmeerw@pmeerw.net> [131205 08:13]:
>>>>> I'd like to be able to update MLO and u-boot from within a booted L=
inux
>>>>> system on the device (I have to resort to u-boot for that where I c=
an
>>>>> control the ECC scheme used)
>>
>>>> Meanwhile, to do this we use a small userspace program created by
>>>> Javier Martinez in order to flash the MLO in our OMAP3 boards. See
>>>> http://git.isee.biz/?p=3Dpub/scm/writeloader.git;a=3Dsummary
>>
>>> we used another aproach here. See
>>> http://article.gmane.org/gmane.linux.drivers.mtd/43804
>>
>> pretty much what I have been looking for, thanks!
>=20
> Hmm well both methods should work, but is there anything stopping us
> merging the module param patch to the mainline tree?

We could do so, should I provide a proper patch?
On the other hand I think this approach is a workaround to circumvent
the MTD architecture flaws mostly needed in embedded systems where we
control the whole environment. Should we really introduce this switch to
the whole bunch of users working with mainline distros on their beagle
style HW?
I think the user space tool approach is more useful there.

regards

Andreas Bie=DFmann


--IKCdnde46RKgR5j1CfdkxkxTUs0HdWDod
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJSogrGAAoJEHPlkEBPIQBj20MQALfiflIznOyUspyjX0LX+NXi
HQoBdeg6tqb28LNp46NZoFU2GSEAGtpn4xyBQIZ9u6M4Ed4a9w0r3djSkR5/n6zD
CvMyEPPh3g3Viv/lo9YSzkydYN68CYBiVNOVxfs28lG6JCn7+I3B1qSwznMXYqqd
WfjozV8EVPK41JqIsIKv3d0mpVEPCH2ZUGa/nH+CuZaHxOsWp4uKjUs2StQCJs3z
tNO6pQBK5IzV1ctKqC5HslDO8iDgGwThQ3PmtG07uV1o30c1jhNEuXTh4sK5SI5s
kmFIkfxFbwaTKwF+mz0CjstRpBmYKAv/53kRwswQJjIU+Lf0+FCUA44FZ1FyrnmW
fJXlMNMsMjVjq6q6ZyKZsm75fzEalOyFZZKaWE27LJpeCbDAqgHtB+uz2kgqqb2w
dS1vRXAnQDXeFKUc9P2371WeqS1pm4ismjeyLqBTtXBWKhoWmlzIZazvFs+FTPb8
dJw+07r2ZDQCkbrSXfYA16yIj2u8nZTXm7lG/nwh0AwJfiRc1xmpNwE7FKf+yfzW
ULYnuelVgybrX/3/sIjBsjseJpew/RDM0wP/nK2Wq8jtS3aa5FlFW1PWAUYRsuxd
69pAmKkyb0NasveI1wiGwjmKh6y+k+sy4Uwle1hxdbKD3qLuTSVMdG7/z9QkT27Q
a2jHmyVVHLJuziEPtQ6N
=/sZU
-----END PGP SIGNATURE-----

--IKCdnde46RKgR5j1CfdkxkxTUs0HdWDod--
