From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: BeagleBoard not resuming from uart with latest pm-core ?
Date: Mon, 15 Nov 2010 19:24:05 +0530
Message-ID: <AANLkTi=PGuYZAPO7nxko=A1PgJMMnB5Wxk86scvs1TPe@mail.gmail.com>
References: <20101110164414.4529cbda@surf>
	<AANLkTi=Dzv2XE-X_z6yiCaRjgWrST5QGDE9dFDnDy9pT@mail.gmail.com>
	<87pqudaxtm.fsf@deeprootsystems.com>
	<20101115115005.30b35e75@surf>
	<20101115141306.1ff68beb@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41690 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755520Ab0KONyH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 08:54:07 -0500
Received: by wwa36 with SMTP id 36so52540wwa.1
        for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 05:54:06 -0800 (PST)
In-Reply-To: <20101115141306.1ff68beb@surf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org

On Mon, Nov 15, 2010 at 6:43 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> On Mon, 15 Nov 2010 11:50:05 +0100
> Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
>
>> # echo enabled > /sys/class/tty/ttyO2/power/wakeup
>> # echo mem > /sys/power/state
>> [ =A0227.685028] PM: Syncing filesystems ... done.
>> [ =A0227.699432] Freezing user space processes ... (elapsed 0.01 sec=
onds) done.
>> [ =A0227.725524] Freezing remaining freezable tasks ... (elapsed 0.0=
2 seconds) done.
>> [ =A0227.880706] PM: suspend of devices complete after 117.767 msecs
>> [ =A0227.889160] PM: late suspend of devices complete after 2.136 ms=
ecs
>> [ =A0227.895782] Disabling non-boot CPUs ...
>>
>> Any idea ?
>
> Removing "no_console_suspend" from my bootargs made it work. However,
> it was previously working with no_console_suspend, and that was very
> useful since I need to debug things happening fairly early in the
> resume procedure. Any clue on how to make "no_console_suspend" work
> again ?
>

Can you check if you have below two patches in the kernel you have?

http://www.spinics.net/lists/linux-serial/msg02684.html
http://www.spinics.net/lists/linux-serial/msg02683.html

If not there can you check applying these two patch

--
Regards,
Govindraj.R




> Regards,
>
> Thomas
> --
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
