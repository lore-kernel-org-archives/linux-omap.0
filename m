From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] tidspbridge: remove revision history
Date: Tue, 17 Mar 2009 12:20:44 +0200
Message-ID: <94a0d4530903170320g7fc8eef5t4b8da6ab7e768a56@mail.gmail.com>
References: <1237241138-4516-1-git-send-email-felipe.contreras@gmail.com>
	 <7A436F7769CA33409C6B44B358BFFF0CFF5A499A@dlee02.ent.ti.com>
	 <94a0d4530903170216x4253ee07r6fdfb38cfccce78d@mail.gmail.com>
	 <7A436F7769CA33409C6B44B358BFFF0CFF5A49BC@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:64690 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535AbZCQKUr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 06:20:47 -0400
Received: by fxm24 with SMTP id 24so3855399fxm.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 03:20:44 -0700 (PDT)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF5A49BC@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

On Tue, Mar 17, 2009 at 11:40 AM, Menon, Nishanth <nm@ti.com> wrote:
> Hi Felipe,
>> -----Original Message-----
>> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
>> Sent: Tuesday, March 17, 2009 11:17 AM
>> To: Menon, Nishanth
>> Cc: linux-omap@vger.kernel.org; Kanigeri, Hari; Hiroshi DOYU; Ameya
>> Palande; Guzman Lugo, Fernando
>> Subject: Re: [PATCH] tidspbridge: remove revision history
>>
>> >> - *! Revision History:
>> >> - *! =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> - *! 24-Feb-2003 vp: Code Review Updates.
>> >> - *! 18-Oct-2002 sb: Ported to Linux platform.
>> >> - *! 03-Jul-2001 rr: Removed kfuncs.h because of build errors.
>> >> - *! 07-Dec-1999 ag: Fxn error now causes a WinCE DebugBreak;
>> >> - *! 30-Aug-1999 ag: Now uses GP_printf for printf and error.
>> >> - *!
>> > But we did not have git history 1999-2003. we planning on loosing =
these
>> contribs?
>>
>> Only if you want dspbridge to be merged which as time passes it's
>> becoming more clear that you don't. I'm not a kernel developer, but =
I
> Errr.. Not my attempt at a flame war ;).. But then, I am not sure if =
my comment meant anything of the sort :)...

Contrary to what it might seem I'm not attempting a flame war either.

It's not because of your comment, it's because TI has been very slow
cleaning up the driver and reluctant of integrating clean-up patches.

It seems to me as if TI thinks this driver is just fine, which is
clearly not the case.

>> would challenge you to find a diver that has 1000 lines of revision
>> history in the source code.
> <snip>
>>
>> >> - *! 30-Aug-1999 ag: Now uses GP_printf for printf and error.
>>
>> Not printk? I assume this is not related to Linux then.
>>
>>
>> Are we going to find an issue at some point in time that we'll say: =
oh
>> crap! if only we had the revision history log we could solve it!
> Errr... in the old times of cvs kernel, before we shifted to bitkeepe=
r and later to git, rev history was unfortunately necessary to maintain=
 some sort of acknowledgement of contributions. Just greping linux-omap=
 master branch " grep -Ri "Revision History" drivers/|cut -d ":" -f1|wc=
 -l" shows me 227 files of similar drivers- legacy =C2=A0- agreed. I th=
ink bridge is in such a legacy driver.

That shows me 31 files, none of which have more than a couple hundred
lines, that is of course on linux mainline.

BTW this is faster:
git grep -i -l "Revision History" -- drivers/ | wc -l

> If any new changes are done, it makes no sense to introduce an entry =
in the revision history - agreed. These driver files have a history and=
 folks have done some work to make it useful, to remove their contribut=
ions would be, IMHO, our disregard for what ever they did (good or bad)=
=2E. ;) But then, that is just my opinion..
>
> Note: There are folks whose contributions are reduced to "vp" "rr" "s=
p" etc.. I personally have no clue who they are but I guess they would =
rather be in git log than in anonymous initials if given a choice today=
=2E.

Contributors can be specified as such: a contributors section at the
top. No need to keep the revision history just for that.

>> I doubt that, the revision history is useless without the actual
>> changes. These lines are just introducing noise.
>>
>
> DSPBridge has definitely a long way to go before being merged into ma=
inline kernel. Coding standard is one part of the story. Is this part o=
f a code cleanup effort to prep the code for merge to kernel? I think I=
 have seen tons of discussion on this previously.. If we are planning o=
n prepping this driver for mainline integration that is another discuss=
ion and this patch probably is a tiny fragment to that. The bunch of hi=
story starts at [1] though..

I'm interested on getting this into the mainline so I took the
simplest of my cleanup patches and the one I thought would be less
controversial.

If TI does not intend to submit this to mainline it would be nice to
say so, that way the people interested can stop waiting and take
action.

I myself am tired of waiting.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
