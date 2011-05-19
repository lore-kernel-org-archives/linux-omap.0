From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH] omap:pm: Fix boot-time errors with debugfs disabled
Date: Thu, 19 May 2011 08:58:15 -0500
Message-ID: <BANLkTi=9hP2Hve-DfeM8QR-D5qvcn3omgg@mail.gmail.com>
References: <1305221790-4944-1-git-send-email-premi@ti.com>
 <87fwocrmr9.fsf@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024CFDCEE1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:36119 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933238Ab1ESN6l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 09:58:41 -0400
Received: by mail-wy0-f175.google.com with SMTP id 20so2384983wye.20
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 06:58:35 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024CFDCEE1@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, May 19, 2011 at 05:30, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: Hilman, Kevin
>> Sent: Wednesday, May 18, 2011 10:04 PM
>> To: Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCH] omap:pm: Fix boot-time errors with
>> debugfs disabled
>>
>> Hi Sanjeev,
>>
>> Sanjeev Premi <premi@ti.com> writes:
>>
>> > There is an implicit assumption in current implementation that
>> > debugfs is always enabled.
>> >
>> > When debugfs is disabled, these errors are noticed during boot:
>> > =A0 omap_voltage_late_init: Unable to create voltage debugfs main =
dir
>> > =A0 vdd_debugfs_init: Unable to create debugfs directory for vdd_m=
pu
>> > =A0 vdd_debugfs_init: Unable to create debugfs directory for vdd_c=
ore
>> >
>> > This patch fixes these errors by enclosing code related to debugfs
>> > in #ifdef CONFIG_DEBUG_FS..#endif.
>> >
>> > Boot tested on OMAP3EVM.
>> >
>> > Signed-off-by: Sanjeev Premi <premi@ti.com>
>>
>> Sorry for the delay here, I've been on the road and finally
>> catching up
>> on the list.
>>
>> Basically, I'm in the process of a pretty major cleanup of
>> the VC/VP and
>> SR layers. =A0For example, in my pm-wip/voltdm_* branches, the debug=
fs
>> interface to the voltage layer has been completely removed. =A0I'm a=
lso
>> thinking of removing the SR debugfs interface also, as I don't reall=
y
>> think we need a userspace interface for this. =A0A board-level inter=
face
>> is probably enough (/me waits for flame from Nishanth :)
>>
>> That being said, your approach below isn't quite right in its usage =
of
>> #ifdefs. =A0Use of #ifdefs like this is frowned upon for many reason=
s.
>> For starters, take a look the '#ifdefs are ugly' section of
>> Documentation/SubmittingPatches.
>
> [sp] I don't like #ifdefs either but each time we cannot create
> =A0 =A0 a new file changes like this.
>
> =A0 =A0 The current code is a mess with debugfs used too frequently.
> =A0 =A0 And - all of it is not for debug. The location of ifdefs in
> =A0 =A0 in the patch illustrates it quite well.
>
> =A0 =A0 BTW, this isn't the only use of ifdefs in a C file in Linux.
in reality the only reason you've had to do this patch was because we
had a wicked handling of debugfs entries in voltage layer - with
voltdm_c these are all gone. further any entries remaining (e.g. SR)
are:
dentry for debugfs file -> just a minor overhead not deserving a #ifdef
all other functions of debugfs (as per include/linux/debugfs.h) when
debugfs is disabled in .config will be static inlined and we will not
need any #ifdefs at all

The real pending question is about functional SR debugfs entries that
need to loose it's critical functionality.
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
