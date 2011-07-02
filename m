From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCHv4 7/9] OMAP: hwmod: enable / disable pad wakeups for a
 module dynamically
Date: Sat, 2 Jul 2011 16:40:34 +0530
Message-ID: <CAAL8m4wsbzf3uYaocUKyL1X54Sd4ASUU10v6Mwe=Rifa+Tvmyg@mail.gmail.com>
References: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
 <1309338303-2086-8-git-send-email-t-kristo@ti.com> <87mxgxsl06.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48203 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754332Ab1GBLKz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Jul 2011 07:10:55 -0400
Received: by bwd5 with SMTP id 5so3153489bwd.19
        for <linux-omap@vger.kernel.org>; Sat, 02 Jul 2011 04:10:54 -0700 (PDT)
In-Reply-To: <87mxgxsl06.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On Sat, Jul 2, 2011 at 3:48 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tero Kristo <t-kristo@ti.com> writes:
>
>> PRCM chain interrupt registration is done now as part of
>> omap_hwmod_enable_wakeup() and omap_hwmod_disable_wakeup() calls. Th=
is
>> allows module ISR:s to be called when the module is idle but an IO_P=
AD
>> event is detected on the module input pads.
>
> These functions are the enable/disable for module-level wakeups, you
> need to use the proposed enable/disable functions for IO ring wakeups=
 as
> proposed in the patch from Govindraj[1].
>


Posted a new version rebased on 3.0-rc5

https://patchwork.kernel.org/patch/940332/
https://patchwork.kernel.org/patch/940322/

--
Thanks,
Govindraj.R


> I'm hoping that patch will be queued for v3.1, but will wait for Paul=
's
> comments on that patch.
>
> Kevin
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
