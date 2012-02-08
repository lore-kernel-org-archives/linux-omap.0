From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: OMAP34xx
Date: Wed, 8 Feb 2012 19:23:34 +0200
Message-ID: <CANOLnOOTKwtNjWZWXEqsNVy20s8QLwK=2UKGMp8S_Zj6qZH9dg@mail.gmail.com>
References: <20120204203453.GD17309@n2100.arm.linux.org.uk>
	<20120205012556.GG1426@atomide.com>
	<20120205125904.GB11372@n2100.arm.linux.org.uk>
	<20120205172925.GS20333@atomide.com>
	<20120205175809.GF17309@n2100.arm.linux.org.uk>
	<20120205182910.GK1426@atomide.com>
	<87lioegtk9.fsf@ti.com>
	<87y5sei1qz.fsf@ti.com>
	<CANOLnOMXdgBv_aGeK7ngD-d07QLRTR22iqD-4571LAuN0PV1FQ@mail.gmail.com>
	<87k43xfee3.fsf@ti.com>
	<20120208170653.GA3492@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61597 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab2BHRXf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 12:23:35 -0500
Received: by ggnh1 with SMTP id h1so365380ggn.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 09:23:35 -0800 (PST)
In-Reply-To: <20120208170653.GA3492@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Wed, Feb 8, 2012 at 7:06 PM, Greg KH <gregkh@linuxfoundation.org> wr=
ote:
> On Wed, Feb 08, 2012 at 09:01:24AM -0800, Kevin Hilman wrote:
>> Grazvydas Ignotas <notasas@gmail.com> writes:
>>
>> > On Wed, Feb 8, 2012 at 2:53 AM, Kevin Hilman <khilman@ti.com> wrot=
e:
>> >> Kevin Hilman <khilman@ti.com> writes:
>> >>
>> >>> This one is indeed strange. =C2=A0I have not seen this on the 34=
xx devices
>> >>> I'm using (3430/n900, 3530/Overo, 3630/Zoom3).
>> >>
>> >> OK, I've reproduced this on v3.3-rc2.
>> >>
>> >> The reason I wasn't seeing this is because I'm using the fixes Pa=
ul has
>> >> already posted that fix this problem:
>> >>
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0http://marc.info/?l=3Dlinux-arm-kernel=
&m=3D132754676814391&w=3D2
>> >>
>> >> Kevin
>> >
>> > But it looks like these are now queued for 3.4 in tty tree?
>>
>> I believe they were targettted for 3.3-rc.
>>
>> Paul, Greg, can you confirm?
>
> I have no idea what you are refering to here, please be much more
> specific. =C2=A0You can look at the linux-next tree to answer your qu=
estion
> yourself as well...

It's about these patches in gregkh/tty.git tty-next:
6bbcbf2 tty: serial: omap-serial: wakeup latency constraint is in
microseconds, not milliseconds
edbe5db tty: serial: OMAP: block idle while the UART is transferring
data in PIO mode
5816269 tty: serial: OMAP: use a 1-byte RX FIFO threshold in PIO mode

It would look to me like they are queued for 3.4 but Kevin says there
were intended for 3.3-rc.

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
