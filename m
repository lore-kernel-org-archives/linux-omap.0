From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] usb: musb: get rid of MUSB_LOGLEVEL and use parameter
Date: Sun, 10 Aug 2008 11:37:39 -0700
Message-ID: <20080810183739.E83F6B2AB@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <1218370846-9312-1-git-send-email-me@felipebalbi.com>
 <20080810175319.GA24358@suse.de> <20080810175650.GI7574@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080810175650.GI7574@frodo>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-l3A5Bk7waGM@public.gmane.org
Cc: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

> > Why are there any proc files in this driver?  Drivers should not add
> > proc files.  Hm, should have reviewed this code a bit better, sorry...

With that much code, it's just a question of _how much_ any review
ends up missing.


> We needed a quick way to export the testmodes to userland. And it's been
> used for that.
>
> > Can you please just remove them all?
>
> Yeah, I'm moving them to debugfs. I can remove everything and later add
> only the debugfs if you like.

And would you believe this is the *trimmed down* proc file?  Sigh.

I removed almost all of that support a couple years ago, preparing
to remove it entirely ... the problem spot was the *write* paths.
Taking any of them out seemed to have a significant negative impact
on ability to get this code working on new hardware.

Glad to see Felipe is finishing that.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
