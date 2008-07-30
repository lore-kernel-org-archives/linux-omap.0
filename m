From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: USB driver issue
Date: Wed, 30 Jul 2008 21:53:43 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02567D91E7@dbde02.ent.ti.com>
References: <31e679430807300505o3050a75ar2f9d8ff0cd35ea1b@mail.gmail.com>
	<317276.12528.qm@web53211.mail.re2.yahoo.com>,<20080730154648.GJ6897@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080730154648.GJ6897-f9ZlEuEWxVfta4EC/59zMBl4MBrZKKet0E9HWUfgJXw@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, ext Emanoil Kotsev <deloptes-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org" <linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org>, SUBHRANIL CHOUDHURY <subhra85-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> On Wed, Jul 30, 2008 at 07:21:53AM -0700, ext Emanoil Kotsev wrote:
> >
> > Dear Felipe, I just want to tell, that while still developing kernels in the 2.6.2X
> series a kernel 2.6.22 can not be labeled as old. Besides it comes along with few
> distros as default kernel.
> >
> > A lot of people like me need some kind of a stable version that we can relay on
> > for more than playing at home, which is the case with 2.4.X tree.
> >
> > Personally, experiments with 2.6.24 brought me into a big trouble and it took
> > many hours to migrate back to 2.6.20, so please keep in mind that if we say
> > something like this, there is a good reason to do so.
>
> You can always choose any kernel version you want but if you choose such
> an old version (2.6.22 was released in Jul 8th, 2007), please don't rely
> in community support and instead, backport all changes in the particular
> driver you're working with to 2.6.22.
>
> It's always your choice.

That's plain wrong. 2.6.22 was released in July 2007. But 2.6.22.18 was not.
That came much later - in February this year. And people still do use 2.6.22
kernels. Besides, the MUSB code hasn't really changed that much in this time.

Do you really think the problem will go away in 2.6.26? People can't always use the
latest kernel, you know. Embedded kernels don't get enough testing. There's always
a chance this is a new driver. And even if it weren't, the very act of debugging
a problem like this is a good learning experience.

Grr. Saying one needs to upgrade to the latest kernel before one can expect
support is a bit like certain proprietary OS vendors - and even they do a better
job than this.

Regards,
Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
