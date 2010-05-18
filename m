From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 00/17] omap: mailbox: reorganize init
Date: Tue, 18 May 2010 15:03:26 +0300
Message-ID: <AANLkTim5SxEb64QbBQgBhufhgpQ33MNFBhuHixfUeVKp@mail.gmail.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
	 <20100518.114642.35020415.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59758 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757059Ab0ERMD3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:03:29 -0400
Received: by fxm10 with SMTP id 10so996629fxm.19
        for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 05:03:27 -0700 (PDT)
In-Reply-To: <20100518.114642.35020415.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, linux@arm.linux.org.uk

On Tue, May 18, 2010 at 11:46 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>=
 wrote:
> From: ext Felipe Contreras <felipe.contreras@gmail.com>
> Subject: [PATCH v2 00/17] omap: mailbox: reorganize init
> Date: Fri, 14 May 2010 17:01:33 +0200
>
>> Hi,
>>
>> The main purpose of this patch series is to be able to compile mach =
platform
>> data as built-in. Otherwise, client modules such as bridgedriver wil=
l load the
>> platform code, but not the mach code when mailbox is built as a modu=
le.
>
> I think that this is the *udev* responsibility. The udev should take
> care of loading mailbox_mach.ko since the mailbox platform device was
> registered by devices.ko at bootup. devices.ko is built in earlier
> than dspbridge.ko, so the mailbox platform device is registered
> earlier than the dsp device, "C6410". this registration ordering
> should take care of the dependency if the udevd works correctly.

I'm not familiar with this kind of module loading, but certainly not
all systems have udev.

I realized the problem because I have a bare-bones system in my
beagleboard where I had to manually load mailbox_mach.

>> Unfortunately, there's no easy way to do that since plat and mach co=
de are
>> deepely interrelated. So the first patches try to separate the mailb=
ox
>> registering through a defined omap_mbox_platform_data.
>>
>> Also, it's worth noting that mailboxes are not a one-to-one mapping =
to
>> resources; that is, some resources belong to multiple mboxes. So it'=
s best to
>> think of mailboxes as fake devices. That is why custom platform_data
>> is required.
>
> Actually there were logical mailbox devices/instances implemented, bu=
t
> it was broken partially when dropping mailbox class support by
> accident(*1). This is the reason whey omap_mbox struct has unused dev
> pointer now. At that time, the sysfs interface was not necessary but
> the device creation itself should not have been removed. I'll get thi=
s
> code back again soon.
>
> The role of each modules were/should be:
>
> =C2=A0- devices.ko: =C2=A0 =C2=A0 =C2=A0 =C2=A0 a platform device, ba=
sed on its resource.
> =C2=A0- mailbox_mach.ko: =C2=A0 =C2=A0a platform driver to register m=
ultiple logical mboxes/devices.
> =C2=A0- mailbox.ko: =C2=A0 =C2=A0 =C2=A0 =C2=A0 a kind of framework w=
hich holds multiple logical mboxes/devices.
>
> The sysfs structure is like below:
>
> =C2=A0~# tree -d -L 2 /sys/devices/platform/omap2-mailbox/

I don't see the point of having 'omap2' there, at best it should be
'omap-mailbox', or perhaps even just 'mailbox'.

> The platform device omap2-mailbox accomodatess logical mboxes.

Wouldn't it be better the way my patches handle them?
 * devices.ko:  doesn't care about mbox
 * mach_omap1/mailbox.ko:  registers "omap-mailbox" platform device
with a list of logical mboxes for OMAP1
 * mach_omap2/mailbox.ko:  registers "omap-mailbox" platform device
with a list of logical mboxes for OMAP2
 * plat-omap/mailbox.ko: creates platform driver based on logical list
of mboxes from platform device and handles the list internally

The end result would be the exactly same, except that there's no hard
dependency between the mach, and plat code.

>> Finally, a bunch of cleaning up is done in the very first patches, s=
pecially for
>> OMAP1.
>
> Most of the cleanups are quite ok.
>
> Would it be possible to rebase them on the top of my coming patch to
> get back logical device entry?

Where is that?

> Sorry for the late reply, it took some time to recall my bad memory..=
=2E

No worries.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
