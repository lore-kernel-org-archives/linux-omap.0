From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: OMAP support in mainline?
Date: Fri, 19 Sep 2008 23:02:19 +0200
Message-ID: <B2408D1C-F1FC-43FA-9979-BCE6D344B609@student.utwente.nl>
References: <87tzcgi1gv.fsf@nokia.com> <20080916232505.GC25885@atomide.com> <20080917082043.04c94e2d.jarkko.nikula@nokia.com> <200809162255.00918.david-b@pacbell.net> <9934E327-66E0-48DF-9FB6-FFF828E5358B@student.utwente.nl> <5e088bd90809170524s6cfae9b9ye1379f11afb5bb79@mail.gmail.com> <48D3F921.8020306@balister.org> <1f11a5490809191357v144f969jb93b6cd5022db4d4@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-13-885287901"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:44653 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbYISVDt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Sep 2008 17:03:49 -0400
In-Reply-To: <1f11a5490809191357v144f969jb93b6cd5022db4d4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>
Cc: Philip Balister <philip@balister.org>, linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-13-885287901
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 19 sep 2008, om 22:57 heeft Ashwin Bihari het volgende geschreven:

> On Fri, Sep 19, 2008 at 3:10 PM, Philip Balister  
> <philip@balister.org> wrote:
>> Steve Sakoman wrote:
>>>
>>> On Wed, Sep 17, 2008 at 12:16 AM, Koen Kooi <k.kooi@student.utwente.nl 
>>> >
>>> wrote:
>>>
>>>> And they aren't working too well with current l-o git either with  
>>>> MUSB
>>>> being
>>>> broken. There's a patch to fix client mode, but host mode still  
>>>> isn't
>>>> working.
>>>
>>> Host mode musb is working just fine on Overo with the "set
>>> transceiver" patch.  Not sure why you are having trouble with Beagle
>>> (and can't check since I don't have my Beagle board with me at the
>>> moment)
>>
>> Does anyone have any suggestions how to figure out what is broken  
>> about OTG
>> used a host on the Beagle?
>>
>> Philip
>>
>
> On a related point..I built Kernel v.2.6.27-rc3 from the OMAPZOOM tree
> with MUSB OTG support. I plug in the mini-B connector into our board,
> and I get the interrupt and proper recognition that a peripheral mode
> should be used. When the mini-A connector is plugged in, however,
> nothing happens.
>
> Since there is only one interrupt that triggers the check on which
> cable-type was plugged in, why would the mini-A cable not cause an
> interrupt to be generated?

I can crash my evm by pressing a key on the keypad triggering an irq  
storm (see other thread), so it could be that something is wrong with  
irqs in .27rc :(

regards

Koen






>
>
> I've also tried compiling the code in just MUSB HOST. Nothing happens,
> when I plug in the mini-B cable, it's detected by markedly less things
> happen because I don't have peripheral support.
>
> Regards
> ~ Ashwin
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-13-885287901
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI1BNdMkyGM64RGpERAhk4AJ4rqQ84VxQ5go9OLPt5uG6Q7k8lNwCfTjut
5rPyLG9sug96jvs6bE418jA=
=oRGI
-----END PGP SIGNATURE-----

--Apple-Mail-13-885287901--
