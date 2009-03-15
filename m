From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc7 regulator-next] regulator: refcount fixes
Date: Sat, 14 Mar 2009 21:27:26 -0700
Message-ID: <200903142127.26182.david-b@pacbell.net>
References: <200903111743.34708.david-b@pacbell.net> <200903141429.24534.david-b@pacbell.net> <20090315003039.GA11052@sirena.org.uk>
Reply-To: dbrownell@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756452AbZCOE1k@vger.kernel.org>
In-Reply-To: <20090315003039.GA11052@sirena.org.uk>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Saturday 14 March 2009, Mark Brown wrote:
> Looking at things from the point of view of the consumer I just don't
> find that it makes any difference since as far as the consumer is
> concerned it's all opaque objects manipulated via an API.

These put()/get() calls are not refcount calls.  They're
what might be called alloc()/free() calls instead.

> =A0=A0=A0=A0=A0=A0=A0=A0foo =3D foo_get(dev, name);

The normal idiom is

	bar =3D foo_get(foo)

which just increments a refcount.  Then if "bar" were handed
to something else ("baz") right here, and "baz" needed to keep a
copy of that reference, it would be expected to grab its own
refcount via foo_get(bar), and later release via foo_put(bar).


> =A0=A0=A0=A0=A0=A0=A0=A0foo_enable(foo);
> =A0=A0=A0=A0=A0=A0=A0=A0foo_disable(foo);
> =A0=A0=A0=A0=A0=A0=A0=A0foo_put(foo);

Until "baz" called foo_put(bar), that reference would still be
usable.  But ... regulator_put(foo) does a kfree, it's not
just updating refcounts.
