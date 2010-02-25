From: Jacob john <jacob.john74@gmail.com>
Subject: Re: About multicore OMAP
Date: Thu, 25 Feb 2010 19:57:36 +0530
Message-ID: <31ee32481002250627r6509c52ds46765baafec3828f@mail.gmail.com>
References: <31ee32481002230504m2cc4dfebu85426681e76b4ee@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C42E14F4@dbde02.ent.ti.com>
	 <31ee32481002230620p40c15a10s86bf17fbacff9e94@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C42E1545@dbde02.ent.ti.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C42E15B9@dbde02.ent.ti.com>
	 <31ee32481002232045s6cbebab1x4184b175c6595f6@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C42E16F4@dbde02.ent.ti.com>
	 <31ee32481002250607j34f18276s5d478b5756543a55@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C43BF4F5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f172.google.com ([209.85.221.172]:33856 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932680Ab0BYO1h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 09:27:37 -0500
Received: by qyk2 with SMTP id 2so484672qyk.1
        for <linux-omap@vger.kernel.org>; Thu, 25 Feb 2010 06:27:36 -0800 (PST)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C43BF4F5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Feb 25, 2010 at 7:45 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: Jacob john [mailto:jacob.john74@gmail.com]
>> Sent: Thursday, February 25, 2010 7:37 PM
>> To: Shilimkar, Santosh
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: About multicore OMAP
>>
>> On Wed, Feb 24, 2010 at 10:24 AM, Shilimkar, Santosh
>> <santosh.shilimkar@ti.com> wrote:
>> >> -----Original Message-----
>> >> From: Jacob john [mailto:jacob.john74@gmail.com]
>> >> Sent: Wednesday, February 24, 2010 10:16 AM
>> >> To: Shilimkar, Santosh
>> >> Cc: linux-omap@vger.kernel.org
>> >> Subject: Re: About multicore OMAP
>> >>
>> >> On Tue, Feb 23, 2010 at 10:20 PM, Shilimkar, Santosh
>> >> <santosh.shilimkar@ti.com> wrote:
>> >> > John,
>> >> >> -----Original Message-----
>> >> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owne=
r@vger.kernel.org] On Behalf Of
>> >> >> Shilimkar, Santosh
>> >> >> Sent: Tuesday, February 23, 2010 8:01 PM
>> >> >> To: Jacob john
>> >> >> Cc: linux-omap@vger.kernel.org
>> >> >> Subject: RE: About multicore OMAP
>> >> >>
>> >> >> > -----Original Message-----
>> >> >> > From: Jacob john [mailto:jacob.john74@gmail.com]
>> >> >> > Sent: Tuesday, February 23, 2010 7:51 PM
>> >> >> > To: Shilimkar, Santosh
>> >> >> > Cc: linux-omap@vger.kernel.org
>> >> >> > Subject: Re: About multicore OMAP
>> >> >> >
>> >> >> > It's=C2=A0Blaze with=C2=A0two lcd's and pico, looks great. C=
an I have this
>> >> >> > linux-omap kernel running on OMAP4?, plus I'm looking for SM=
P
>> >> >> > benchmark results etc.
>> >> >> >
>> >> >> Linux-omap kernel with omap_4430sdp_defconfig will boot on bla=
ze with SMP. This
>> >> >> won't have lot of driver support as such currently. Also L2 ca=
che support is in
>> >> >> on the way to make it to mainline as well. You should be able =
to play with this
>> >> >> with some basic benchmark test related to CPU.
>> >> >>
>> >> >> Display , Audio, Pico, keypad, touchscreeen etc drivers are av=
ailable with the
>> >> >> release and you should be able get more details from the TI co=
ntact person who
>> >> >> gave you the blaze. You can also get the performance numbers f=
rom same source
>> >> >>
>> >> > If you need the full kernel with all the drivers I mentioned ab=
ove, you can use
>> >> > below git.
>> >> > http://dev.omapzoom.org/?p=3Dintegration/kernel-omap4.git;a=3Ds=
hortlog;h=3Drefs/heads/L24.4
>> >>
>> >> Good help so far......, wondering why two trees for OMAP4, tell m=
e the
>> >> diff b/n this list and the zoom.
>> >> is there a different mailing list for zoom? confusing... and I am
>> >> sorry....thanks for the pointers
>> >>
>> > The mailing list is only one (Linux-omap). There is no difference.=
 Linux-omap
>> > tree is almost mainline equivalent from omap4 point of view. The f=
eatures are developed
>> > on the tree I mentioned above. The tested features will be up-stre=
amed after rebasing
>> > one by one. You will find only upstreamed/lined-up features in lin=
ux-omap tree.
>> >
>> Thanks Sentosh for your help, what do you advise? you always wanted =
me
>> to go to zoom, so I don't have to pull from Linux-omap.
>> When I should use zoom and when I should come back to Linux-omap?
>> please clarify. Good way to ask "which is latest?" :)
>> I am sorry, I am confused....help me
>>
> The dev.omapzoom.org trees gets updated regularly with linux-omap/mai=
ninle. So basically
> it is ( Linux-omap-master + =C2=A0Additional drivers including IPC). =
So you can use the
> git available on dev.omapzoom.org. This will enable you to have all t=
he drivers in
> one tree.

Sounds great, appreciate this, TI gave Android kernel, so from
omapzoom I get Android kernel?
please share GIT url path for the same, any readme is there like
Linux-omap? thanks for your help
>
> Regards,
> Santosh
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
