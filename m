From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: NULL pointer dereference when using ALSA SOC
Date: Thu, 25 Sep 2008 15:32:27 +0200
Message-ID: <01BA5FDD-AC4E-4450-B576-8A7DA867E314@student.utwente.nl>
References: <dfeb90390809222326s44162f94sf42f96fdfc0a0690@mail.gmail.com>	<20080923115053.e404f43e.jarkko.nikula@nokia.com> <20080925140531.64fd14c9.jarkko.nikula@nokia.com> <48DB91A6.5080900@balister.org>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-11--770788498"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:58078 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754532AbYIYNcn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Sep 2008 09:32:43 -0400
In-Reply-To: <48DB91A6.5080900@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, ext Arun KS <getarunks@gmail.com>, Steve Sakoman <sakoman@gmail.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-11--770788498
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 25 sep 2008, om 15:27 heeft Philip Balister het volgende geschreven:

> Jarkko Nikula wrote:
>> On Tue, 23 Sep 2008 11:50:53 +0300
>> "ext Jarkko Nikula" <jarkko.nikula@nokia.com> wrote:
>>> On Tue, 23 Sep 2008 11:56:00 +0530
>>> "ext Arun KS" <getarunks@gmail.com> wrote:
>>>
>>>> Hi all,
>>>>
>>>> I am writing an ASOC driver for tlvaic23 on osk5912 platform.
>>>> When do an aplay, I m getting a  NULL pointer dereference. I added
>>>> some debug prints in the soc/core/pcm_native.c, also in codec and
>>>> platform drivers. The null pointer is comming in IOCTL
>>>> SNDRV_PCM_IOCTL_SYNC_PTR. Log is pasted below.
>>>>
>>> It's good that you can reproduce this on OSK as well.
>>>
>>> I think some configuration difference is revealing this bug out. For
>>> instance I can trigger this on Beagle with overo_defconfig +  
>>> manually
>>> adding support for Beagle (CONFIG_MACH_OMAP3_BEAGLE=y) and ASoC
>>> Beagle (CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE=y).
>>>
>>> But I cannot reproduce this with Beagle defconfig + manually adding
>>> support for Overo (CONFIG_MACH_OVERO=y) and ASoC Beagle
>>> (CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE=y).
>>>
>> I narrowed this into CONFIG_SLUB. When it's set, I can reproduce the
>> bug both with N810 and Beagle but not when using CONFIG_SLAB.
>> Can you try will the problem disappear on your OSK and Overo if you
>> select slab allocator instead? You find selection under "General
>> setup" menu.
>
> I've also verified this works on a Beagle with Angstrom.
>
> Thanks for tracking this down!


For people wanting to test it:

http://www.angstrom-distribution.org/demo/beagleboard/uImage

regards,

Koen

--Apple-Mail-11--770788498
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI25LtMkyGM64RGpERAviVAJ9xo8+TMY8mOT+JBTo18wPdqBTMygCgl56S
/AkbOHG4mlp2mtfaOHa/e5w=
=IHs+
-----END PGP SIGNATURE-----

--Apple-Mail-11--770788498--
