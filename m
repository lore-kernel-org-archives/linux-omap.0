From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: Driver Merge Questions
Date: Mon, 9 Nov 2009 14:07:51 +0200
Message-ID: <37786d4b0911090407w19d7f054n3203df2eccac32ba@mail.gmail.com>
References: <4AF040D1.7020109@kionix.com> <20091103165821.GG8981@atomide.com>
	 <20091109092621.GY1773@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:58052 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbZKIMHr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2009 07:07:47 -0500
Received: by ewy3 with SMTP id 3so3021960ewy.37
        for <linux-omap@vger.kernel.org>; Mon, 09 Nov 2009 04:07:51 -0800 (PST)
In-Reply-To: <20091109092621.GY1773@smtp.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chris Hudson <chudson@kionix.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Nov 9, 2009 at 11:26 AM, Amit Kucheria
<amit.kucheria@verdurent.com> wrote:
> On 09 Nov 03, Tony Lindgren wrote:
>> * Chris Hudson <chudson@kionix.com> [091103 06:48]:
>> > Hello all,
>> >
>> > I've never submitted any software to Linux before, but I've been
>> > working on some new accelerometer drivers that should be ready for
>> > review soon (pending company approval). =A0I've read lots of
>> > documentation on patch and driver submissions, but I still have so=
me
>> > questions that I was hoping someone could help me find the answers
>> > to.
>> >
>> > 1- My drivers use i2c for hardware communications, miscdevice for
>> > IOCTLs, and input_dev for data and interrupt status outputs. =A0Mo=
st
>> > of the other accelerometer drivers that I've looked at use similar
>> > designs and are located in drivers/hwmon, but I just wanted to
>> > confirm that this is the correct location currently.
>>
>> Sounds correct.
>
> Unfortunately it will probably get rejected in drivers/hwmon. The mai=
ntainer,
> Jean Delavare wants them out of hwmon[1]. It seems that everyone (for=
 the

s/Delavare/Delvare
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
