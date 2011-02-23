From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: Linux-next as of 20110222 broken on OMAP4
Date: Wed, 23 Feb 2011 18:22:15 +0530
Message-ID: <AANLkTina9+NxE=5J3E8PeaEuX_FXM2k=HCjLL1tyCgTa@mail.gmail.com>
References: <b858222d69a83460e469b80ee13cfbe8@mail.gmail.com>
 <4D63B160.3010103@ti.com> <20110222191343.GP15225@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A0952FD@dbde02.ent.ti.com>
 <AANLkTikZvYa9Q2n8QK+LRfUbukKwAe3nAY3UkJ0whhi5@mail.gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB037A09554C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34396 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182Ab1BWMwg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 07:52:36 -0500
Received: by wyg36 with SMTP id 36so789931wyg.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 04:52:35 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037A09554C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, Feb 23, 2011 at 5:50 PM, DebBarma, Tarun Kanti
<tarun.kanti@ti.com> wrote:
>> -----Original Message-----
>> From: Kishore Kadiyala [mailto:kishorek.kadiyala@gmail.com]
>> Sent: Wednesday, February 23, 2011 5:37 PM
>> To: DebBarma, Tarun Kanti
>> Cc: Tony Lindgren; Cousson, Benoit; Gadiyar, Anand; linux-omap
>> Subject: Re: Linux-next as of 20110222 broken on OMAP4
>>
>> On Wed, Feb 23, 2011 at 10:20 AM, DebBarma, Tarun Kanti
>> <tarun.kanti@ti.com> wrote:
>> >> -----Original Message-----
>> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> >> owner@vger.kernel.org] On Behalf Of Tony Lindgren
>> >> Sent: Wednesday, February 23, 2011 12:44 AM
>> >> To: Cousson, Benoit
>> >> Cc: Gadiyar, Anand; linux-omap
>> >> Subject: Re: Linux-next as of 20110222 broken on OMAP4
>> >>
>> >> * Cousson, Benoit <b-cousson@ti.com> [110222 04:50]:
>> >> > Hi Anand,
>> >> >
>> >> > On 2/22/2011 10:49 AM, Gadiyar, Anand wrote:
>> >> > > Looks like linux-next as of today is broken on at least OMAP4=
=2E
>> >> > >
>> >> > > Turning on earlyprintk, I get a crash in omap_init_mcspi. Dis=
abling
>> >> > > CONFIG_SPI_OMAP24XX gets me as far as the following lines fro=
m my
>> >> > > bootup log, but I haven't attempted to debug further.
>> >> > >
>> >> > > If there are any patches out there to fix this, let me know.
>> >> > > Else I will debug this sometime tomorrow.
>> >> >
>> >> > Yes, it was discussed with Tony and temporarily fixed yesterday=
=2E
>> >> >
>> >> > The SPI fix is is already in omap-for-linus, and the timer1 tem=
p fix
>> is
>> >> below.
>> >> > We need to find a better way to handle timer now that they are
>> >> initialized pretty soon.
>> >>
>> >> I applied the fix below with Paul's ack from the other thread.
>> >> So linux-next should be working again on omap4 when it gets rebui=
lt.
>> > I have tested on OMAP4 and OMAP3. BTW, it doesn't work on OMAP24xx=
=2E
>> <snip>
>>
>>
>> The following commit breaks OMAP2420 booting
>>
>> git bisect bad
>> 15490ef8ff8fd22d677cb5d4f6a98e5a79118dba is the first bad commit
>> commit 15490ef8ff8fd22d677cb5d4f6a98e5a79118dba
>> Author: Russell King <rmk+kernel@arm.linux.org.uk>
>> Date: =A0 Wed Feb 9 16:33:46 2011 +0000
>>
>> =A0 =A0ARM: Avoid building unsafe kernels on OMAP2 and MX3
>>
>> =A0 =A0OMAP2 (armv6) and MX3 turn off support for the V6K instructio=
ns, which
>> =A0 =A0when they include support for SMP kernels means that the resu=
lting
>> =A0 =A0kernel is unsafe on SMP and can result in corrupted filesyste=
ms as we
>> =A0 =A0end up using unsafe bitops.
>>
>> =A0 =A0Re-enable the use of V6K instructions on such kernels, and le=
t such
>> =A0 =A0kernels running on V6 CPUs eat undefined instruction faults w=
hich will
>> =A0 =A0be much safer than filesystem corruption. =A0Next merge windo=
w we can fix
>> =A0 =A0this properly (as it requires a much bigger set of changes.)
>>
>> =A0 =A0Acked-by: Tony Lindgren <tony@atomide.com>
>> =A0 =A0Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>
>> :040000 040000 48e40d2ece61dfc65cb701841efd31e3f7b2c0ff
>> df6ed06ca039457b7929bdd2fe5ca9ea6a331844 M =A0 =A0 =A0arch
> I was thinking Paul's patch already tested on N800, OMAP2420!
> [PATCH 0/8] OMAP2+: hwmod/clockevent: allow late-init of individual =A0=
 =A0 hwmods
> In other words, Paul's patch fixed the breakage on OMAP24xx.
> --
> Tarun
>

Sorry it was on lkml and not on linux-next

Regards,
Kishore
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
