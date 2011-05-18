From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH] omap:pm: Fix boot-time errors with debugfs disabled
Date: Wed, 18 May 2011 03:25:02 -0500
Message-ID: <BANLkTinxvCNdr7qQTWjRZ2KceSvanGQ0Sg@mail.gmail.com>
References: <1305221790-4944-1-git-send-email-premi@ti.com>
 <BANLkTim+3M3Z0C3GTtTQrb2cqk5eSAsR+w@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB593024CE66D34@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:38347 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755703Ab1ERIZX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 04:25:23 -0400
Received: by mail-ww0-f52.google.com with SMTP id 31so1729361wwb.9
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 01:25:22 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024CE66D34@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, May 12, 2011 at 14:16, Premi, Sanjeev <premi@ti.com> wrote:
[...]
>> > This patch fixes these errors by enclosing code related to debugfs
>> > in #ifdef CONFIG_DEBUG_FS..#endif.
>>
>> generic - couple of comments - I think the #defs should be isolated
>> off to headers - maybe the right approach may be to move the debugfs
>
> [sp] None of the code encapsulated here is "header" material.
> =A0 =A0 I guess you have seen the patch below.
>
>> entries off to a separate file? or pm-debug.c??
>
> [sp] I wish it was all debug code. It is "operational" code.
> =A0 =A0 Check the Kconfig in plat-omap. Smartreflex is not even expec=
ted
> =A0 =A0 to work without debugfs. Though I believe much of the data pu=
t in
> =A0 =A0 debugfs can be in local lists/structures.
>
> =A0 =A0 That was supposed to be my next set of patches - as I underst=
and
> =A0 =A0 the implementation better.
[...]
>> Could I suggest Kevin's volt cleanup series - based off _c branch if
>> there are cleanups to be done?
>
> [sp] I didn't see it updated for 5 weeks. hence used this.
> =A0 =A0 but patch should apply cleanly...


While cleaning up voltdm_c set earlier this week, I think your changes
apply better there.
btw, I could incorporate a bit of your code into my patch, esp the one
Tony commented on http://marc.info/?l=3Dlinux-omap&m=3D130570559515977&=
w=3D2
but, overall, on the topic of SR, either:
a)  move SR autocomp into sysfs (and dump the rest of the debugfs - it
is useful for validation, but does'nt really provide additional info)
- given that it used to reside in /sys/power/sr_vddx_autocomp and then
moved to debugfs, I am not sure if this is the right path
b) move SR autocomp into a board defined configuration.. more
intrusive, but folks would really want to enable SR as an option at
times from userspace - many distros and devices do this (e.g. N900)..

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
