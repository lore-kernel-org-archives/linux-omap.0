From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Warnings: pm branch
Date: Tue, 11 Aug 2009 08:27:16 -0700
Message-ID: <873a7y74mj.fsf@deeprootsystems.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702F5989815@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:55131 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbZHKP1S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 11:27:18 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1411193wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 11 Aug 2009 08:27:19 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F5989815@dbde02.ent.ti.com> (Vikram Pandita's message of "Tue\, 11 Aug 2009 20\:25\:17 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Pandita, Vikram" <vikram.pandita@ti.com> writes:

> Has anyone send these warning logs on the pm branch on kevin's tree [1] 
> This seems to be some issue in CpuIdle path with interrupts? 
>
> <4>WARNING: at arch/arm/kernel/process.c:171 cpu_idle+0x60/0x88()
> WARNING: at arch/arm/kernel/process.c:171 cpu_idle+0x60/0x88()
> <d>Modules linked in:Modules linked in:
> [<c0031344>] [<c0031344>] (unwind_backtrace+0x0/0xdc) (unwind_backtrace+0x0/0xdc
> ) from [<c0057a08>] from [<c0057a08>] (warn_slowpath_common+0x48/0x60)
> (warn_slowpath_common+0x48/0x60)
> [<c0057a08>] [<c0057a08>] (warn_slowpath_common+0x48/0x60) (warn_slowpath_common
> +0x48/0x60) from [<c002d204>] from [<c002d204>] (cpu_idle+0x60/0x88)
> (cpu_idle+0x60/0x88)
> [<c002d204>] [<c002d204>] (cpu_idle+0x60/0x88) (cpu_idle+0x60/0x88) from [<c0008
> a70>] from [<c0008a70>] (start_kernel+0x234/0x28c)
> (start_kernel+0x234/0x28c)
> [<c0008a70>] [<c0008a70>] (start_kernel+0x234/0x28c) (start_kernel+0x234/0x28c)
> from [<80008034>] from [<80008034>] (0x80008034)
> (0x80008034)
>

Yes, I've seen it, but have yet to debug it.

This warning is from the generic ARM idle loop reporting that the OMAP
idle path is returning with IRQs disabled.

Kevin
