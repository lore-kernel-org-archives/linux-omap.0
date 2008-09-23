From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PREVIEW 2] New display subsystem for OMAP2/3
Date: Tue, 23 Sep 2008 12:27:32 +0200
Message-ID: <7863ECF6-2BE0-42B1-BDE3-DEEE7286A3A5@student.utwente.nl>
References: <1222094917.8299.33.camel@tubuntu> <20080922151045.GC8171@atomide.com> <1222157985.8299.38.camel@tubuntu> <47749FCA-154E-4203-892C-5A3544F9CDFC@student.utwente.nl> <20080923092445.GA5102@atomide.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-25--954682961"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:59611 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807AbYIWK1l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Sep 2008 06:27:41 -0400
Received: from [172.20.1.5] (vpn006015.vpn.utwente.nl [130.89.6.15])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m8NARYEv026155
          for <linux-omap@vger.kernel.org>; Tue, 23 Sep 2008 12:27:35 +0200
In-Reply-To: <20080923092445.GA5102@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-25--954682961
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 23 sep 2008, om 11:24 heeft Tony Lindgren het volgende geschreven:

> * Koen Kooi <k.kooi@student.utwente.nl> [080923 11:41]:
>>
>> Op 23 sep 2008, om 10:19 heeft Tomi Valkeinen het volgende  
>> geschreven:
>>> On Mon, 2008-09-22 at 18:10 +0300, ext Tony Lindgren wrote:
>>>> * Tomi Valkeinen <tomi.valkeinen@nokia.com> [080922 17:49]:

>>>> I sent a preview of a new display subsystem for OMAP2/3 some time
>>>>> ago:
>>>>> http://marc.info/?l=linux-omap&m=122114505030542&w=2
>>>>>
>>>>> I now have updated it, the patches are at the same place:
>>>>> http://www.bat.org/~tomba/omap-dss/
>>>>
>>>> This discussion should go to linux-fbdev-devel list. Please keep  
>>>> l-o
>>>> list Cc'd though. Also you should post the patches as a proper  
>>>> inline
>>>> series, please see git-send-email man page.
>>>>
>>>
>>> Ok, I'll move it to linux-fbdev-devel.
>>>
>>> I didn't post the patches inline, as they are quite big (250k+). I
>>> thought there was a "rule" to put big patches to some public place,
>>> not
>>> to mail them.
>>>
>>> What is the proper procedure for this work? Discuss and review the
>>> patches on fbdevel, and mail to l-o when finalized? Or go directly  
>>> to
>>> Linus' tree?
>>
>> Or a branch on l-o (like pm-0)  that will get rebased when things
>> change.
>
> I'd suggest discussing it on fbdevel list, and then have the necessary
> patches included into the mainline kernel via fbdevel. If you cc l-o
> list, people will have a chance to comment also.

This patch also hooks into boardcode for omap3 boards, which AFAIK  
aren't in mainline yet, which makes it hard to funnel a working patch  
through the fbdev tree to mainline. But apart from that, going through  
fbdev-devel first would cut down on tedious review rounds later on.
Does davinci share enough bits to make this DSS lib work for that as  
well?

regards,

Koen

--Apple-Mail-25--954682961
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI2MSWMkyGM64RGpERAne8AJsEA3xOxRdfgYZwKgOVl3AZjEecugCgoz+7
wMDFmKeIhDOus4fJ4yT/epw=
=ZocN
-----END PGP SIGNATURE-----

--Apple-Mail-25--954682961--
