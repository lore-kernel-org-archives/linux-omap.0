From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: USB driver issue
Date: Sat, 2 Aug 2008 21:18:37 -0700
Message-ID: <20080803041837.GA9216@kroah.com>
References: <20080803025600.GB8304@kroah.com> <962792.40418.qm@web53204.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <962792.40418.qm-Ll//HCKdAyWB9c0Qi4KiSl5cfvJIxWXgQQ4Iyu8u01E@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Emanoil Kotsev <deloptes-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org" <linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Aug 02, 2008 at 09:08:26PM -0700, Emanoil Kotsev wrote:
> Ok, so I've installed 2.6.26 and tested most of the hardware I use.
> Except hfs everything seems to be working better than with 2.6.24 and
> much better then 2.6.20 as expected.
> 
> I'll give it a try with my server, as you say you do a lot of testing
> ... and after the hole discussion, I'm understanding your point of
> better now.
> 
> My basic problem is that I'am testing a kind of solution I had in mind
> time ago, but it still fails for some reason even with the patched
> 2.4.24 version. I gave it up and didn't test 2.6.25 because I was
> pretty buzy recently. Now I see it's hard to catch up.
> 
> My problem is the follwing one and the question is if it will disapear
> after I install 2.6.26, or is it a hardware issue. I think somehow the
> drive does not behave as the others drives I use over usb. I'm using
> mostly seagate, but this one is WD:
> 
> hub 7-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
> hub 7-0:1.0: state 7 ports 2 chg 0000 evt 0000
> usb usb4: suspend_rh (auto-stop)
> usb usb5: suspend_rh (auto-stop)
> usb usb6: suspend_rh (auto-stop)
> usb usb7: suspend_rh (auto-stop)
> ub(2.3): dir r len/act 4096/0 [sense 0 00 00] retry 1

You are using the ub driver, any reason for that?

If you try the usb-storage driver instead, does it work better?  Worse?
Different?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
