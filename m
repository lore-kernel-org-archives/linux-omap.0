From: Steve Calfee <stevecalfee@gmail.com>
Subject: Re: [RFC][PATCH 3/9] OMAP4460: HWMOD: DO not reset GPIO1 during HWMOD init
Date: Sun, 29 May 2011 14:04:29 -0700
Message-ID: <BANLkTi==jZV13S1tzuRbWuoJytCZCBeWQg@mail.gmail.com>
References: <1306375016-707-1-git-send-email-nm@ti.com>
	<1306375016-707-4-git-send-email-nm@ti.com>
	<87oc2p82q0.fsf@ti.com>
	<4DDF4E4D.6060008@ti.com>
	<87oc2ox7bm.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65004 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153Ab1E2VEb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 May 2011 17:04:31 -0400
Received: by fxm17 with SMTP id 17so2145826fxm.19
        for <linux-omap@vger.kernel.org>; Sun, 29 May 2011 14:04:29 -0700 (PDT)
In-Reply-To: <87oc2ox7bm.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Sonasath, Moiz" <m-sonasath@ti.com>

On Fri, May 27, 2011 at 12:38 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Cousson, Benoit" <b-cousson@ti.com> writes:
>
> [...]
>
>> In general we do not want to reset nor idle an IP that was potential=
ly
>> already properly configured by bootloader or early Linux boot code.
>
> Actually, the opposite is true.
>
> The kernel should not make any assumptions about what the bootloader =
has
> or has not done. =C2=A0We need to have a kernel that can boot from an=
y
> bootloader (or none, like using kexec) and be able to start from a kn=
own
> hardware state.
>
YES. Bootloaders should only do what is necessary (set clocks, enable
memories etc) to load the next stage. Pushing stuff that should be in
the kernel into the bootloader (like iniiting gpios and other things)
bloats it and makes a developer deal with two entirely different
source trees (kernel and booterx) to enable a new feature or to fix
bugs.

Uboot tends to lag the kernel in capabilities too, probably because
fewer developers or something. For instance Beagleboard xm uboot
cannot access the ethernet because it is usb based, and uboot cannot
access its own environment in flash - because it is running from a new
microsd based flash system. U-boot will eventually catch up with
these, but by then other new hardware will be available.

Does anyone know if 2.6.39 has kexec working again for the kernel? NFS
boot is a dream development environment but with both u-boot and kexec
not working with nfs, it is slightly more work and less automated.

Regards, Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
