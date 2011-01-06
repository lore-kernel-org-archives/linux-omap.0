From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] omap: wd_timer: Fix crash frm wdt_probe when!CONFIG_RUNTIME_PM
Date: Thu, 6 Jan 2011 09:27:32 +0530
Message-ID: <19b4a66bfdd4ef3e51fdb27bf43b9ce2@mail.gmail.com>
References: <1294234855-6623-1-git-send-email-santosh.shilimkar@ti.com> <20110105221839.GD8717@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:54386 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754754Ab1AFD5e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 22:57:34 -0500
Received: by gwb17 with SMTP id 17so7192012gwb.30
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 19:57:33 -0800 (PST)
In-Reply-To: <20110105221839.GD8717@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Thursday, January 06, 2011 3:49 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; Paul Walmsley; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH] omap: wd_timer: Fix crash frm wdt_probe
> when!CONFIG_RUNTIME_PM
>
> On Wed, Jan 05, 2011 at 07:10:55PM +0530, Santosh Shilimkar wrote:
> > Commit ff2516fb 'wd_timer: disable on boot via hwmod postsetup
> mechanism'
> > introduced watchdog timer state state management using
> postsetup_state.
> > This was done to allow some board files to support watchdog
> coverage
> > throughout kernel initialization and it work as intended when
> RUNTIME_PM
> > is enabled.
> >
> > With !CONFIG_RUNTIME_PM and no board is specifically requests
> watchdog
> > to remain enabled the omap_wdt_probe crashesh. This is because
> hwmod
> > in absense of runtime PM unable to turn watchdog clocks because
> it's
> > state is set to be disabled. For rest of the device, the state is
> > set as enabled in absense of RUNTIME_PM
>
> Err... wasn't this provoked by an attempt to fix the LDP issue, that
> is
> (I believe) because the boot loader enables the watchdog and pre-
> hwmod
> kernels used to disable it.  Post-hwmod kernels stopped disabling
> the
> watchdog, resulting in a few seconds booting userspace before the
> system
> resets itself.

Yes. That's managed through the shutdown part. Apart from that there
is another enhancement done in case some one wants to have WDT running
throughout the kernel boot.

Regards,
Santosh
