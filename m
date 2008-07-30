From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: USB driver issue
Date: Wed, 30 Jul 2008 20:49:17 +0300
Message-ID: <20080730174910.GV7275@frodo>
References: <31e679430807300505o3050a75ar2f9d8ff0cd35ea1b@mail.gmail.com> <317276.12528.qm@web53211.mail.re2.yahoo.com> <20080730154648.GJ6897@gandalf.research.nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB02567D91EE@dbde02.ent.ti.com>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02567D91EE-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: "igor.stoppa-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <igor.stoppa-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, ext Emanoil Kotsev <deloptes-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org" <linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org>, SUBHRANIL CHOUDHURY <subhra85-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 30, 2008 at 11:02:27PM +0530, Gadiyar, Anand wrote:
> It would be nice if everyone were to migrate to the latest code, but does that
> really take away the fun of solving a problem? I agree we shouldn't try to fix something
> that, in all likelyhood, has already been fixed. But is it really so much of an effort for us
> to trace a problem without making the OP figure out how to get a totally new kernel
> running? Are we really this lazy?

I wouldn't say lazy. At least I have several other stuff internally to
deal with and if this is an already fixed bug, I really wouldn't like to
spend time fixing it again.

Maybe this discussion is already too big and we're not trying to solve
the problem anyways.

So here are a few questions:

1. Can linux-omap boot up omap3 osk ?
2. Can omapzoom kernel boot up omap3 osk ?
3. Can you try to see if the bug appears in both of those kernels ?
4. Can you send more detailed debugging messages ?
5. Can you describe a way to reproduce the bug ?

Please, keep my nokia mail in the loop so I can take a look at it after
we get more information :-)

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
