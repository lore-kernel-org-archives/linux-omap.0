From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] MUSB_HDRC: Get rid of pr_*() and printk() clauses
Date: Wed, 15 Aug 2007 09:44:28 -0700
Message-ID: <200708150944.28365.david-b@pacbell.net>
References: <1187186887430-git-send-email-felipe.lima@indt.org.br>
	<200708150913.58968.david-b@pacbell.net>
	<31e679430708150929v794b4a64h71e096f9f7c044e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <31e679430708150929v794b4a64h71e096f9f7c044e4@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 15 August 2007, Felipe Balbi wrote:
> > > * Convert missing pr_*() to {info, err, dbg}() macros
> >
> > No, please -- don't use those ancient USB-only macros, they're
> > for legacy code. =A0Plus, you're using them wrong:
> >
> > > -pr_debug("TEST_J\n");
> > > +dbg("TEST_J\n");
>=20
> Oh... sorry forgot to remove that extra '\n' from the message. I'll
> fix this, maybe getting back to pr_*. Do you have any other comments
> about this? How should I do it right??

I really don't see anything wrong with pr_*() in most cases.

A patch moving bare printks to something else would be a lot
easier to quickly review than something changing a whole bunch
of other stuff.

- Dave
