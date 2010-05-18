From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 20:26:28 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005172018380.27473@utopia.booyaka.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503180741.GB2098@rakim.wolfsonmicro.main>
	<201005032318.35383.rjw@sisk.pl>
	<87sk68r1zh.fsf@deeprootsystems.com>
	<s2qd6200be21005031709r28420f0ezf3cf286517ee9114@mail.gmail.com>
	<alpine.DEB.2.00.1005141422110.3348@utopia.booyaka.com>
	<AANLkTinyNYFwM4QJKPunlvK-ATJwSYVXGayeZIR9izx2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-758310667-1274149588=:27473"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinyNYFwM4QJKPunlvK-ATJwSYVXGayeZIR9izx2@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Sven Neumann <s.neumann@raumfeld.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tero Saarni <tero.saarni@gmail.com>, linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Mack <daniel@caiaq.de>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, =?ISO-8859-15?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Brian Swetland <swetland@go>
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-758310667-1274149588=:27473
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Arve,

On Fri, 14 May 2010, Arve Hj=F8nnev=E5g wrote:

> On Fri, May 14, 2010 at 1:27 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > On Mon, 3 May 2010, Arve Hj=F8nnev=E5g wrote:
> >
> >> No, suspend blockers are mostly used to ensure wakeup events are not
> >> ignored, and to ensure tasks triggered by these wakeup events
> >> complete.
> >
> > Standard Linux systems don't need these,
>=20
> If you don't want to lose wakeup events they do.  Standard Linux systems=
=20
> support suspend, but since they usually don't have a lot of wakeup=20
> events you don't run into a lot of problems.

Sorry, I don't follow.  What causes wakeup events to be lost?  Is it the=20
current opportunistic suspend governor?  On OMAP Linux systems, as far as=
=20
I know, we don't lose any wakeup events.

> > because the scheduler just keeps the system running as long as there=20
> > is work to be done.
>=20
> That is only true if you never use suspend.

If, instead of the current Android opportunistic suspend governor, the=20
system entered suspend from pm_idle(), wouldn't that keep the system=20
running as long as there is work to done?

As far as I can see, it's the current Android opportunistic suspend=20
governor design in patch 1 that causes the system to enter suspend even=20
when there is work to be done, since it will try to suspend even when the=
=20
system is out of the idle loop.


- Paul
--155748971-758310667-1274149588=:27473
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--155748971-758310667-1274149588=:27473--
