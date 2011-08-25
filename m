From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: 3.1-rc3 fails to boot on my pandaboard
Date: Thu, 25 Aug 2011 17:05:10 +0530
Message-ID: <CAAL8m4whQJSXQw+E52qF2vLSBrt=RsA-r-B2q2gaW3XGiR4tYg@mail.gmail.com>
References: <1314268769.2296.283.camel@cumari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48227 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365Ab1HYLfb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Aug 2011 07:35:31 -0400
In-Reply-To: <1314268769.2296.283.camel@cumari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On Thu, Aug 25, 2011 at 4:09 PM, Luciano Coelho <coelho@ti.com> wrote:
> Hi,
>
> There seems to be a problem with 3.1-rc3, which prevents it from boot=
ing
> on my PandaBoard (ARM OMAP4).
>
> 3.1-rc2 works fine, so I have bisected the problem and it turns out t=
o
> be caused by this:
>
> commit f3637a5f2e2eb391ff5757bc83fb5de8f9726464
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date: =A0 Thu Jul 7 22:32:17 2011 +0200
>
> =A0 =A0irq: Always set IRQF_ONESHOT if no primary handler is specifie=
d
>
> After reverting this commit, -rc3 boots fine. =A0I'm not sure where
> exactly the problem is. =A0Maybe it's something in the omap code whic=
h is
> broken and this patch causes the bug to show up?
>
> What happens is that the booting process hangs after printing out thi=
s:
>

fyi,

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=3D69dd3d8e29e294caaf63eb5e8a72d250279f9e5f;hp=3Dfcb8ce5cfe=
30ca9ca5c9a79cdfe26d1993e65e0c

--
Thanks,
Govindraj.R


> [...]
> [ =A0 =A07.408477] EXT3-fs: barriers not enabled
> [ =A0 =A07.415008] kjournald starting. =A0Commit interval 5 seconds
> [ =A0 =A07.446228] EXT3-fs (mmcblk0p5): using internal journal
> [ =A0 =A07.452087] EXT3-fs (mmcblk0p5): mounted filesystem with order=
ed data mode
> [ =A0 =A07.459625] VFS: Mounted root (ext3 filesystem) on device 179:=
5.
> [ =A0 =A07.466094] Freeing init memory: 312K
> [ =A0 =A07.471710] Failed to execute /init. =A0Attempting defaults...
> [ =A0 10.254333] EXT3-fs (mmcblk0p5): using internal journal
>
> The full boot logs can be found here:
>
> http://pastebin.pandaboard.org/index.php/view/88995306
>
> Any ideas what may be going wrong?
>
> --
> Cheers,
> Luca.
>
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
