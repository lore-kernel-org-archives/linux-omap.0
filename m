From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: USB driver issue
Date: Sat, 2 Aug 2008 12:04:17 +0200
Message-ID: <13802753-8461-4FE0-9DA5-6CF1F8A782A9@student.utwente.nl>
References: <420751.76388.qm@web53204.mail.re2.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1-993572851"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:48301 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752255AbYHBKF3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 2 Aug 2008 06:05:29 -0400
In-Reply-To: <420751.76388.qm@web53204.mail.re2.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source@linux.omap.com, linux-usb@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1-993572851
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 2 aug 2008, om 11:53 heeft Emanoil Kotsev het volgende geschreven:

> I'll stop this discussion. If you feel you are right, then this  
> should be true and I don't mind it.
>
> The problem was with you calling 2.6.22 a "such old", but I give up  
> this discussion too. You have the right to think it is and I have  
> the right to do not. After I have your point of view I have to live  
> with that, hope the same for you.
>
> It would be anyway nice if you do not make such (2.6.22 - "such  
> old") statments, but if you wish you could and I don't mind either.
>
> I think I'll spend my time filing bugs instead of arguing with you,  
> as it leads to nothing obviously.
>
> Unfortunately I still don't have a solution - until bugs from 3rd  
> party vednors are solved you label the kernel as old ... but may be  
> in future it will change.


2.6.22 will only get older in the future

>
>
> regars
>
> --- On Sat, 8/2/08, Felipe Balbi <me@felipebalbi.com> wrote:
>
>> From: Felipe Balbi <me@felipebalbi.com>
>> Subject: Re: USB driver issue
>> To: "Emanoil Kotsev" <deloptes@yahoo.com>
>> Cc: me@felipebalbi.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org 
>> >, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com 
>> >, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
>> Date: Saturday, August 2, 2008, 11:17 AM
>> On Sat, Aug 02, 2008 at 02:02:27AM -0700, Emanoil Kotsev
>> wrote:
>>> Felipe, thank you for answering. I now see what's
>> the problem with you
>>
>> you should really rephrase this.
>>
>>> I don't see anywhere the word
>> "production" in your list, and that's my
>> point. I want something that works and if there is a bug to
>> be able to fix it and make it more stable.
>>
>> And that will come from the commercial company you said
>> below.
>> Hopefully that commercial company will also notify the
>> community so that
>> bug won't happen again in recent kernel versions.
>>
>> That's exactly what we do when we release a new version
>> of our Maemo SW,
>> it's not only a theme change, we're fixing bugs all
>> around the thing.
>>
>>> You debug, test and develop but you DON'T ralay on
>> it. I am willing to have the oposite. NOT developeing,
>> testing and debuging, but just using it - can you understand
>> that?
>>
>> And this is something you still don't get. I DO relay
>> on it. Of course
>> we freeze internal development as soon as we release the
>> pieces to
>> linux-omap, because it doesn't make any sense for us to
>> keep backporting
>> so many pieces, although I remember backporting some
>> patches to 2.6.18
>> back in n800 time.
>>
>>> I want to use a kernel for PRODUCTION purposes, not
>> for playing with it as you obviously do. I don't have
>> time to start over debugging different issues that I did not
>> have with the previous release, especially when it comes to
>> my personal data that's stored out there.
>>
>> you're wrong here. By the time we release our kernel,
>> we also publish
>> everything to linux-omap tree. You can get any version of
>> linux-omap and
>> boot your n8xx up to maemo desktop. That's even not a
>> big deal.
>> Unfortunately we have a few closed source pieces which we
>> are still
>> trying to open, believe me, it's not as easy as
>> publishing.
>>
>>> Even commercial companies support flavour of their
>> OS's for years, so why shouldn't the linux community
>> don't do it. It would bring benefit to all of us. Please
>> refer to the discussion with Greg. I thinkg it makes more
>> sense
>>
>> But then you can get the support from those commercial
>> companies,
>> can't you ?
>>
>> If there is someone else already supporting older versions
>> of the kernel
>> why should we stop ? The thing is, I just want to be sure
>> the bug
>> someone is reporting still happens in current code,
>> otherwise I won't
>> bother looking. If it's fixed, I just don't have
>> enough time to
>> backport, anyone else can do it for you, or even you if you
>> have the
>> time/expertise to do so.
>>
>> -- 
>> balbi
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-1-993572851
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIlDEjMkyGM64RGpERApRRAJwIbHZ9L/sPQJcb+QoGL2+VaWL3HACeNKpC
WVeI98sM9TQ5kSbAXRQm5U4=
=8OWu
-----END PGP SIGNATURE-----

--Apple-Mail-1-993572851--
