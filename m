From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: problem with "undefined instruction"
Date: Sat, 30 Apr 2011 22:12:46 +0530
Message-ID: <4DBC3C06.9010306@ti.com>
References: <20110430162357.GA14287@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:38712 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755497Ab1D3QnR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 30 Apr 2011 12:43:17 -0400
Received: by gxk2 with SMTP id 2so2309443gxk.22
        for <linux-omap@vger.kernel.org>; Sat, 30 Apr 2011 09:43:15 -0700 (PDT)
In-Reply-To: <20110430162357.GA14287@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: linux-omap@vger.kernel.org

On 4/30/2011 9:53 PM, Sebastian Reichel wrote:
> Hi,
>
> I'm currently trying to get a mainline based kernel running on my pandaboard.
> The problem is, that it's crashing very early during the init phase because of
> "undefined instruction" exceptions:
>
> [    1.867980] udevd (56): undefined instruction: pc=401e6ed4
> [    1.874603] Code: 9cd0 fffe e92d 4ff0 (ed2d)
> [    1.977752] modprobe (69): undefined instruction: pc=400c6ed4
> [    1.977783] Code: 9cd0 fffe e92d 4ff0 (ed2d)
> [    1.978240] init (1): undefined instruction: pc=40149ed4
> [    1.978240] Code: 9cd0 fffe e92d 4ff0 (ed2d)
> [    2.005706] Kernel panic - not syncing: Attempted to kill init!
>
> Exactly the same userland boots fine with the original 2.6.35 kernel, so it's
> probably not the userland's fault. But I searched for the byte combination
> anyway and found it in libc.so:
>
>     32ecc:   9cd0        ldr r4, [sp, #832]  ; 0x340
>     32ece:   fffe e92d   vtbl.8  d30, {d14-d15}, d29
>
> 00032ed0<_IO_vfprintf>:
>     32ed0:   e92d 4ff0   stmdb   sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
>     32ed4:   ed2d 8b02   vpush   {d8}
>

Looks like NEON instructions are taking an exception. Can you disable
VFP, NEON and give a one more shot.

> Can you please tell me what's missing in my kernel? I uploaded
> .config and full boot messages here:
>
Config seems to enable needed NEON/VFP options.


Regards
Santosh
