From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [ANNOUNCE] new PM branch: pm-20081119
Date: Thu, 20 Nov 2008 18:53:04 +0100
Message-ID: <AD610D1D-BA9D-4760-A72F-8AE172C9F999@student.utwente.nl>
References: <87d4grdxqh.fsf@deeprootsystems.com> <345163910811200045n3af8b3b5mbd30601aeeee31e@mail.gmail.com> <87y6zeb8mi.fsf@deeprootsystems.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-19--211718612"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:48519 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753471AbYKTRxP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Nov 2008 12:53:15 -0500
In-Reply-To: <87y6zeb8mi.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Peter Reid <ppeter.reid@gmail.com>, linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-19--211718612
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 20 nov 2008, om 18:38 heeft Kevin Hilman het volgende geschreven:

> "Peter Reid" <ppeter.reid@gmail.com> writes:
>
>> Hello kevin,
>>   Here is what i did to put it to suspend, which fails.
>>
>> [root@beagleboard]# echo  mem > /sys/power/state
>> PM: Syncing filesystems ... done.
>> Freezing user space processes ... (elapsed 0.00 seconds) done.
>> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
>> Suspending console(s)
>> Class driver suspend failed for cpu0
>> PM: Some devices failed to power down
>
> Hi Peter,
>
> Thanks for testing on Beagle.  Do you mind sharing your .config?  And,
> would you mind testing with the attached config?  This PM branch will
> currently only work with a minimal set of drivers.  Many of the
> current drivers will still prevent retention and OFF mode.
>
> Do you have CPUfreq enabled?  I saw this 'class driver suspend'
> problem when I had CPUfreq enabled.  This branch doesn't currently
> have CPUfreq support, so you can leave that disabled.
>
> I've also noticed problems on ES2 Beagle as well that I haven't
> figured out yet.  Namely, I think the bootloader is leaving certain
> modules (namely DSS and IVA) in a state that is preventing hitting
> retention.
>
> Immediately after boot, the DSS powerdomain is still ON and it should
> be in retention, same for IVA but I haven't debugged this further on
> Beagle.  The same kernel works on 3430SDP so that's why my hunch
> points to the u-boot.
>
> The kernel needs a way to ensure that after booting all the unused
> modules are in a state where they are not preventing idle.  Even with
> disabled clocks, certain modules can prevent idle.  Paul Walmsley has
> written the 'omapdev' layer which will now make it easier to do this
> boot-time init, but it is currently not there.  We currently have to
> rely on bootloaders doing the right thing.
>
> The beagle bootloader does all sorts of stuff with DSS, MMC, audio
> etc.  so it is a likely candidate.

Only the TI version does that, you'd be better of using the 'omap3'  
branch of the u-boot arm git, or Steve Sakomans git tree (which is  
where the upstream patches originate from).
I don't know if that version fixed DSS and IVA, but it is a lot  
cleaner and saves a considerable amount of boot time :) A binary is  
located at:

http://www.angstrom-distribution.org/demo/beagleboard/u-boot.bin

That binary also contains a fix for the 'l1neon' problem where the  
optimized version of ffmpeg or mplayer would crash under heavy load.

regards,

Koen



--Apple-Mail-19--211718612
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJJaQCMkyGM64RGpERAvQ2AKCS1Hrw+sqRwJu5g9dJxB59yKngIwCfchVQ
h7Q7Ioz7l8njAOKdsmwHTqw=
=VARI
-----END PGP SIGNATURE-----

--Apple-Mail-19--211718612--
