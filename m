From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 0/3] Add support for OMAP35x processors (v3)
Date: Tue, 13 Jan 2009 21:16:42 +0100
Message-ID: <D508FBA1-309F-465C-9DB6-10112B36FAD4@student.utwente.nl>
References: <1231617620-18667-1-git-send-email-premi@ti.com> <87hc43j8o7.fsf@deeprootsystems.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-4-167532267"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:55716 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755181AbZAMUSQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jan 2009 15:18:16 -0500
In-Reply-To: <87hc43j8o7.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-4-167532267
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 13 jan 2009, om 20:41 heeft Kevin Hilman het volgende geschreven:

> Sanjeev Premi <premi@ti.com> writes:
>
>> These patches provide support for the OMAP35x processors.
>>
>> This is essentially a re-submit after series of discusions
>> earlier in the list. It had always been getting pushed in
>> my to-do list :(
>> See: http://marc.info/?l=linux-omap&m=122029900603111&w=2
>>
>> Based on the comments received, this patch includes following:
>>  1) Updates to Kconfig
>>     (Includes the changes suggested by Aguirre Rodriguez)
>>  2) Runtime check for OMAP35x
>>  3) Updates to omap3_evm_defconfig
>>
>> If the changes look good, I can make updates to Beagle,
>> Overo and Pandora boards as well.
>>
>> Best regards,
>> Sanjeev
>
> Sanjeev,
>
> Is the HEAD of linux-omap working for you on omap3evm?  I just got my
> EVM and am getting it going but it doesn't boot without
> CONFIG_DEBUG_LL, and with that enabled, as soon as the normal serial
> driver is enabled, the serial console goes crazy with garbage output.

That's indeed the same problem I reported some weeks ago. The console  
returns to normal when getty starts.

regards,

Koen




>
>
> I'm about to push a new PM branch and wanted to do some testing on the
> EVM.
>
> Kevin
>
>> Sanjeev Premi (3):
>>  Add support for OMAP35x processors
>>  Runitme check for OMAP35x
>>  Updates for OMAP3EVM
>>
>> arch/arm/configs/omap3_evm_defconfig     |    5 ++
>> arch/arm/mach-omap2/Kconfig              |   65 +++++++++++++++++++ 
>> +--
>> arch/arm/mach-omap2/board-omap3evm.c     |    2 +-
>> arch/arm/plat-omap/common.c              |   68 ++++++++++++++++++++ 
>> +++
>> arch/arm/plat-omap/include/mach/common.h |    1 +
>> arch/arm/plat-omap/include/mach/cpu.h    |   88 ++++++++++++++++++++ 
>> +++++++++-
>> 6 files changed, 220 insertions(+), 9 deletions(-)
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux- 
>> omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-4-167532267
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJbPasMkyGM64RGpERAlYfAKCw9tJqCunjCI8kWP2WQQNjeDLQiACfVZ8O
KrQ30AzVUXeLqXGruQk1Ipc=
=NigS
-----END PGP SIGNATURE-----

--Apple-Mail-4-167532267--
