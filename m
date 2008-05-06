From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: public git l2 cache off.
Date: Tue, 6 May 2008 18:20:08 +0200
Message-ID: <4BE5184F-5D21-4487-B19A-DCA436A9C77E@student.utwente.nl>
References: <1209575641-25613-1-git-send-email-tony@atomide.com> <20080505131403.93d0a64d.jarkko.nikula@nokia.com> <3B6D69C3A9EBCA4BA5DA60D9130274290439AAD8@dlee13.ent.ti.com> <A9503EED-55EA-4656-AABD-A6DA28F717DA@student.utwente.nl> <3B6D69C3A9EBCA4BA5DA60D9130274290439AD2F@dlee13.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:51865 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529AbYEFQU2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 May 2008 12:20:28 -0400
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D9130274290439AD2F@dlee13.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 6 mei 2008, om 17:06 heeft Woodruff, Richard het volgende geschreven:
>> Enabling L2 cache was removed from proc-v7.S since was cortex  
>> specific
>> instead of armv7 specific and u-boot explicitly turns of L2 before
>> booting into linux. I made a reverse patch, but my omap3 board  
>> doesn't
>> boot if I use it:
>
> Our 2.6.24 kernel does something close and boots fine on OMAP3-SDP  
> and Labrador boards.  Which platform did you try on?

Beagleboard (omap3530)

> I'll try the latest from here on SDP with this and see if it works.   
> There is also a difference in CR handling.  I had submitted long  
> back a fix to Russell but let it get by me as I didn't have the time  
> to fix per his comments.  I think our version was more correct then  
> the one in place but was still lacking a bit.
>
> [*] It seems possible you could have an issue depending on what your  
> boot loader is or isn't doing for you.

U-boot (both 1.1.4 and 1.3.2) calls l2disable() before booting linux,  
so linux needs to enable it. I vote for removing the l2disable() in u- 
boot, but I can see that people might be stuck with broken binary  
bootloaders...

regards,

Koen



>
>
> Regards,
> Richard W.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIIIU6MkyGM64RGpERAskVAJ9v+zkGPPVi5E2Icb+LHPpoX9rdYgCeOQde
zo4KEu3uL8kZliQFQ4YESWE=
=mmNw
-----END PGP SIGNATURE-----
