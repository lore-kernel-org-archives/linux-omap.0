From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: BeagleBoard not resuming from uart with latest pm-core ?
Date: Wed, 10 Nov 2010 09:32:53 -0800
Message-ID: <87pqudaxtm.fsf@deeprootsystems.com>
References: <20101110164414.4529cbda@surf>
	<AANLkTi=Dzv2XE-X_z6yiCaRjgWrST5QGDE9dFDnDy9pT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47370 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab0KJRc5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 12:32:57 -0500
Received: by ywh2 with SMTP id 2so57470ywh.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Nov 2010 09:32:57 -0800 (PST)
In-Reply-To: <AANLkTi=Dzv2XE-X_z6yiCaRjgWrST5QGDE9dFDnDy9pT@mail.gmail.com>
	(Jean Pihet's message of "Wed, 10 Nov 2010 17:07:08 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-omap@vger.kernel.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> l-o is currently broken wrt to suspend and idle.
> Solutions are being worked on for the moment.
>
> Kevin, are there solutions available yet?

The solution to your previous problem (ensuring runtime PM transitions
work during system PM) is included in my pm-core branch, but is not yet
the final solution.  I've been disussing this issue with the runtime PM
maintainers for a final solution.  Until then, I will carry this in
pm-core.

The other problem that I'm aware of so far I've only seen on boards wit=
h
UART2 console (beagle, Overo, n900.)  The printk messages that warn of
'new worst case [de]activate latency" seem to be racing with UART
disable code.  This makes sense, since this printk is printed to the
UART immediately after the UART is disabled, which is going to cause
problems with the current approach to UART pm we have in
mach-omap2/serial.c.   I have not yet fully debugged this and found a
workaround.=20

Of course, any help debugging these problems is appreciated.  I will no=
t
get to debugging this until I catch up on the mailing list backlog.

Kevin


> On Wed, Nov 10, 2010 at 4:44 PM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
>> Hello,
>>
>> I've updated my tree to the last pm-core branch today (I'm at commit
>> 42289e226ec996a13ab8a2aaef5ad9dda61ee57e), and I've built the
>> omap2plus_defconfig with no change (except adding an initramfs). On =
my
>> BeagleBoard, I enable the wakeup from UART
>> in /sys/devices/platform/omap/omap-hsuart.2/tty/ttyO2/power/wakeup,
>> then trigger suspend to RAM. It enters suspend to RAM, but then
>> it doesn't wakeup when I send data through the UART.
>>
>> Is it a known problem, or is again a mistake on my side ?
>>
>> Thanks,
>>
>> Thomas
>> --
>> Thomas Petazzoni, Free Electrons
>> Kernel, drivers, real-time and embedded Linux
>> development, consulting, training and support.
>> http://free-electrons.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
