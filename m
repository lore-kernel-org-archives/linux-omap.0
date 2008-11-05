From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [REVIEW  PATCH 8/9] DSS: support for Beagle Board
Date: Wed, 5 Nov 2008 22:15:52 +0100
Message-ID: <8254061F-889F-4DBB-84AE-FD68F225106F@student.utwente.nl>
References: <20081104160946.19071.44903.stgit@tubuntu> <20081104161038.19071.98198.stgit@tubuntu> <D518F5F9-95AB-4881-BD63-8135263203AC@student.utwente.nl> <1225879556.8052.5.camel@tubuntu>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-15-651932711"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:41141 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870AbYKEVQP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Nov 2008 16:16:15 -0500
In-Reply-To: <1225879556.8052.5.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-15-651932711
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 5 nov 2008, om 11:05 heeft Tomi Valkeinen het volgende geschreven:

> On Tue, 2008-11-04 at 18:28 +0100, ext Koen Kooi wrote:
>> Op 4 nov 2008, om 17:10 heeft Tomi Valkeinen het volgende geschreven:
>>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
>>> ---
>>>
>>> arch/arm/mach-omap2/board-omap3beagle.c |  121 ++++++++++++++++++++ 
>>> ++
>>> ++++++---
>>> 1 files changed, 108 insertions(+), 13 deletions(-)
>>>
>>> +static struct omap_display_data beagle_display_data_dvi = {
>>> +	.type = OMAP_DISPLAY_TYPE_DPI,
>>> +	.name = "dvi",
>>> +	.panel_name = "panel-dvi",
>>> +	.u.dpi.data_lines = 24,
>>> +	.panel_reset_gpio = 170,
>>> +	.panel_enable = beagle_enable_dvi,
>>> +	.panel_disable = beagle_disable_dvi,
>>
>> gpio 170 is the enable (or disable, I forget which) for the DVI  
>> framer
>> (TFP410), not a reset gpio. It would be nice to have a way to enable/
>> disable the framer  from userspace since it burns 60-100mA.
>
> Well, is there a big difference between reset and enable?

Reset implies that power stays on (like the reset button on a  
desktop), while enable and disable imply power on and power off. Maybe  
that's just me :)

regards,

Koen


> Anyway, you
> can do
>
> echo "dvi e:0" > /sys/devices/platform/omapfb/displays
>
> and it will turn off the power.
>
> Or, alternatively, use the framebuffer blanking, although that has not
> been implemented to the panel-dvi.c (it's in panel-sdp3430.c).
>
>> regards,
>>
>> Koen
>
> Tom
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-15-651932711
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJEg0LMkyGM64RGpERAsZlAJ4ilk61mNTkwe6k1VUNM48fm6QvRwCdHkP+
RgtxOIJhBojjsQaVjgR4K2w=
=nMIB
-----END PGP SIGNATURE-----

--Apple-Mail-15-651932711--
