From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: ASoC broken on 3.2-rc4?
Date: Thu, 8 Dec 2011 12:26:22 -0800
Message-ID: <CAGDS+n=B=Q-id-L0AfkBvB6yvUoNbBcOdJg=ec=Jued-8AmS2g@mail.gmail.com>
References: <CAGDS+nmW+fgo20znqdQch9Uvu7Q9=p1D0AwPqx4vjakXZ6PiAQ@mail.gmail.com>
	<CA+2YH7v+cAGHFGuL6yY80p8=Tob=J=MkMnt3UUNycPuJ8EWkeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40468 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab1LHU0W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 15:26:22 -0500
Received: by vbbfc26 with SMTP id fc26so1793970vbb.19
        for <linux-omap@vger.kernel.org>; Thu, 08 Dec 2011 12:26:22 -0800 (PST)
In-Reply-To: <CA+2YH7v+cAGHFGuL6yY80p8=Tob=J=MkMnt3UUNycPuJ8EWkeA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Thu, Dec 8, 2011 at 11:33 AM, Enrico <ebutera@users.berlios.de> wrot=
e:
> On Wed, Dec 7, 2011 at 9:58 PM, Steve Sakoman <sakoman@gmail.com> wro=
te:
>> I just began working with 3.2-rc4 on Overo and Beagleboard xM.
>>
>> On both machines I see the driver init, but no alsa device created.
>> For example on Overo:
>>
>> Advanced Linux Sound Architecture Driver Version 1.0.24.
>> <snip>
>> overo SoC init
>> ALSA device list:
>> =A0No soundcards found.
>>
>> Has anyone else seen this? =A0Just want to make sure it isn't a know=
n
>> issue before digging in and debugging.
>
> Maybe patch at [1] is still not in mainline?

The patch is there, but one also needs to make sure the
CONFIG_MFD_TWL4030_AUDIO change is made in one's defconfig too :-)

Thanks,

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
