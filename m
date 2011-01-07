From: =?ISO-8859-1?Q?Daniel_D=EDaz?= <mrchapp@gmail.com>
Subject: Re: 4430SDP boot failure
Date: Fri, 7 Jan 2011 11:02:46 -0600
Message-ID: <AANLkTimhrFpZixb40F+WWNuRd=EaL9K1n_Y--81zopC4@mail.gmail.com>
References: <20110106205107.GI1198@n2100.arm.linux.org.uk> <20110106235203.GA14425@n2100.arm.linux.org.uk>
 <d540408e2df154cf13932e79d3a11ceb@mail.gmail.com> <20110107092800.GJ1198@n2100.arm.linux.org.uk>
 <86f60bc5418ca1d3e87db960e5e2c48f@mail.gmail.com> <729152acd9ee0c3e3e3cd505e84f8865@mail.gmail.com>
 <20110107125132.GM1198@n2100.arm.linux.org.uk> <48cbfb338be4d33a8a19e070430d015b@mail.gmail.com>
 <20110107142432.GO1198@n2100.arm.linux.org.uk> <c71399f20609c539b8c335344963253f@mail.gmail.com>
 <20110107162429.GS1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52082 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603Ab1AGRDJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 12:03:09 -0500
Received: by fxm20 with SMTP id 20so17106395fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 09:03:08 -0800 (PST)
In-Reply-To: <20110107162429.GS1198@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hello!


On Fri, Jan 7, 2011 at 10:24 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 07, 2011 at 07:56:34PM +0530, Santosh Shilimkar wrote:
>> > -----Original Message-----
>> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
>> > Sent: Friday, January 07, 2011 7:55 PM
>> > To: Santosh Shilimkar
>> > Cc: linux-omap@vger.kernel.org; Tony Lindgren
>> > Subject: Re: 4430SDP boot failure
>> >
>> > On Fri, Jan 07, 2011 at 06:39:06PM +0530, Santosh Shilimkar wrote:
>> > > Have sent you latest bootloaders and full bootlog on my ES1.0
>> > > OMAP4430SDP. 2.6.37 just boots fine for me.
>> > >
>> > > Low level debug as you reported seems to be broken though.
>> >
>> > Many thanks, the new mlo and uboot gets dhcp/tftp working nicely o=
n
>> > the board - which should ease the debugging problem as it no longe=
r
>> > requires anything but the reset button pressed to test a new kerne=
l.
>>
>> Glad to hear that.
>
> Right, next couple of problems.
>
> udev isn't creating the ttyO* nodes for whatever reason on my fs - do=
es
> anyone know what device major/minor numbers these end up with? =A0It =
seems
> they're dynamically assigned.

This is what I have:
mazi-gentoo ~ # ls -l /dev/ttyO?
crw-rw---- 1 root  uucp 247, 0 Dec 31  1999 /dev/ttyO0
crw-rw---- 1 root  uucp 247, 1 Dec 31  1999 /dev/ttyO1
crw------- 1 ddiaz tty  247, 2 Jan  7 11:02 /dev/ttyO2
crw-rw---- 1 root  uucp 247, 3 Dec 31  1999 /dev/ttyO3

Greetings!

Daniel D=EDaz
yosoy@danieldiaz.org



> There's also something fishy going on with networking (if I configure
> PNP IP, I get an IP:
>
> ks8851 spi1.0: message enable is 0
> ks8851 spi1.0: eth0: revision 0, MAC 1a:6a:b1:02:1d:90, IRQ 194
> IP-Config: Got DHCP answer from 0.0.0.0, my address is 192.168.0.144
> IP-Config: Complete:
> =A0 =A0 device=3Deth0, addr=3D192.168.0.144, mask=3D255.255.255.0, gw=
=3D192.168.0.1,
> =A0 =A0 host=3D192.168.0.144, domain=3Darm.linux.org.uk, nis-domain=3D=
(none),
> =A0 =A0 bootserver=3D0.0.0.0, rootserver=3D0.0.0.0, rootpath=3D
>
> but the board doesn't respond to that IP address. =A0Meanwhile the DH=
CP
> server shows:
>
> =A0 =A0 =A0 =A0DHCPDISCOVER from 1a:6a:b1:02:1d:90 via eth0
>
> in its log, and the ethernet address appears to be random for each bo=
ot.
> Obviously, as I can't log into the board via any means, it's nigh on
> impossible to work out what's actually going on.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
