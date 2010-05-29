From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 29 May 2010 22:27:15 +0200
Message-ID: <201005292227.15479.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<201005290024.22915.rjw@sisk.pl>
	<AANLkTimM7O_k8KVSfMgsB8b_EKQEz0vpYu6pxjedsTcJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimM7O_k8KVSfMgsB8b_EKQEz0vpYu6pxjedsTcJ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Saturday 29 May 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/5/28 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Friday 28 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> On Fri, May 28, 2010 at 1:44 AM, Florian Mickler <florian@mickler.org>=
 wrote:
> >> > On Thu, 27 May 2010 20:05:39 +0200 (CEST)
> >> > Thomas Gleixner <tglx@linutronix.de> wrote:
> > ...
> >> > To integrate this with the current way of doing things, i gathered it
> >> > needs to be implemented as an idle-state that does the suspend()-cal=
l?
> >> >
> >>
> >> I think it is better no not confuse this with idle. Since initiating
> >> suspend will cause the system to become not-idle, I don't think is is
> >> beneficial to initiate suspend from idle.
> >
> > It is, if the following two conditions hold simultaneously:
> >
> > (a) Doing full system suspend is ultimately going to bring you more ene=
rgy
> >    savings than the (presumably lowest) idle state you're currently in.
> >
> > (b) You anticipate that the system will stay idle for a considerably lo=
ng time
> >    such that it's worth suspending.
> >
> =

> I still don't think this matters. If you are waiting for in interrupt
> that cannot wake you up from suspend, then idle is not an indicator
> that it is safe to enter suspend. I also don't think you can avoid any
> user-space suspend blockers by delaying suspend until the system goes
> idle since any page fault could cause it to go idle. Therefore I don't
> see a benefit in delaying suspend until idle when the last suspend
> blocker is released (it would only mask possible race conditions).

I wasn't referring to suspend blockers, but to the idea of initiating full
system suspend from idle, which I still think makes sense.  If you are
waiting for an interrupt that cannot wake you from suspend, then
_obviously_ suspend should not be started.  However, if you're not waiting =
for
such an interrupt and the (a) and (b) above hold, it makes sense to start
suspend from idle.

Thanks,
Rafael
