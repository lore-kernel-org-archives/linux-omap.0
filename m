From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 11/11] staging: ti dspbridge: enable driver building
Date: Wed, 7 Jul 2010 12:31:07 +0300
Message-ID: <AANLkTikAZCAj4mljYbJcppuIL2quYz8AK0AkTFCZO3bG@mail.gmail.com>
References: <1277298125-17991-1-git-send-email-ohad@wizery.com>
	<1277298840-18516-1-git-send-email-ohad@wizery.com>
	<20100623224150.GA6680@kroah.com>
	<AANLkTik0rm12w4jplD1vSTZnPbwguDU6xtOdAfs9C-3r@mail.gmail.com>
	<4C33513C.4090704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C33513C.4090704@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Greg KH <greg@kroah.com>, Ohad Ben-Cohen <ohad@wizery.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Menon, Nishanth" <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

I'm removing many people from the Cc which I think don't care about
this. Is this even the right place for discussing about it?

On Tue, Jul 6, 2010 at 6:52 PM, Omar Ramirez Luna <omar.ramirez@ti.com>=
 wrote:
> On 7/4/2010 5:53 AM, Felipe Contreras wrote:
>> On Thu, Jun 24, 2010 at 1:41 AM, Greg KH<greg@kroah.com> =C2=A0wrote=
:
>>> So I need some more Kconfig changes here, care to redo just this on=
e
>>> patch? =C2=A0I've applied all the others and they will show up in l=
inux-next
>>> tomorrow.
>>
>> I fixed all that stuff some time ago:
>> http://article.gmane.org/gmane.linux.ports.arm.omap/36065
>>
>> But the patches were ignored.
>
> Patches were not ignored, discussion was held privately (you and me),

That was for the deh reorganization. Not the Kconfig ones.

Regarding the deh reorganization...

> patch
> 13 was not accepted because changing indentation doesn't deserve a co=
pyright
> assignment (IMHO),

You didn't want to add a copyright without giving any valid reason, so
you started a private thread. You never mentioned any rejection of the
patches on any grounds, neither publicly, nor privately.

If the patch series is only changing indentation then the lines
removed would match the lines added, which is not the case. Take a
look:
15 files changed, 184 insertions(+), 509 deletions(-)

In my book removing 300 lines of code while keeping all the
functionality is a good thing. Without even considering that the rest
of the insertions are cleaning up the code.

> at that point *you* wanted your patches not to be
> included if the last one wasn't merged in.

Not without the copyright update patch.

Maybe you are forgetting that I made many changes before those
patches. Here are some stats for ue_deh and mmu_fault:

Me:
 22 commits, 487 insertions(+), 742 deletions(-)

Others:
 60 commits, 394 insertions(+), 617 deletions(-)

(I didn't count the automated camel case removal)
 218 insertions(+), 209 deletions(-)

And 'git blame' shows me on 70% of ue_deh (which doesn't take into
consideration code removals which is the main thing I did).

While the vast majority of the changes are cleanups (much needed);
there are also functional changes, mostly fixing memory corruptions,
both reproduced and theoretical.

If somebody writes a piece of code that's 10,000 lines, and another
person reorganizes the code to make it 1,000 lines; IMO the usefulness
of the code relies on both person's contributions. Depending on
whether you care about having something functional, or
maintainability/readability; you might assign more value to one, or
the other, but I think both are important.

So. Would you care to give a reason why my contributions don't deserve
a copyright?

--=20
=46elipe Contreras
