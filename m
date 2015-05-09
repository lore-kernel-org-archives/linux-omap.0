From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 1/4] remoteproc: introduce rproc_get_by_phandle API
Date: Sat, 9 May 2015 10:39:14 +0300
Message-ID: <CAK=WgbZCqnMPEnU2992gkOp07BaCP5NJNRO-hLCAdOtUXZGRnQ@mail.gmail.com>
References: <1427917039-43206-1-git-send-email-d-gerlach@ti.com> <1427917039-43206-2-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427917039-43206-2-git-send-email-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Dave,

On Wed, Apr 1, 2015 at 10:37 PM, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> wrote:
> Allow users of remoteproc the ability to get a handle to an rproc by
> passing a phandle supplied in the user's device tree node. This is
> useful in situations that require manual booting of the rproc.
>
> This patch uses the code removed by commit 40e575b1d0b3 ("remoteproc:
> remove the get_by_name/put API") for the ref counting a rproc klist
> code but has rproc_get_by_name replaced with an rproc_get_by_phandle API.

The general idea makes sense to me, but I'm not sure we really do need
a klist here, since the usage profile of this list is expected to be
super simple: very small number of accessors, looking for small number
of list members a small number of times, and probably never do need to
modify the list while accessing it.

I suspect that the code would be simpler to maintain, debug and
understand if we just use a simple list with a simple locking
methodology here.

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
