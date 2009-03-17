From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] tidspbridge: remove revision history
Date: Tue, 17 Mar 2009 11:16:35 +0200
Message-ID: <94a0d4530903170216x4253ee07r6fdfb38cfccce78d@mail.gmail.com>
References: <1237241138-4516-1-git-send-email-felipe.contreras@gmail.com>
	 <7A436F7769CA33409C6B44B358BFFF0CFF5A499A@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:60909 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbZCQJQi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 05:16:38 -0400
Received: by fxm24 with SMTP id 24so3830863fxm.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 02:16:35 -0700 (PDT)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF5A499A@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

On Tue, Mar 17, 2009 at 6:50 AM, Menon, Nishanth <nm@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Felipe Contreras
>> Sent: Tuesday, March 17, 2009 12:06 AM
>> To: linux-omap@vger.kernel.org
>> Cc: Kanigeri, Hari; Hiroshi DOYU; Ameya Palande; Guzman Lugo, Fernan=
do;
>> Felipe Contreras
>> Subject: [PATCH] tidspbridge: remove revision history
>>
>> No need for that with git.
>> diff --git a/drivers/dsp/bridge/gen/_gt_para.c
>> b/drivers/dsp/bridge/gen/_gt_para.c
>> index 181fe41..b363590 100644
>> --- a/drivers/dsp/bridge/gen/_gt_para.c
>> +++ b/drivers/dsp/bridge/gen/_gt_para.c
>> @@ -24,14 +24,6 @@
>> =C2=A0 * =C2=A0 =C2=A0 =C2=A0etc. into a fully bound image. =C2=A0Th=
us, GT_assert() can be retained
>> in
>> =C2=A0 * =C2=A0 =C2=A0 =C2=A0a program for which GT_?trace() has bee=
n compiled out.
>> =C2=A0 *
>> - *! Revision History:
>> - *! =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> - *! 24-Feb-2003 vp: Code Review Updates.
>> - *! 18-Oct-2002 sb: Ported to Linux platform.
>> - *! 03-Jul-2001 rr: Removed kfuncs.h because of build errors.
>> - *! 07-Dec-1999 ag: Fxn error now causes a WinCE DebugBreak;
>> - *! 30-Aug-1999 ag: Now uses GP_printf for printf and error.
>> - *!
> But we did not have git history 1999-2003. we planning on loosing the=
se contribs?

Only if you want dspbridge to be merged which as time passes it's
becoming more clear that you don't. I'm not a kernel developer, but I
would challenge you to find a diver that has 1000 lines of revision
history in the source code.

Besides, how any of this can be useful?

>> - *! 24-Feb-2003 vp: Code Review Updates.

Ok, what are the updates?

>> - *! 18-Oct-2002 sb: Ported to Linux platform.

So?

>> - *! 03-Jul-2001 rr: Removed kfuncs.h because of build errors.

Nice, but who cares?

>> - *! 07-Dec-1999 ag: Fxn error now causes a WinCE DebugBreak;

Ahh, WinCE history in a Linux driver, very useful.

>> - *! 30-Aug-1999 ag: Now uses GP_printf for printf and error.

Not printk? I assume this is not related to Linux then.


Are we going to find an issue at some point in time that we'll say: oh
crap! if only we had the revision history log we could solve it!

I doubt that, the revision history is useless without the actual
changes. These lines are just introducing noise.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
