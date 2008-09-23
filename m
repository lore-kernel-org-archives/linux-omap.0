From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PREVIEW 2] New display subsystem for OMAP2/3
Date: Tue, 23 Sep 2008 10:41:36 +0200
Message-ID: <47749FCA-154E-4203-892C-5A3544F9CDFC@student.utwente.nl>
References: <1222094917.8299.33.camel@tubuntu> <20080922151045.GC8171@atomide.com> <1222157985.8299.38.camel@tubuntu>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-17--961039541"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:53509 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbYIWIlp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Sep 2008 04:41:45 -0400
Received: from [172.20.1.5] (vpn006015.vpn.utwente.nl [130.89.6.15])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m8N8feEv030517
          for <linux-omap@vger.kernel.org>; Tue, 23 Sep 2008 10:41:40 +0200
In-Reply-To: <1222157985.8299.38.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-17--961039541
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 23 sep 2008, om 10:19 heeft Tomi Valkeinen het volgende geschreven:

> Hi,
>
> On Mon, 2008-09-22 at 18:10 +0300, ext Tony Lindgren wrote:
>> Hi,
>>
>> * Tomi Valkeinen <tomi.valkeinen@nokia.com> [080922 17:49]:
>>> Hi,
>>>
>>> I sent a preview of a new display subsystem for OMAP2/3 some time  
>>> ago:
>>> http://marc.info/?l=linux-omap&m=122114505030542&w=2
>>>
>>> I now have updated it, the patches are at the same place:
>>> http://www.bat.org/~tomba/omap-dss/
>>
>> This discussion should go to linux-fbdev-devel list. Please keep l-o
>> list Cc'd though. Also you should post the patches as a proper inline
>> series, please see git-send-email man page.
>>
>
> Ok, I'll move it to linux-fbdev-devel.
>
> I didn't post the patches inline, as they are quite big (250k+). I
> thought there was a "rule" to put big patches to some public place,  
> not
> to mail them.
>
> What is the proper procedure for this work? Discuss and review the
> patches on fbdevel, and mail to l-o when finalized? Or go directly to
> Linus' tree?

Or a branch on l-o (like pm-0)  that will get rebased when things  
change.

regards,

Koen


>
>
> Tomi
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-17--961039541
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI2KvEMkyGM64RGpERAi0PAKCXx6OGMNCyRznYQzMWukizRDSN4gCbB+Gq
Crh7CEfTvQQaSfxycUrv4EE=
=slX3
-----END PGP SIGNATURE-----

--Apple-Mail-17--961039541--
