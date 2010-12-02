From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: OMAP2+: PM/serial: hold console semaphore while OMAP UARTs are disabled
Date: Thu, 2 Dec 2010 16:12:53 +0100
Message-ID: <AANLkTi=hiwspQ4hM0Ok+MHjn5iHme4XRTKZPGa0Z2=Xy@mail.gmail.com>
References: <alpine.DEB.2.00.1011241646310.20215@utopia.booyaka.com>
	<AANLkTina+O1GgMgS0qDKix=d4HOtT1fFrCotTuCCxACv@mail.gmail.com>
	<alpine.DEB.2.00.1011251017390.20215@utopia.booyaka.com>
	<AANLkTik5cRQPodAYtacTD5EdQYnDbvGgOoNfNfHuW+fq@mail.gmail.com>
	<alpine.DEB.2.00.1012020022390.2515@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61021 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757762Ab0LBPMz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 10:12:55 -0500
Received: by gxk1 with SMTP id 1so1196001gxk.19
        for <linux-omap@vger.kernel.org>; Thu, 02 Dec 2010 07:12:54 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1012020022390.2515@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, tom.leiming@gmail.com, pramod.gurav@ti.com, thomas.petazzoni@free-electrons.com, govindraj.raja@ti.com

Hello Paul,

On Thu, Dec 2, 2010 at 8:23 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Jean
>
> On Thu, 25 Nov 2010, Jean Pihet wrote:
>
>> On Thu, Nov 25, 2010 at 6:35 PM, Paul Walmsley <paul@pwsan.com> wrot=
e:
>> > On Thu, 25 Nov 2010, Jean Pihet wrote:
>> >> On Thu, Nov 25, 2010 at 12:49 AM, Paul Walmsley <paul@pwsan.com> =
wrote:
>> >> >
>> >> > The console semaphore must be held while the OMAP UART devices =
are
>> >> > disabled, lest a console write cause an ARM abort (and a kernel=
 crash)
>> >> > when the underlying console device is inaccessible. =A0These cr=
ashes
>> >> > only occur when the console is on one of the OMAP internal seri=
al
>> >> > ports.
>> >> This does not fix the issue for me on Beagle (console on ttyO2).
>> >>
>> >> Doing:
>> >> =A0 / # echo 5 > /sys/devices/platform/omap/omap-hsuart.0/sleep_t=
imeout
>> >> =A0 / # echo 5 > /sys/devices/platform/omap/omap-hsuart.1/sleep_t=
imeout
>> >> =A0 / # echo 5 > /sys/devices/platform/omap/omap-hsuart.2/sleep_t=
imeout
>> >> and waiting 5 seconds hangs the console.
>> >
>> > By the way, you write that the above situation "hangs the console.=
" =A0Is it
>> > just the case that the console dies and the rest of the system is =
still
>> > alive, or does the whole system crash?
>> The console hangs, the rest of the system still runs.
>
> Just out of curiosity, if you send a few breaks to the OMAP over seri=
al,
> does that cause the console to pay attention again? =A0CTRL-A F in mi=
nicom.
Yes it helps. In most cases sending 2-3 breaks resumes the UART console=
=2E

>
> - Paul

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
