From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: Suspend broken on 3.3?
Date: Wed, 4 Apr 2012 21:43:10 +0530
Message-ID: <CAMrsUd+WZcUvHGdR4WyF4uh35D17K9DXFAqpLHKBUbL1_5viDA@mail.gmail.com>
References: <WC20120329112755.541787@terrafix.co.uk> <WC20120329114024.43178C@terrafix.co.uk>
 <CAMrsUdKR4nwbBEOx9JPeS=GLDPyioHuijK2596=q2OwJ+ARbxA@mail.gmail.com>
 <WC20120330075339.4017FC@terrafix.co.uk> <CAMrsUdKTx84_oHyS9JTCBTqtV-7907snCGFDrOXnPuNVSnvz7w@mail.gmail.com>
 <WC20120330092609.901834@terrafix.co.uk> <CAMrsUdJrJZXjYOs87xmT_J0w7S=VZyfR0tBmhhuYOFmFsOB3SA@mail.gmail.com>
 <WC20120330110442.381887@terrafix.co.uk> <CAMrsUd+AvVp3n1oAREEEmCSBaeA-m68j7gLjXEeJKimX1erfUw@mail.gmail.com>
 <CAMrsUd+K_EwXfypgYWNyAhR7b47avTpWDemS87OTkpH81cJ6Aw@mail.gmail.com> <alpine.DEB.2.00.1204040852460.8000@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:57718 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756837Ab2DDQNc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Apr 2012 12:13:32 -0400
Received: by ggnk4 with SMTP id k4so287301ggn.41
        for <linux-omap@vger.kernel.org>; Wed, 04 Apr 2012 09:13:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1204040852460.8000@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de

On Wed, Apr 4, 2012 at 8:26 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Govindraj
>
> On Mon, 2 Apr 2012, Raja, Govindraj wrote:
>
>> As of now what I can think of is to update qos reqest to prevent MPU
>> from transitioning in case of port activity if wakeup capability for port
>> is disabled.
>
> Haven't been following this thread closely, but this doesn't seem right.
> Why would changing the UART driver's ability to wake from suspend via the
> sysfs file prevent the driver from using hardware wakeups to wake from
> dynamic idle?


IIUC wakeup capability is needed in suspend path or in cpu idle path.

once uart wakeup capability is disabled from sysfs the Module level wakeup
from PM_WKEN1 reg on omap3 and pad wakeup from pin mux data given
will be disabled..

So after we enter suspend and wakeup from suspend using keypad press,
now through pm workqueue the MPU enters retention and uart module level
wakeups disabled at this point console becomes slower to respond.

Now enabling wakeups from sysfs enter suspend/resume to enable wakeups
and once we come back from wakeup console response is better.

So disabling uart module level wake up and allowing MPU to enter retention
is making console slow.

--
Thanks,
Govindraj.R
