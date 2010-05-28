From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 29 May 2010 00:24:22 +0200
Message-ID: <201005290024.22915.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<20100528104415.1403541a@schatten.dmk.lab>
	<AANLkTikXtk-f41-z8gXfXLNLqgGVa0z4d-qgIvwljbR-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikXtk-f41-z8gXfXLNLqgGVa0z4d-qgIvwljbR-@mail.gmail.com>
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

On Friday 28 May 2010, Arve Hj=F8nnev=E5g wrote:
> On Fri, May 28, 2010 at 1:44 AM, Florian Mickler <florian@mickler.org> wr=
ote:
> > On Thu, 27 May 2010 20:05:39 +0200 (CEST)
> > Thomas Gleixner <tglx@linutronix.de> wrote:
...
> > To integrate this with the current way of doing things, i gathered it
> > needs to be implemented as an idle-state that does the suspend()-call?
> >
> =

> I think it is better no not confuse this with idle. Since initiating
> suspend will cause the system to become not-idle, I don't think is is
> beneficial to initiate suspend from idle.

It is, if the following two conditions hold simultaneously:

(a) Doing full system suspend is ultimately going to bring you more energy
    savings than the (presumably lowest) idle state you're currently in.

(b) You anticipate that the system will stay idle for a considerably long t=
ime
    such that it's worth suspending.

Thanks,
Rafael
