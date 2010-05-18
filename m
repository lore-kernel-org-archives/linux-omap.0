From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 18 May 2010 21:39:29 +0200
Message-ID: <201005182139.29783.rjw@sisk.pl>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<AANLkTinOFSVHnufbVKIei0KMbfkVvDgLVDRHkCldagfY@mail.gmail.com>
	<4BF23BAC.90102@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BF23BAC.90102@euromail.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Sven Neumann <s.neumann@raumfeld.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tero Saarni <tero.saarni@gmail.com>, linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Alexey Dobriyan <adobriyan@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Mack <daniel@caiaq.de>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, Daniel Walker <dwalker@codeaurora.org>, Theodore Ts'o <tytso@mit.edu>, =?iso-8859-1?q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Brian Swetland <swetland@goo>
List-Id: linux-omap@vger.kernel.org

On Tuesday 18 May 2010, Henrik Rydberg wrote:
> Arve Hj=F8nnev=E5g wrote:
> > It does not matter how you enter suspend. Without opportunistic
> > suspend, once you tell the kernel that you want to suspend, you cannot
> > abort. If a wakeup event occurs at this point, it will probably not be
> > processed until the system wakes up for another wakeup event.
> > =

> =

> Since it seems to be at the very core of the argument, how long time does=
 it
> take to suspend your system? Is it something that could be improved upon?

It's not a matter of time.  It's a matter of lost keystrokes and such.

Rafael
