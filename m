From: Daniel Miller <danielrobertmiller@gmail.com>
Subject: Re: strange usb errors
Date: Wed, 4 Nov 2009 11:06:34 -0500
Message-ID: <a92b665b0911040806w2cf69025o75363df10fe980dd@mail.gmail.com>
References: <ac9c93b10903201109x79589487w13a74b2901d4f067@mail.gmail.com>
	 <loom.20091104T162352-461@post.gmane.org>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DE280401@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:49762 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756505AbZKDQGb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Nov 2009 11:06:31 -0500
Received: by ewy3 with SMTP id 3so3246273ewy.37
        for <linux-omap@vger.kernel.org>; Wed, 04 Nov 2009 08:06:35 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE280401@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Nov 4, 2009 at 10:55 AM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Daniel Miller
>> Sent: Wednesday, November 04, 2009 9:00 PM
>> To: linux-omap@vger.kernel.org
>> Subject: Re: strange usb errors
>>
>> Frans Meulenbroeks <fransmeulenbroeks <at> gmail.com> writes:
>>
>> >
>> > The other problem I have is with my wireless zd1211 based
>> wifi dongle.
>> > If I connect it I get:
>> >
>> > usb 1-2.2: new high speed USB device using ehci-omap and address 6
>> > usb 1-2.2: configuration #1 chosen from 1 choice
>> > usb 1-2.2: reset high speed USB device using ehci-omap and address=
 6
>> > phy0: Selected rate control algorithm 'pid'
>> > zd1211rw 1-2.2:1.0: phy0
>> > usb 1-2.2: firmware: requesting zd1211/zd1211_ub
>> > usb 1-2.2: firmware: requesting zd1211/zd1211_uphr
>> > usb 1-2.2: Could not load firmware file zd1211/zd1211_uphr.
>> Error number -2
>> > zd1211rw 1-2.2:1.0: couldn't load firmware. Error number -2
>> >
>> > Whether the dongle is directly connected or through a hub does not
>> > make a dfifference
>> >
>> > However the firmware is there and the very same firmware works und=
er
>> > opensuse and used to work under 2.6.27
>> >
>> > Anyone an idea ?
>> >
>> > Frans
>>
>>
>> Hi Frans,
>>
>> Did you ever find a solution to this issue? =A0I am having the
>> same problem with
>> my zd1211 wireless adapter. =A0I put the firmware in
>> /lib/firmware, but I'm
>> concerned that request_firmware might be looking somewhere
>> else. =A0If you were
>> able to solve it, would you mind letting me know how so I can
>> try the same fix?
>>
>
> Daniel,
>
> Have you looked at this discussion:
> http://ubuntuforums.org/showthread.php?t=3D806768
>
> Best regards,
> Sanjeev
>
>> Thanks,
>> Daniel
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>

Hi Sanjeev,

I had a look at the discussion you linked to.  I have tried putting the
firmware in several different locations: /lib/firmware/, /etc/firmware/=
,
/usr/lib/hotplug/firmware/, /lib/firmware/2.6.32-rc2-05967-gd350540/,
but nothing seems to work.  Is there a way to tell where
request_firmware is looking for the files?  Alternatively, is there a w=
ay
to manually load the firmware from a specific directory?

Thanks,
Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
