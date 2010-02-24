From: Jacob john <jacob.john74@gmail.com>
Subject: Re: About multicore OMAP
Date: Wed, 24 Feb 2010 10:15:31 +0530
Message-ID: <31ee32481002232045s6cbebab1x4184b175c6595f6@mail.gmail.com>
References: <31ee32481002230504m2cc4dfebu85426681e76b4ee@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C42E14F4@dbde02.ent.ti.com>
	 <31ee32481002230620p40c15a10s86bf17fbacff9e94@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C42E1545@dbde02.ent.ti.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C42E15B9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:39413 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab0BXEpc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 23:45:32 -0500
Received: by qyk9 with SMTP id 9so219801qyk.5
        for <linux-omap@vger.kernel.org>; Tue, 23 Feb 2010 20:45:32 -0800 (PST)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C42E15B9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Feb 23, 2010 at 10:20 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> John,
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger=
=2Ekernel.org] On Behalf Of
>> Shilimkar, Santosh
>> Sent: Tuesday, February 23, 2010 8:01 PM
>> To: Jacob john
>> Cc: linux-omap@vger.kernel.org
>> Subject: RE: About multicore OMAP
>>
>> > -----Original Message-----
>> > From: Jacob john [mailto:jacob.john74@gmail.com]
>> > Sent: Tuesday, February 23, 2010 7:51 PM
>> > To: Shilimkar, Santosh
>> > Cc: linux-omap@vger.kernel.org
>> > Subject: Re: About multicore OMAP
>> >
>> > It's=C2=A0Blaze with=C2=A0two lcd's and pico, looks great. Can I h=
ave this
>> > linux-omap kernel running on OMAP4?, plus I'm looking for SMP
>> > benchmark results etc.
>> >
>> Linux-omap kernel with omap_4430sdp_defconfig will boot on blaze wit=
h SMP. This
>> won't have lot of driver support as such currently. Also L2 cache su=
pport is in
>> on the way to make it to mainline as well. You should be able to pla=
y with this
>> with some basic benchmark test related to CPU.
>>
>> Display , Audio, Pico, keypad, touchscreeen etc drivers are availabl=
e with the
>> release and you should be able get more details from the TI contact =
person who
>> gave you the blaze. You can also get the performance numbers from sa=
me source
>>
> If you need the full kernel with all the drivers I mentioned above, y=
ou can use
> below git.
> http://dev.omapzoom.org/?p=3Dintegration/kernel-omap4.git;a=3Dshortlo=
g;h=3Drefs/heads/L24.4

Good help so far......, wondering why two trees for OMAP4, tell me the
diff b/n this list and the zoom.
is there a different mailing list for zoom? confusing... and I am
sorry....thanks for the pointers

>
> Regards,
> Santosh
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
