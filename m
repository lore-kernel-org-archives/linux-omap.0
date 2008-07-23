From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 0/2] Add clock post-rate-change notifier
Date: Wed, 23 Jul 2008 19:09:10 +0200
Message-ID: <837B2605-7943-4E56-90FE-3BEADC7A4F11@student.utwente.nl>
References: <20080620231155.21640.89851.stgit@localhost.localdomain> <000001c8eb1f$787c8880$68bf18ac@ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-25-155066117"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:59113 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbYGWRJ3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Jul 2008 13:09:29 -0400
In-Reply-To: <000001c8eb1f$787c8880$68bf18ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-25-155066117
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 21 jul 2008, om 12:49 heeft Rajendra Nayak het volgende geschreven:

> Hi Paul,
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Paul Walmsley
>> Sent: Saturday, June 21, 2008 4:44 AM
>> To: linux-omap@vger.kernel.org
>> Subject: [PATCH 0/2] Add clock post-rate-change notifier
>>
>>
>> This series adds a clock rate change notifier to the OMAP clock
>> framework.  Currently only post-rate-change notification is
>> implemented, although pre-rate-change notification is in the works.
>
> Was there any patch set posted after this with pre-rate change  
> notifications
> support?
>
> I am currently working on CPUFreq patches and CPUFreq requires a pre  
> notification
> to be able to update jiffies/BogoMips.

Are your omap3 cpufreq patches available for testing? I'm very  
interested in getting cpufreq running on the beagleboard.

regards,

Koen


>
>
> regards,
> Rajendra
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-25-155066117
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIh2W5MkyGM64RGpERAl1qAJ94u86VRztuyjkFvgXW0SFiYqDa4wCeKIgs
xZaZ1DSbkndV5Dm9nAdTwMs=
=DRe0
-----END PGP SIGNATURE-----

--Apple-Mail-25-155066117--
