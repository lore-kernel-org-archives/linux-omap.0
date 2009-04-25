From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 00/10] OMAP3: SR: Fixes in Smartreflex driver
Date: Sat, 25 Apr 2009 09:41:21 +0200
Message-ID: <ADF5B6F1-EE56-4376-B833-8A178C6D4DEE@student.utwente.nl>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FB25180A@dbde02.ent.ti.com> <87d4b4zc8e.fsf@deeprootsystems.com> <49F16044.6000603@nokia.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-9-345076469"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:55488 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663AbZDYHlt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 25 Apr 2009 03:41:49 -0400
Received: from [172.20.1.5] (vpn006011.vpn.utwente.nl [130.89.6.11])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id n3P7fNpw015840
          for <linux-omap@vger.kernel.org>; Sat, 25 Apr 2009 09:41:26 +0200
In-Reply-To: <49F16044.6000603@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-9-345076469
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 24 apr 2009, om 08:46 heeft Roger Quadros het volgende geschreven:

> ext Kevin Hilman wrote:
>> "Nayak, Rajendra" <rnayak@ti.com> writes:
>>> Re-sending this patch-set with some mailer issues resolved. They  
>>> now apply cleanly
>>> with a git-am/git-apply.
>>>
>>> Hi,
>>>
>>> This series fixes a set of defects/issues in Smartreflex driver.  
>>> SR autocompensation is now
>>> functional and is validated with these patches on a ES3.1 based  
>>> SDP with the N values in Efuse.
>>>
>>> The patches also make the Smartreflex driver independent of SRF by  
>>> using the OMAP PM apis
>>> instead of calls to SRF.
>>>
>>> Patches apply on top of the latest pm branch from Kevin's pm tree.
>>> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap- 
>>> pm.git
>> Rajendra,
>> This series seems to boot on SDP and Beagle but I recetly tried on
>> RX51 and it hangs in omap3_sr_init().
>> Using Lauterbach, I tracked it to hang in sr_configure_vp() at this
>> PRM write to the PRM_VP1_VLIMITTO register:
>> 		prm_write_mod_reg(PRM_VP1_VLIMITTO_VDDMAX |
>> 					PRM_VP1_VLIMITTO_VDDMIN |
>> 					PRM_VP1_VLIMITTO_TIMEOUT,
>> 					OMAP3430_GR_MOD,
>> 					OMAP3_PRM_VP1_VLIMITTO_OFFSET);
>> Should these min/max/timeout values be board specific?
>> Kevin
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux- 
>> omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> It runs on rx51 if we set CONFIG_OMAP_PM_SRF instead of  
> CONFIG_OMAP_PM_NOOP.

I can confirm that switching to CONFIG_OMAP_PM_SRF fixes a similar  
problem I'm seeing on a gumstix overo.

regards,

Koen


--Apple-Mail-9-345076469
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJ8r6jMkyGM64RGpERAgCwAJ4+NEN1J6QrTTaZbUiXPHLp4Hm96gCgjXFp
9Ra6/a+3sKS+Gti0l6CMi8U=
=hG+U
-----END PGP SIGNATURE-----

--Apple-Mail-9-345076469--
