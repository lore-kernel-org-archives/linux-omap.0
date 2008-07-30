From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: USB driver issue
Date: Wed, 30 Jul 2008 20:41:26 +0300
Message-ID: <20080730174125.GU7275@frodo>
References: <31e679430807300505o3050a75ar2f9d8ff0cd35ea1b@mail.gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB02567D91ED@dbde02.ent.ti.com>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02567D91ED-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: Daniel Stone <daniel.stone-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, ext Emanoil Kotsev <deloptes-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org" <linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org>, SUBHRANIL CHOUDHURY <subhra85-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 30, 2008 at 10:55:03PM +0530, Gadiyar, Anand wrote:
> Okay. That comparison wasn't warranted, I guess. But here's what went through
> my mind when I read Felipe's post. "If you want this to work, then upgrade". And
> that looked exactly like MS telling me "I can't help you with XP anymore, move on
> to Vista mate".

eheh, did I really say that ? I hope not. :-p

What I meant is that it's possible that recent code has that particular
bug fixed.

> Why on earth do we have the stable trees then? Why do people put in their time
> porting fixes back to the 2.6.22.* 'stable' trees? There are still people out there
> that use them, for whatever reason. And they do run into bugs that still haven't been
> caught.

But then again, if the problem _is_ solved in current tree then it's
easier to just backport then trying to solve it again.

If it _does_ exist in current code, then we fix both in a shot.

> I don't particularly care if people don't want to support old code. What I do
> care about is the attitude that's out here - "Hey! Move up in life man! Get the
> latest, greatest, RC kernel! 2.6.24 is ancient, 2.6.26 is ancient!". Yes, I do use
> 2.6.27-rc1 prepatch. But I do recognize that there are people out there who don't.

We do recognize as well. We're still releasing maemo sw with 2.6.21
kernel.

> Yes people should ideally work off the latest. But that shouldn't mean one won't
> get help if one is not using the latest. Or am I totally wrong here?

Again, if there is more recent code to try out, I really don't see why
not trying out that more recent code to see if the same bug shows up.

It'll make things easier to track down. We should know if we were able
to fix it since 2.6.22 until today, then we just track the changes in
that particular function and it's a lot easier to backport the fix,
don't you think ?

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
