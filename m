From: twebb <taliaferro62@gmail.com>
Subject: Re: MMC2 support in linux-omap-2.6.27 (omap1)
Date: Fri, 27 Mar 2009 10:09:50 -0400
Message-ID: <dbdb2ea60903270709s4aaf932aybfbb473d198a3e81@mail.gmail.com>
References: <dbdb2ea60903250713s2eba347aib5758cf5157979da@mail.gmail.com>
	 <dbdb2ea60903251449u5d8e3edfvd58291923ecf6693@mail.gmail.com>
	 <49CB40FC.5070907@nokia.com>
	 <e1a3109c0903260313k54fb0a85kad478258c22958e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:43838 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756AbZC0OJx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Mar 2009 10:09:53 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1243734qwh.37
        for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2009 07:09:51 -0700 (PDT)
In-Reply-To: <e1a3109c0903260313k54fb0a85kad478258c22958e6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shankar Ganesh <shankarganeshk@gmail.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Thu, Mar 26, 2009 at 6:13 AM, Shankar Ganesh
<shankarganeshk@gmail.com> wrote:
>
> On Thu, Mar 26, 2009 at 2:16 PM, Adrian Hunter <adrian.hunter@nokia.c=
om>
> wrote:
>>
>> twebb wrote:
>>>
>>> On Wed, Mar 25, 2009 at 10:13 AM, twebb <taliaferro62@gmail.com> wr=
ote:
>>>>
>>>> I'm currently using linux-omap-2.6.27 (tag=3Domap1) and trying to =
add
>>>> MMC2 support. =A0I've back ported what I think I need from various=
 files
>>>> inn l-o-2.6.28-omap1. =A0I will eventually move to 2.6.28-omap1 bu=
t for
>>>> now am trying to get it working on 2.6.27.
>>>>
>>>> Traces show that all looks good up until first command is issued, =
then
>>>> nothing seems to happen. =A0STAT reg shows 0, don't see clock or c=
md
>>>> activity. =A0MMC1 is working fine with an SD card; MMC2 is connect=
ed to
>>>> eMMC flash. =A0Seems like I'm missing something basic like a clock=
 or
>>>> enable, though I've confirmed ICLK and FCLK are enabled. =A0Any id=
eas?
>>>>
>>>> Thanks,
>>>> twebb
>>>>
>>>
>>> I found at least part of my problem. =A0SDVS field of HCTL was bein=
g set
>>> to 0x7 (3.3V) instead of 0x5 (1.8V), and apparently MMC2 must be se=
t
>>> for 0x5.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>>
>> The most up to date omap_hsmmc.c is here:
>>
>>
>> http://git.kernel.org/?p=3Dlinux/kernel/git/drzeus/mmc.git;a=3Dblob;=
f=3Ddrivers/mmc/host/omap_hsmmc.c;h=3D488f222054f8a1493142d02da526c951d=
ef5ddfe;hb=3Dnext
>>
>> That includes the 10 patches on LKML except number 8
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
> Refer=A0 http://git.omapzoom.com/?p=3Drepo/omapkernel.git;a=3Dsummary=
=A0 has working
> MMC2 code. Also this version detects eMMC on MMC2
>

I'm having difficulty detecting eMMC flash on MMC2.  I ported in the
code from the git, and most everything looks good.  However, it always
fails detecting the eMMC with a timeout.  If I handpoke commands to
the eMMC I see the same thing - even with the most basic commands.  I
see CLK and CMDs going to the eMMC, but never see any responses on the
CMD line from the eMMC.  Any ideas what I might be doing wrong?  (I do
have an SD card working fine on MMC1.  Also, the eMMC flash is
hardwired with power and has no CardDetect or WriteProtect logic - so
none of that should be an issue.)

Help,
twebb

(sorry for double posting)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
