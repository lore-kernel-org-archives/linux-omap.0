From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 13:01:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005281257040.1939-100000@iolanthe.rowland.org>
References: <20100528173151.2c5f6fde@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44046 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758399Ab0E1RBc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 May 2010 13:01:32 -0400
In-Reply-To: <20100528173151.2c5f6fde@lxorguk.ukuu.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brian Swetland <swetland@google.com>, Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, tytso@mit.edu, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>

On Fri, 28 May 2010, Alan Cox wrote:

> > I think Arve's concern was the representation of the "I care, but o=
nly
> > a little" or "just low enough to ensure threads must run" level whi=
ch
> > is what suspend blockers would map to (low enough to ensure we
> > shouldn't halt the world but not necessarily implying a hard latenc=
y
> > constraint beyond that).
>=20
> That's why I suggested "manyana" (can't get accents for ma=F1ana in a
> define) or perhaps "dreckly"[1]. They are both words that mean "at so=
me
> point" but in a very very vague and 'relax it'll happen eventually' s=
ense.

A USA-style equivalent phrase might be "Real Soon Now".  Except that it=
=20
conveys a strong implication that the event will never happen...

> > That makes sense -- and as I've mentioned elsewhere, we're really n=
ot
> > super picky about naming -- if it turns out that
> > wakelocks/suspendblockers were shorthand for "request a qos constra=
int
> > that ensures that threads are running", we'll be able to get things
> > done just as well as we do now.
>=20
> Cool. I think they are or at least they are close enough that nobody =
will
> notice the join ;)

Why are suspend blockers needed if you're going to put all untrusted=20
apps in a cgroup and freeze/stop them?  Or is that not what you're=20
planning to do?

ALan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
