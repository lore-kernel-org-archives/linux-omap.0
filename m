From: Vaibhav Bedia <vaibhav.bedia@gmail.com>
Subject: Re: [PATCHv3 8/9] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Fri, 30 Aug 2013 13:39:21 -0400
Message-ID: <CANacCWwNp4yg0e_9HPJCGJgQkaYP1n=b6Kjmw9KYjp6HoOY0og@mail.gmail.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<1375811376-49985-9-git-send-email-d-gerlach@ti.com>
	<87mwo2vmds.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:51344 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756154Ab3H3RjX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Aug 2013 13:39:23 -0400
Received: by mail-lb0-f171.google.com with SMTP id u14so2145020lbd.30
        for <linux-omap@vger.kernel.org>; Fri, 30 Aug 2013 10:39:21 -0700 (PDT)
In-Reply-To: <87mwo2vmds.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Dave Gerlach <d-gerlach@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lingren <tony@atomide.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <benoit.cousson@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Tue, Aug 27, 2013 at 5:45 PM, Kevin Hilman <khilman@linaro.org> wrote:
[...]
>
> Looking closer at this code as I'm trying to fully get my head around
> all the IPC, I have some more comments.
>
> I think the split between pm33xx.c and the M3 driver is still confusing
> here.  For example, am33xx_ping_wkup_m3(),
> am33xx_m3_state_machine_reset() and the guts of am33xx_pm_begin() all
> belong inside the M3 driver, along with all the wakeup_src stuff, which
> is info coming from the M3.
>
> IOW, the communication with M3 should be abstracted from pm33xx by the
> M3 driver (or possibly an eventual remoteproc/rpmsg implementation) with
> a well defined API.  In this implementation, the interface is pretty
> fuzzy and mixed between pm33xx.c and wkup_m3.c.
>
>

The reason for the current split was to have the M3 driver just do the minimal
that's needed to talk to get M3 and MPU talking. What made me do it this way
was to attempt to address a previous comment on keeping options open for folks
to use M3 for things other than PM stuff. The IPC stuff is how
implementors of the
firmware (anything other than the PM one that TI provides) want it to be.

The top level idea was to have the users of the firmware (PM in this case)
decide what functionality they want when talking to M3. They are also free to
decide the register bitfield layout and other IPC details.

This was also a feeble attempt to keep things extensible for AM437x where
in addition to the broken mailbox usage there's now a control module bit
to trigger the interrupt to M3 (what's worse? pick one that you hate more ;)
The AM437x PM routines could then just register different callbacks that
are triggered when the M3 interrupts the MPU.

Hope this clears up some of the confusion.

Regards,
Vaibhav
