From: "arun c" <arun.edarath@gmail.com>
Subject: Re: [PATCH] Fix for the i2c initialiation error on 2430sdp
Date: Mon, 9 Jun 2008 11:08:02 +0530
Message-ID: <c656a4d20806082238j22aa4d9cq8284098a92c8d585@mail.gmail.com>
References: <c656a4d20806060612s55b047b2p783056dfac058093@mail.gmail.com>
	 <d2e4e528efc51e918b953d9b77673ea2@felipebalbi.com>
	 <a0580c510806060757t63d84b82qa889c52f3adcb70c@mail.gmail.com>
	 <FD7816A1-5B40-4554-99B4-1155B53671C1@student.utwente.nl>
	 <003e01c8c884$6010a140$318918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:37731 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbYFIFiF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jun 2008 01:38:05 -0400
Received: by ti-out-0910.google.com with SMTP id b6so520654tic.23
        for <linux-omap@vger.kernel.org>; Sun, 08 Jun 2008 22:38:02 -0700 (PDT)
In-Reply-To: <003e01c8c884$6010a140$318918ac@ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Chandra shekhar <x0044955@ti.com>, Felipe Balbi <me@felipebalbi.com>, Koen Kooi <koen@openembedded.org>

On Sat, Jun 7, 2008 at 3:23 PM, Chandra shekhar <x0044955@ti.com> wrote:
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Koen Kooi
>> Sent: Friday, June 06, 2008 8:59 PM
>> To: Eduardo Valentin
>> Cc: Felipe Balbi; arun c; linux-omap@vger.kernel.org
>> Subject: Re: [PATCH] Fix for the i2c initialiation error on 2430sdp
>>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>>
>> Op 6 jun 2008, om 16:57 heeft Eduardo Valentin het volgende
>> geschreven:
>>
>> > Hi,
>> >
>> > On Fri, Jun 6, 2008 at 10:46 AM, Felipe Balbi <me@felipebalbi.com>
>> > wrote:
>> >>
>> >>
>> >> On Fri, 6 Jun 2008 18:42:56 +0530, "arun c"
>> >> <arunedarath@mistralsolutions.com> wrote:
>> >>> static int __init omap2430_i2c_init(void) {
>> >>> -     omap_register_i2c_bus(1, 400, NULL, 0);
>> >>>      omap_register_i2c_bus(2, 2600, NULL, 0);
>> >>> +     omap_register_i2c_bus(1, 400, NULL, 0);
>> >>
>> >> maybe there's a hw restriction that you must initiliaze hs
>> bus first?
>
>
> There isn't  any hardware restriction while registering the busses. Although we can put a comment

As Chandra shekhar verified there is no hardware restriction,
I will put a comment and resend the patch.

> As to why we are registering the bus 2 first.
> Also itWouldn't matter to 3430 as TWL4030 is on bus 1.
>
>
>> >
>> > If that is the reason, it'd be good to add some comment
>> here to avoid
>> > people re-ordering it in the future.
>>
>> I wonder if this applies to omap3 as well.
>>
>> regards,
>>
>> Koen
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.4.5 (Darwin)
>>
>>
>
>
> Regards
> Chandra Shekhar
>
Regards,
Arun C
