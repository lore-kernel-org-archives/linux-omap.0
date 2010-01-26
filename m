From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: USB lockup on OMAP3530
Date: Tue, 26 Jan 2010 17:13:48 -0600
Message-ID: <4551feaf1001261513vf8ba655ua1c050a28f1d57eb@mail.gmail.com>
References: <f3642e6b1001261430n32d55can502931fc93271f67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:33256 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab0AZXNu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 18:13:50 -0500
Received: by ewy19 with SMTP id 19so1594089ewy.21
        for <linux-omap@vger.kernel.org>; Tue, 26 Jan 2010 15:13:48 -0800 (PST)
In-Reply-To: <f3642e6b1001261430n32d55can502931fc93271f67@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Hartmetz <ahartmetz@gmail.com>
Cc: linux-omap@vger.kernel.org

On Tue, Jan 26, 2010 at 4:30 PM, Andreas Hartmetz <ahartmetz@gmail.com>=
 wrote:
> Hi,
>
> I have a problem with the USB OTG port on my Beagle Board revision B6=
 - the OTG
> port is the only USB port on that device so it's critical that it wor=
ks.
> Everybody on this list probably knows this hardware, I'll just say th=
at it has
> an ARM Cortex-A8 CPU (OMAP3530) with a built-in USB interface. The dr=
iver is
> musb_hdrc.
> I'm using this interface in host mode (no gadget mode support compile=
d in,
> though this doesn't seem to make a difference) to attach necessary pe=
ripherals
> via a powered USB hub. The make and model of hub do not play a role, =
I've tried
> several.
>
> The problem:
> Whenever the following conditions are met all hardware on the port "d=
isappears"
> after a few minutes, cutting off the board from network and storage:
> - Network traffic over USB (doesn't matter if it's regular 100 Mbps E=
thernet
> =A0or a WLAN stick)
> - Disk "traffic" over USB - I use a 2,5" disk in a USB enclosure
> - CPU load - not sure if this is necessary
> The only fix seems to be a reboot.
>
> This happens to me when compiling something on the board (easier than
> cross-compiling) with the help of Icecream, which is a kind of distcc=
 on
> steroids. On #beagle on Freenode IRC I've found somebody with the sam=
e problem
> when scp-ing a large file (several hundred megabytes) off or onto the=
 USB disk.
> I can reproduce that as well.
> I have spent a lot of time trying to find fixes and/or workarounds bu=
t nothing
> worked so far except using the "validation kernel" recommended to tes=
t the
> hardware e.g. after receipt:
> http://code.google.com/p/beagleboard/wiki/BeagleBoardDiagnostics.
> Fittingly, the link to the kernel image is currently broken. The boar=
d usually
> locked itself up after about a day when using that ancient kernel, so=
 it's not
> an option either, and probably quite unmaintained and buggy in many o=
ther areas.
>
> So far I have tried many versions of the linux-omap and linux-omap-pm=
 kernel,
> from about 2.6.30 to the latest git version. They all exhibit the USB=
 OTG death
> bug.
> I've used kernels with openembedded patches and without, currently wi=
thout.
> Yesterday I discovered the musb_hdrc.fifo_mode parameter and played a=
round
> with it. I also modified the given configurations. Result:
> - FIFO configurations including .mode =3D BUF_DOUBLE don't work at al=
l - no
> =A0devices work.
> - the USB death bug is not fixed by:
> =A0- using only one endpoint
> =A0- using no TXRX entries but only separate RX and TX
> =A0 =A0(every endpoint gets a TX and an RX entry though)
> =A0- using a large number of endpoints with same maxpacket value
> ... still no solution.
>
> Enabling debug output of the musb_hdrc driver (yes I've also compiled=
 in debug
> messages) is not very practical due to the high volume of messages; a=
lso, when
> the bug occurs nothing special is printed. The first error usually co=
mes from
> the memory manager / filesystem complaining that it can't do "IO to o=
ffline
> device", i.e. the disappeared external harddisk (which contains the s=
wapfile).
>
> I would *really* appreciate somebody looking into this because this c=
urrently
> makes the hardware as useful as a brick for me. I can supply debug ou=
tput and
> test patches.
>
> Cheers,
> Andreas

Hi Andreas,

Give this patch a try:
http://bazaar.launchpad.net/~beagleboard-kernel/%2Bjunk/2.6-stable/anno=
tate/head%3A/patches/musb/fifo-change.patch

It's in Angstrom's 2.6.29, my 2.6.31/32... And a real fix just went
into mainline 2.6.33-rc5, with it my otg port is solid as a rock and
can transfer large amounts of data between shared devices on the
otg/musb port...

http://rcn-ee.homeip.net:81/dl/farm/log/2.6.32.6-x6.0_beagle-128mb-0_mu=
sb-stress-test.txt

Regards,

--=20
Robert Nelson
http://www.rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
