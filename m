From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 5/5] i2c: omap: add trace
Date: Wed, 3 Dec 2014 17:52:18 +0300
Message-ID: <2E40A984-A6AA-4D17-AB1D-725004EF845F@gmail.com>
References: <1417617242-16869-1-git-send-email-al.kochet@gmail.com> <1417617242-16869-6-git-send-email-al.kochet@gmail.com> <20141203144934.GB16138@saruman>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141203144934.GB16138@saruman>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


03 =C4=C5=CB. 2014 =C7., =D7 17:49, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> =CE=C1=D0=
=C9=D3=C1=CC(=C1):

> NAK, if you want to add traces, use, well, tracepoints :-) It makes n=
o
> sense to hack stuff like this.

It's for testing only the problem reported not for upstream :)
The hack stuff like this is to allow for me to see what happens on the =
Tony's board.
I don't have omap2430 board.

Regards,
Alexander.
