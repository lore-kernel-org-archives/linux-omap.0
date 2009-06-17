From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: OMAP3 PM: off-mode during idle, problem with UART1 console
Date: Wed, 17 Jun 2009 09:38:42 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038E2AC031@dlee02.ent.ti.com>
References: <87iqiv28ld.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0305A53FBA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44220 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588AbZFQOir convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 10:38:47 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0305A53FBA@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin,

Can you ping the system via network during on time?
        - generate some activity on uart to be awake then try.

Why not fire up a second tty/shell on UART3 or just try with uart 3 on SDP.  Bootargs change is easy enough.
        - this can say if you have uart specific issue or maybe core vs per

Did you hook up your emulator and connect during awake time of uart timer?  It should really tell a lot.

Regards,
Richard W.

> -----Original Message-----
> From: Nayak, Rajendra
> Sent: Wednesday, June 17, 2009 1:12 AM
> To: Kevin Hilman; Woodruff, Richard
> Cc: linux-omap@vger.kernel.org
> Subject: RE: OMAP3 PM: off-mode during idle, problem with UART1 console
>
> Kevin,
>
> What Silicon Rev does your SDP have? I currently am using an ES3.1 based SDP
> and I havent seen any of these issues you have reported with off-while-idle.
>
> Infact I have kept the board running overnight a couple times in the last week
> with off-while-idle and voltage scaling to 0v enabled, mainly to test the
> recent
> patch set (disabling Auto idle for PER in scratchpad memory) for stability.
>
> I will see if I can get hold of an ES3 and ES2.1 based SDP's and see if I
> reproduce
> the issue. Besides I use nfs and I am not sure if that's got something to do
> with it.
> Will try a ramdisk also.
>
> Does it take you a while to reproduce this, or is it seen after the very first
> UART
> inactivity?
>
> regards,
> Rajendra
>
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org
> >[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> >Sent: Wednesday, June 17, 2009 2:35 AM
> >To: Nayak, Rajendra; Woodruff, Richard
> >Cc: linux-omap@vger.kernel.org
> >Subject: OMAP3 PM: off-mode during idle, problem with UART1 console
> >
> >Rajendra, Richard,
> >
> >Hoping you can shed some light, or give me some direction on where to
> >debug this further...
> >
> >With the latest PM branch, I've notice that off-while idle isn't
> >working on the SDP, but the same kernel works fine on the RX51.
> >RET-while-idle works fine on both.  This is with CPUidle disabled, so
> >just using the default idle where MPU and CORE are changed together.
> >
> >More specifically, it seems to be the UART1 (CORE) console that never
> >comes back from off-while-idle, but the UART3 (PER) console on RX51
> >works.
> >
> >On SDP, if I
> >
> ># echo 1 > /sys/power/enable_off_mode
> ># echo 1 > /sys/power/voltage_off_while_idle
> ># echo 1 > /sys/power/sleep_while_idle
> >
> >After the UART inactivty timeout of 5 seconds, I start to see the
> >sys_off_mode LED toggling between red and green with system timer
> >wakeups.
> >
> >If I then push a key on the UART1 console, the LED goes green, stays
> >for the 5 second UART inactivity and then goes back to toggling
> >red/green again.  However, I never get my console back and never see
> >the characters on my console.
> >
> >If I keep typing, I keep the system from going back off (based on
> >sys_off_mode LED) and as soon as I stop typing long enough for the
> >inactivity timer to expiere (5 seconds) it goes back into off.
> >
> >Any ideas what's going on here?
> >
> >On RX51, the same thing works using UART3.
> >
> >Kevin
> >
> >--
> >To unsubscribe from this list: send the line "unsubscribe
> >linux-omap" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
