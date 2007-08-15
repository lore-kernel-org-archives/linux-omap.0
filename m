From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] MUSB_HDRC: Get rid of pr_*() and printk() clauses
Date: Wed, 15 Aug 2007 09:13:58 -0700
Message-ID: <200708150913.58968.david-b@pacbell.net>
References: <1187186887430-git-send-email-felipe.lima@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1187186887430-git-send-email-felipe.lima@indt.org.br>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 15 August 2007, Felipe Balbi wrote:
> =A0=A0=A0=A0=A0=A0=A0=A0* Convert pr_*() to dev_*() macros

That's not always a win, especially in IRQ paths where the extra
text of dev_*() can introduce new timings ... but I won't eyeball
these changes, they're likely at least safe.  It's appropriate to
use the pr_*() calls in cases where "there can be only one", so
there's no value in adding the driver name and a device ID.


> =A0=A0=A0=A0=A0=A0=A0=A0* Convert printk() to dev_*() macros

Similarly ... printk() to pr_*() might be better, but I won't
eyeball them.


> =A0=A0=A0=A0=A0=A0=A0=A0* Convert missing pr_*() to {info, err, dbg}() =
macros

No, please -- don't use those ancient USB-only macros, they're
for legacy code.  Plus, you're using them wrong:

> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pr_d=
ebug("TEST_J\n");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dbg(=
"TEST_J\n");

We don't want *TWO* newlines after each diagnostic message.
Plus, those aren't "missing" at all...

- Dave
