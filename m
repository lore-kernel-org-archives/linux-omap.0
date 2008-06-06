From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH] Fix for the i2c initialiation error on 2430sdp
Date: Fri, 6 Jun 2008 17:28:44 +0200
Message-ID: <FD7816A1-5B40-4554-99B4-1155B53671C1@student.utwente.nl>
References: <c656a4d20806060612s55b047b2p783056dfac058093@mail.gmail.com> <d2e4e528efc51e918b953d9b77673ea2@felipebalbi.com> <a0580c510806060757t63d84b82qa889c52f3adcb70c@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:40331 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752251AbYFFP3a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Jun 2008 11:29:30 -0400
In-Reply-To: <a0580c510806060757t63d84b82qa889c52f3adcb70c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Felipe Balbi <me@felipebalbi.com>, arun c <arunedarath@mistralsolutions.com>, linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 6 jun 2008, om 16:57 heeft Eduardo Valentin het volgende geschreven:

> Hi,
>
> On Fri, Jun 6, 2008 at 10:46 AM, Felipe Balbi <me@felipebalbi.com>  
> wrote:
>>
>>
>> On Fri, 6 Jun 2008 18:42:56 +0530, "arun c"
>> <arunedarath@mistralsolutions.com> wrote:
>>> static int __init omap2430_i2c_init(void)
>>> {
>>> -     omap_register_i2c_bus(1, 400, NULL, 0);
>>>      omap_register_i2c_bus(2, 2600, NULL, 0);
>>> +     omap_register_i2c_bus(1, 400, NULL, 0);
>>
>> maybe there's a hw restriction that you must initiliaze
>> hs bus first?
>
> If that is the reason, it'd be good to add some comment here to avoid
> people re-ordering it in the future.

I wonder if this applies to omap3 as well.

regards,

Koen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFISVeuMkyGM64RGpERApf1AJ0exIac5U2KCWDWZsyZ2ss9S1CTZwCfeDl8
IA1K1JvjYxYrgJ4NQ5/0WXI=
=7dm6
-----END PGP SIGNATURE-----
