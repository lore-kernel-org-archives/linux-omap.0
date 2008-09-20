From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Sat, 20 Sep 2008 13:41:55 +0200
Message-ID: <6AA0F75E-0ECE-4EBD-A83A-C514A2A3190D@student.utwente.nl>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com> <20080905011235.GZ23085@atomide.com> <5e088bd90809042318k762df6c8k79ef1fcbad9a8781@mail.gmail.com> <dfeb90390809200422x79c91c5v2172bbd28b42c634@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-16-938063248"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:34859 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbYITLmv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Sep 2008 07:42:51 -0400
In-Reply-To: <dfeb90390809200422x79c91c5v2172bbd28b42c634@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arun KS <getarunks@gmail.com>
Cc: Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-16-938063248
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 20 sep 2008, om 13:22 heeft Arun KS het volgende geschreven:

> On Fri, Sep 5, 2008 at 11:48 AM, Steve Sakoman <sakoman@gmail.com>  
> wrote:
>> On Thu, Sep 4, 2008 at 6:12 PM, Tony Lindgren <tony@atomide.com>  
>> wrote:
>>> * Jarkko Nikula <jarkko.nikula@nokia.com> [080821 04:58]:
>>>> Here are two patches adding support for OMAP2430 in McBSP driver  
>>>> and
>>>> adding support for 2430 and 34xx in ASoC OMAP McBSP DAI driver.
>>>>
>>>> These are generated from top of currect l-o head but they apply  
>>>> also on
>>>> top of Hiroshi's virtual clock patches with some offsets.
>>>>
>>>> If you have change to try them out on those CPUs, I would be  
>>>> happy to
>>>> hear. I've tested these only on N810. Second patch will naturally  
>>>> go
>>>> through the alsa-devel when we have necessary McBSP patches  
>>>> upstream.
>>>
>>> Can you please refresh these against the current l-o head?
>>
>> I've been testing these patches along with my Overo patches on the
>> current l-o head.  Audio is working fine, so the mcbsp changes  
>> haven't
>> broken anything.
>
> Is the null substream pointer was the problem in the alsa-lib?

We suspect it's in alsa-lib

> Is it fixed?

Sadly not :(

regards,

Koen
>
> I am facing similar issue when using 5912 osk with tlvaic23b codec.
>
> Regards,
> Arun
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-16-938063248
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI1OGFMkyGM64RGpERAlsyAKCAzYq73IAi9Iw1onKFGCdVg98JwACguQyY
nMMqH1B/RgxT0IaUPHhvui0=
=MR1u
-----END PGP SIGNATURE-----

--Apple-Mail-16-938063248--
