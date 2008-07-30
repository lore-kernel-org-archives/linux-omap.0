From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: USB driver issue
Date: Wed, 30 Jul 2008 18:46:48 +0300
Message-ID: <20080730154648.GJ6897@gandalf.research.nokia.com>
References: <31e679430807300505o3050a75ar2f9d8ff0cd35ea1b@mail.gmail.com> <317276.12528.qm@web53211.mail.re2.yahoo.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <317276.12528.qm-RmV0OGDAqv2B9c0Qi4KiSl5cfvJIxWXgQQ4Iyu8u01E@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Emanoil Kotsev <deloptes-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: SUBHRANIL CHOUDHURY <subhra85-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 30, 2008 at 07:21:53AM -0700, ext Emanoil Kotsev wrote:
> 
> Dear Felipe, I just want to tell, that while still developing kernels in the 2.6.2X series a kernel 2.6.22 can not be labeled as old. Besides it comes along with few distros as default kernel.
> 
> A lot of people like me need some kind of a stable version that we can relay on for more than playing at home, which is the case with 2.4.X tree. 
> 
> Personally, experiments with 2.6.24 brought me into a big trouble and it took many hours to migrate back to 2.6.20, so please keep in mind that if we say something like this, there is a good reason to do so.

You can always choose any kernel version you want but if you choose such
an old version (2.6.22 was released in Jul 8th, 2007), please don't rely
in community support and instead, backport all changes in the particular
driver you're working with to 2.6.22.

It's always your choice.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
