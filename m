From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv2 17/19] ARM: OMAP4: put cpu1 back to sleep if no wake request
Date: Wed, 30 May 2012 10:18:12 -0500
Message-ID: <CAOMWX4fnrKCMyZZ7S=vMcQ+9npiq2WDhTj=7Asyq=+B3dcMujw@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-18-git-send-email-t-kristo@ti.com> <87396z3axv.fsf@ti.com>
 <1337595695.28274.32.camel@sokoban> <CAMQu2gy0Lwga0gDhT7+iOFM6ZLPnW4Q0qo_r4=cW6L4s5fbLZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:59044 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751356Ab2E3PSl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 May 2012 11:18:41 -0400
Received: by wibhj8 with SMTP id hj8so3966843wib.1
        for <linux-omap@vger.kernel.org>; Wed, 30 May 2012 08:18:38 -0700 (PDT)
In-Reply-To: <CAMQu2gy0Lwga0gDhT7+iOFM6ZLPnW4Q0qo_r4=cW6L4s5fbLZw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: t-kristo@ti.com, Kevin Hilman <khilman@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, May 21, 2012 at 5:40 AM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
>
>>>
> Not sure what you mean wakeup issue on GP device.
>
> IIUC, the issue is:
> Wakeup from device OFF, hardware releases the reset for both CPUs,
> This is special case and applicable only for device OFF. The reason
> CPU1 needs to be hold back, because the security SW is affined with
> CPU0 which needs to be up and running for any of the ROM code APIs
> to work. Like setting up SMP bit, AUX control etc. Without CPU0 booted,
> CPU1 won't be able to execute those ROM functions and hence won't be
> able to boot properly.
>
> I think the limitation is applicable to all OMAP4 devices as well as OMAP5
> devices.
yes, the stagger of CPU1 behind CPU0 has a few factors:
HS devices with an older PPA release has a bug where caches can be
messed up and GP devices
need slightly different WA. with the older PPA, we put CPU1 back to
OFF when we detect that CPU0 is not ready for action
you can find the details and documentation in the link below:
http://git.omapzoom.org/?p=kernel/omap.git;a=blob;f=arch/arm/mach-omap2/sleep44xx.S;h=0c28def8f644e9803564bb66c8cfe8c580898978;hb=p-android-omap-3.0#l342


Regards,
Nishanth Menon
