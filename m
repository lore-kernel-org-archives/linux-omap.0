From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: omap3beagle: register SD interface
Date: Tue, 22 Apr 2008 20:07:58 +0300
Message-ID: <20080422170758.GB10347@kedavra.cpe.vivax.com.br>
References: <3A21C48B-9730-4BB7-9095-B08510070F7D@student.utwente.nl> <7EAD1AEEA7621C45899FE99123E124A001922608@dbde01.ent.ti.com> <03879EA5-591C-4ED6-A3F5-8600F90CC8E7@student.utwente.nl> <200804220957.43599.david-b@pacbell.net> <E7D86ACF-575E-4A2B-8193-82A3A0B6FFCF@student.utwente.nl>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:52902 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989AbYDVRGb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2008 13:06:31 -0400
Content-Disposition: inline
In-Reply-To: <E7D86ACF-575E-4A2B-8193-82A3A0B6FFCF@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: David Brownell <david-b@pacbell.net>, "Syed Mohammed, Khasim" <khasim@ti.com>, linux-omap@vger.kernel.org

On Tue, Apr 22, 2008 at 07:00:04PM +0200, Koen Kooi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
>
> Op 22 apr 2008, om 18:57 heeft David Brownell het volgende geschreven:
>> On Tuesday 22 April 2008, Koen Kooi wrote:
>>> --- a/include/asm-arm/arch-omap/board-omap3beagle.h
>>> +++ b/include/asm-arm/arch-omap/board-omap3beagle.h
>>> @@ -29,6 +29,8 @@
>>>   #ifndef __ASM_ARCH_OMAP3_BEAGLE_H
>>>   #define __ASM_ARCH_OMAP3_BEAGLE_H
>>>
>>> +extern void __init sdp_mmc_init(void);
>>> +
>>>   #ifdef CONFIG_TWL4030_CORE
>>>
>>>   #define TWL4030_IRQNUM                INT_34XX_SYS_NIRQ
>>
>> That's really not the right place to declare shared
>> routines.  Plus of course, since that routine isn't
>> specific to SDP boards it shouldn't use that name...

Besides this, it'll break compilation cuz of __init. That one is defined
in <linux/init.h> and it's not being included here. In any case, the
best would be to be __{init,exit,devinit,devexit} from prototypes.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
