From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH 2.6.39] omap: board-4430sdp: revert hsmmc_info reordering
Date: Fri, 1 Apr 2011 15:56:52 +0530
Message-ID: <AANLkTin3hLZEKOJ6bWN6sk_1G6eQyvX+ovAKT2XviC4u@mail.gmail.com>
References: <1301640748-17161-1-git-send-email-coelho@ti.com>
 <AANLkTikPawWg8Wt8F4oeEBbvUOziPNrH+7A3MyXkx8Lw@mail.gmail.com> <1301646040.1988.421.camel@cumari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36375 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755322Ab1DAK1N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 06:27:13 -0400
Received: by wya21 with SMTP id 21so2805724wya.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 03:27:12 -0700 (PDT)
In-Reply-To: <1301646040.1988.421.camel@cumari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Kishore Kadiyala <kishore.kadiyala@ti.com>, Benoit Cousson <b-cousson@ti.com>

On Fri, Apr 1, 2011 at 1:50 PM, Luciano Coelho <coelho@ti.com> wrote:
> On Fri, 2011-04-01 at 12:46 +0530, Kishore Kadiyala wrote:
>> On Fri, Apr 1, 2011 at 12:22 PM, Luciano Coelho <coelho@ti.com> wrot=
e:
>> > The order in which the MMC cards are defined in the the 4430sdp bo=
ard
>> > file seems to have been mistakenly reorderded as part of an unrela=
ted
>> > patch. =A0In commit 0005ae73cfe44ee42d0be12a12cc82bf982f518e, wher=
e only
>> > the dev_name was supposed to be changed, the mmc order was changed=
 as
>> > well. =A0This caused the external SD card reader not to be recogni=
zed,
>> > at least on Blaze.
>>
>> Both OMAP4 SDP & Blaze boards have internal eMMC as storage.
>>
>> Just think of some scenario as below with FS in =A0eMMC
>> [with external card recognized as mmcblk0 and eMMC as mmcblk1]:
>> Booting with both external card on MMC1 and eMMC on MMC2 and having
>> bootargs set to root=3D/dev/mmcblk1px [x=3D parition number].
>> Removing the external card from slot makes eMMC recognized as mmcblk=
0 and
>> in this case kernel can't pick the file system as passed above in th=
e bootargs.
>
> Yes, this makes sense. =A0The internal eMMC should be mapped first, I
> agree.
>
>
>> So, making the permanent storage on the boards registered as first
>> block device gets
>> rid of the problem.
>
> Yes, but there is something wrong that causes the external MMC not to=
 be
> recognized at all if you map the internal MMC first. =A0There is a bu=
g
> elsewhere that needs to be fixed before this change can be made.
>
> As I said, I don't know much about the OMAP MMC subsystem and I don't
> have the time right now to investigate what really is wrong. =A0That'=
s why
> I sent this patch, as quick fix (or rather getting rid of a regressio=
n).

I don't see any regression with 2.6.39-rc1 on either OMAP4430SDP or Bla=
ze,
logs below:

Blaze log : http://pastebin.com/mGB5uD7P
SDP log : http://pastebin.com/A5uAFfsr

>
> Another thing is that this is a crosspatch change. =A0It shouldn't be=
 part
> of the same patch that changes the name of the driver, since this is
> totally unrelated. =A0If you really think this needs to be done, it s=
hould
> have been done in a separate patch.

Agree , it went accidentally in V6.

>
> --
> Cheers,
> Luca.
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
