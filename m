From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 1/3] usb: host: f_usb20ho: add support for Fujitsu ehci/ohci USB 2.0 host controller
Date: Wed, 17 Dec 2014 16:44:29 +0100
Message-ID: <2084132.xT3x4RUEre@wuerfel>
References: <1418695828-605-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com> <94603263.7VVvg5Qn7O@wuerfel> <830AC58E49A426478AC39824BC0FA915D8BB402BB7@fmpitwmsex01.fmpi.sea.css.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <830AC58E49A426478AC39824BC0FA915D8BB402BB7-BxlyW7DJwtfE0yrG4eIIn8GT06e9YD5CS4/B3AGzWvkvtab9mdV7tw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Sneeker. Yeh" <Sneeker.Yeh-l16TxrwUIHTQFUHtdCDX3A@public.gmane.org>
Cc: Sneeker Yeh <sneeker.yeh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Pugliese <thomas.pugliese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Mosberger <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>, Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux
List-Id: linux-omap@vger.kernel.org

On Wednesday 17 December 2014 23:33:02 Sneeker. Yeh wrote:
> >
> >No need for playing games with child devices, just see how the other drivers do
> >it.
> 
> I am wondering if this is what you mentioned here? :
> Hcd21: f_usb20ho {
>         compatible = "fujitsu,f_usb20ho";
>         ...
>         Ehci {
>                 compatible = "generic-ehci";
>                 reg = <>;
>         }
>         ohci {
>                 compatible = "generic-ohci";
>                 reg = <>;
>         }
> }
> By doing that, I can just use of_platform_populate() to create platform device more gracefully,
> than using platform_device_xxx() those have been done in of_platform_populate().
> And also, managing register offset is totally done via dts description, not in the code.

What I mean is leaving out the fujitsu,f_usb20ho node entirely, just put the
two USB controllers on the bus directly and remove this driver.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
