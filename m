From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Mon, 7 Jun 2010 17:45:01 -0700
Message-ID: <AANLkTilpubFRXeNgrzShBnL_EvHu9cKW8lAETIiTgMtr@mail.gmail.com>
References: <AANLkTikGDSzaENwg_0BAtsYf3ulGd_6sGPR30WsvUxMi@mail.gmail.com>
	<alpine.LFD.2.00.1006050246350.2933@localhost.localdomain>
	<AANLkTikU21xF49Z-_Lnrq7U7buNmqw_gyEEST8LuN24z@mail.gmail.com>
	<alpine.LFD.2.00.1006051736040.2933@localhost.localdomain>
	<AANLkTinD39rI47innPbGz1Gi8PsXV5HqkmaQuJ70oQ63@mail.gmail.com>
	<alpine.LFD.2.00.1006052348200.2933@localhost.localdomain>
	<AANLkTikmWDHYJ8wWF2cZapbkHHjV09R39I37yvQXFmor@mail.gmail.com>
	<alpine.LFD.2.00.1006060148470.2933@localhost.localdomain>
	<AANLkTikdM79nmARagK9gLveMWEiT6rlk44UELes1k8Ch@mail.gmail.com>
	<alpine.LFD.2.00.1006061202351.2933@localhost.localdomain>
	<20100606144322.GC21016@count0.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100606144322.GC21016@count0.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Jun 6, 2010 at 7:43 AM, Matt Helsley <matthltc@us.ibm.com> wrot=
e:
> On Sun, Jun 06, 2010 at 12:36:21PM +0200, Thomas Gleixner wrote:
>> On Sat, 5 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>
> <snip>
>
>> > events like input event go though a single thread in our system
>> > process, while other events like network packets (which are also
>> > wakeup events) goes directly to the app.
>
> If you want to wake up cgroup-frozen tasks for these fds perhaps your
> framework can fcnt(fd, F_SETOWN, <p[g]id>) to send SIGIO to a

How does the framework get all the fds that are used by the apps for
wakeup events?

> userspace-suspend-blocker thread/process/process group. When IO comes=
 in, the
> suspend blocker is signalled which then unfreezes the cgroup of the f=
rozen
> untrusted task. SIGIO works on pipes, fifos, sockets, ttys, and ptys =
--
> many of which are precisely the kinds of things that would connect [t=
rusted
> and untrusted] apps. Notably absent (last I checked): inotify fds, si=
gnalfd,
> timerfd, eventfd, filesystem fds and likely more.
>
> Incidentally, this is just to show that it's not impossible to implem=
ent
> "wakeups" for cgroup-frozen tasks in userspace.
>
> Cheers,
> =A0 =A0 =A0 =A0-Matt Helsley
>



--=20
Arve Hj=F8nnev=E5g
