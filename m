From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH] omap:pm: Fix boot-time errors with debugfs disabled
Date: Wed, 18 May 2011 04:06:18 -0500
Message-ID: <BANLkTik5ZQLzyNqS6CRuJrActm9O7r7LEA@mail.gmail.com>
References: <1305221790-4944-1-git-send-email-premi@ti.com>
 <BANLkTim+3M3Z0C3GTtTQrb2cqk5eSAsR+w@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB593024CE66D34@dbde02.ent.ti.com>
 <BANLkTinxvCNdr7qQTWjRZ2KceSvanGQ0Sg@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB593024CFDC82C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:43135 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755816Ab1ERJGm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 05:06:42 -0400
Received: by mail-wy0-f171.google.com with SMTP id 32so1121216wyb.30
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 02:06:41 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024CFDC82C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, May 18, 2011 at 04:00, Premi, Sanjeev <premi@ti.com> wrote:
>> While cleaning up voltdm_c set earlier this week, I think your chang=
es
>> apply better there.
>> btw, I could incorporate a bit of your code into my patch, esp the o=
ne
>> Tony commented on http://marc.info/?l=3Dlinux-omap&m=3D1305705595159=
77&w=3D2
ok this part got rejected pending regulator framework for scalable
voltage domains..

>> but, overall, on the topic of SR, either:
>> a) =A0move SR autocomp into sysfs (and dump the rest of the debugfs =
- it
>> is useful for validation, but does'nt really provide additional info=
)
>> - given that it used to reside in /sys/power/sr_vddx_autocomp and th=
en
>> moved to debugfs, I am not sure if this is the right path
>> b) move SR autocomp into a board defined configuration.. more
>> intrusive, but folks would really want to enable SR as an option at
>> times from userspace - many distros and devices do this (e.g. N900).=
=2E
>
> [sp] I am not sure what you are suggesting. Can't we take in the patc=
h and
> =A0 =A0 then do the movements? ... the ones that doesn't seem to be i=
mplemented
> =A0 =A0 so far (based on your comments).
depends on what Kevin thinks is the future of voltdm(in terms of which
=2E4x target) - might be good to focus our attention into a single
branch and cleanit up for upstream.. I am personally not sure what
should autocomp's future should be - I think option of having boards
be able to define it - maybe as part of regulator framework + debugfs
cleanup similar(as voltdm_c has removed I believe all of voltage
debugfs - so your patch can be much smaller and effective there)..

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
