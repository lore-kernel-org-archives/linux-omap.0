From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: OMAP2+: PM/serial: hold console semaphore while OMAP UARTs are disabled
Date: Thu, 25 Nov 2010 19:38:59 +0100
Message-ID: <AANLkTi=L7COp0gxEG_ECabfa=eA7FU2W8-2zqqydV+Hi@mail.gmail.com>
References: <alpine.DEB.2.00.1011241646310.20215@utopia.booyaka.com>
	<AANLkTina+O1GgMgS0qDKix=d4HOtT1fFrCotTuCCxACv@mail.gmail.com>
	<alpine.DEB.2.00.1011251103480.20215@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:45595 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab0KYSjA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 13:39:00 -0500
Received: by qyk11 with SMTP id 11so6743781qyk.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Nov 2010 10:39:00 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1011251103480.20215@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, tom.leiming@gmail.com, pramod.gurav@ti.com, thomas.petazzoni@free-electrons.com, govindraj.raja@ti.com

Paul,

On Thu, Nov 25, 2010 at 7:15 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Thu, 25 Nov 2010, Jean Pihet wrote:
>
>> On Thu, Nov 25, 2010 at 12:49 AM, Paul Walmsley <paul@pwsan.com> wro=
te:
>> >
>> > The console semaphore must be held while the OMAP UART devices are
>> > disabled, lest a console write cause an ARM abort (and a kernel cr=
ash)
>> > when the underlying console device is inaccessible. =A0These crash=
es
>> > only occur when the console is on one of the OMAP internal serial
>> > ports.
>> This does not fix the issue for me on Beagle (console on ttyO2).
>>
>> Doing:
>> =A0 / # echo 5 > /sys/devices/platform/omap/omap-hsuart.0/sleep_time=
out
>> =A0 / # echo 5 > /sys/devices/platform/omap/omap-hsuart.1/sleep_time=
out
>> =A0 / # echo 5 > /sys/devices/platform/omap/omap-hsuart.2/sleep_time=
out
>> and waiting 5 seconds hangs the console.
>
> By the way, I just tried this on a Beagle 35xx rev C2, with Tony's co=
mmit
> 063d907edaf3fbf9776c189c3e02f2c7a129d18c, and did not see any hang. =A0=
 Are
> you using a linux-omap kernel?
Yes this is using l-o master on Beagle B5.

>
>
> - Paul

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
