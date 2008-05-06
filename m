From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: public git l2 cache off.
Date: Tue, 6 May 2008 08:58:19 +0200
Message-ID: <C0573CA4-5426-4DCD-A630-3563BF5387AB@student.utwente.nl>
References: <1209575641-25613-1-git-send-email-tony@atomide.com> <20080505131403.93d0a64d.jarkko.nikula@nokia.com> <3B6D69C3A9EBCA4BA5DA60D9130274290439AAD8@dlee13.ent.ti.com> <A9503EED-55EA-4656-AABD-A6DA28F717DA@student.utwente.nl>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:49076 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752851AbYEFG6a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 May 2008 02:58:30 -0400
Received: from [172.20.1.5] (vpn006017.vpn.utwente.nl [130.89.6.17])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m466v9ur015481
          for <linux-omap@vger.kernel.org>; Tue, 6 May 2008 08:58:21 +0200
In-Reply-To: <A9503EED-55EA-4656-AABD-A6DA28F717DA@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 6 mei 2008, om 07:38 heeft Koen Kooi het volgende geschreven:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
>
> Op 6 mei 2008, om 01:27 heeft Woodruff, Richard het volgende  
> geschreven:
>> Hi,
>>
>> Looks like a tweak from the ARM or TI tree may be needed.  Builds  
>> of recent pulls of the OMAP3 kernel show L2 cache is disabled. This  
>> really has a huge performance impact.
>>
>> I don't have time right now to suggest a patch but may look some  
>> time this week.  TI internal kernels do have it enabled.
>>
>> A stop in Lauterbach and a look at the L2EN bit in AUX control  
>> register will show it is not correct.
>
> Enabling L2 cache was removed from proc-v7.S since was cortex  
> specific instead of armv7 specific

For reference:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=7092fc38ee770251aed361572bf6bed05fcf3ee2
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIIAGMMkyGM64RGpERAgh0AJ9lAmo66yaPu6Yxhp7yeW4S5pvaKwCgppYv
jUZY8KpVn0AuQDdhjN2gfBg=
=fH+z
-----END PGP SIGNATURE-----
