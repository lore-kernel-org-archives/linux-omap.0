From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] ARM: OMAP: Fix board data to support device only, host
 only and OTG roles.
Date: Fri, 28 May 2010 21:06:56 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032194B74C@dbde02.ent.ti.com>
References: <20100521065218.GG925@nokia.com>
 <420791.3389.qm@web180306.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <420791.3389.qm-g47maUHHHF8HBU+L9ui1Svu2YVrzzGjVVpNB7YpNyf8@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Mankad, Maulik Ojas" <x0082077-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

David Brownell wrote:
> > 
> > >"incompatible Kconfig role setting"
> > 
> > there's a patch making that a warning instead of an #error
> > if I'm not wrong.
> 
> It's not an #error, it's a dev_err().
> 
> But more to the point, it's reporting a real error.  As
> the comment in the code explains:
> 
>         /* The driver might handle more features than
>          * the board; OK.
>          * Fail when the board needs a feature that's
>          * not enabled.
>          */
> 
> Ut;s simple:  OTG connectors require OTG support.  Host
> connectors require host support.  Peripheral connectors 
> require peripheral support.  Why is anyone confused??


A board which has an OTG connector, and supports OTG mode
with this driver, very likely also supports host-only and
peripheral-only usage on that port.

Many times, we build kernels without USB host support
or without USB gadget support compiled in (if only for
testing). Instead of failing init, wouldn't it be useful
to report a big warning and downgrading to host-only
or peripheral-only roles as configured in the kernel?

(which is almost what Ming Lei's patch at [1] does - except
that it uses dev_info instead of something more severe).

(Okay, I do know anyone who compiles a custom kernel of
this sort is likely capable of patching the board files
as needed to downgrade to the desired mode. But I still
think the patch at [1] is useful to have.)

- Anand

[1] <http://marc.info/?l=linux-usb&m=127367875600618&w=2>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
