From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap:pm: Fix boot-time errors with debugfs disabled
Date: Tue, 24 May 2011 16:57:33 -0700
Message-ID: <8739k3zm6q.fsf@ti.com>
References: <1305221790-4944-1-git-send-email-premi@ti.com>
	<87fwocrmr9.fsf@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024CFDCEE1@dbde02.ent.ti.com>
	<BANLkTi=9hP2Hve-DfeM8QR-D5qvcn3omgg@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D09AD0D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:51846 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757455Ab1EXX5h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 May 2011 19:57:37 -0400
Received: by pxi10 with SMTP id 10so5197611pxi.22
        for <linux-omap@vger.kernel.org>; Tue, 24 May 2011 16:57:36 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D09AD0D@dbde02.ent.ti.com>
	(Sanjeev Premi's message of "Fri, 20 May 2011 20:51:28 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Premi, Sanjeev" <premi@ti.com> writes:

[...]

>> > [sp] I don't like #ifdefs either but each time we cannot create
>> > =C2=A0 =C2=A0 a new file changes like this.
>> >
>> > =C2=A0 =C2=A0 The current code is a mess with debugfs used too fre=
quently.
>> > =C2=A0 =C2=A0 And - all of it is not for debug. The location of if=
defs in
>> > =C2=A0 =C2=A0 in the patch illustrates it quite well.
>> >
>> > =C2=A0 =C2=A0 BTW, this isn't the only use of ifdefs in a C file i=
n Linux.
>> in reality the only reason you've had to do this patch was because w=
e
>> had a wicked handling of debugfs entries in voltage layer - with
>> voltdm_c these are all gone. further any entries remaining (e.g. SR)
>> are:
>> dentry for debugfs file -> just a minor overhead not=20
>> deserving a #ifdef
>> all other functions of debugfs (as per include/linux/debugfs.h) when
>> debugfs is disabled in .config will be static inlined and we will no=
t
>> need any #ifdefs at all
>>=20
>> The real pending question is about functional SR debugfs entries tha=
t
>> need to loose it's critical functionality.
>
> [sp] good argument for future not the present and past. Fact is that
>      "wicked handling of debugfs entries" made their way.

Correct.  As maintainers, we do not always catch every problem.  Also,
we have not been as strict about some things in the past as we are now.

However, the fact that bad coding style exists in the kernel already is
not a good argument for accepting more.

>      I am not worried about the patch in or out - few folks who were
>      stuck on the issue would have used it anyway. But, whether each
>      fix for today can be postponed for future restructuring.
>
>      #ifdefs were just easy target for the postponement.

Nothing has to be postponed for future restructuring.

The reason $SUBJECT patch was not merged, was because the approach was
not correct.

If you submit an acceptable fix to this problem, I'll merge it today
even if I'm in the process of removing those features in parallel
restructuring work, because I don't know when my removal work will be
ready.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
