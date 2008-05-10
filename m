From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [beagleboard] Re: TWL4030 intermittent freakout on boot
Date: Sat, 10 May 2008 17:16:28 +0200
Message-ID: <423471D7-9E8F-4BF1-BFEB-056BF13B484E@student.utwente.nl>
References: <alpine.DEB.1.00.0805081201450.27986@utopia.booyaka.com> <EF9B9E21-ACCB-46A7-94C7-1FB6DD58B093@student.utwente.nl> <20080508182807.GE24454@atomide.com> <48249322.4060004@googlemail.com> <20080509213608.GA5976@atomide.com> <5e088bd90805091611q4a8a22d0l3dab427fe644a990@mail.gmail.com> <48256CDE.6040600@googlemail.com> <5e088bd90805100642s2ddf4048he6b01cc7a07e736e@mail.gmail.com> <3B6D69C3A9EBCA4BA5DA60D9130274290447A000@dlee13.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:39303 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353AbYEJPQr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 May 2008 11:16:47 -0400
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D9130274290447A000@dlee13.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Richard Woodruff <r-woodruff2@ti.com>, Beagle Board <beagleboard@googlegroups.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 10 mei 2008, om 16:57 heeft Woodruff, Richard het volgende  
geschreven:
> Hi,
>
>> A grep of u-boot sources for the OMAP3 EVM does not yield any
>> occurrences of twl403 so you might be on to something with this
>> theory!
>
> Your SYS_BOOT line values make a difference in TWL behavior.  The  
> mask ROM knows specifics about this companion chip.
>
> One aspect people seem to miss is the fact that the mask ROM will  
> touch T2 based on the boot order.  The mask ROM also monkeys with  
> some internal clocks and modules.
>
> So, just because your x-loader or u-boot doesn't touch a register  
> that doesn't mean the mask ROM hasn't.  So don't expect reset value.

Would it be an option to dump TWL regs with something like devmem2  
after boot for the .22 WTBU kernels and linux-omap git ones? Or just  
printk() them during early boot? It would be nice the have the correct  
values, so the git twl driver can use those.

regards,

Koen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIJbxOMkyGM64RGpERAkufAKCSRqUoZxcjzdQNTARs3/Uo2RjYaACfYcwo
3Niob3Jr57b3c1QmDU9CWDk=
=TzdK
-----END PGP SIGNATURE-----
