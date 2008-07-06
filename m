From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH 3/4] Hook start_hnp into ohci struct
Date: Sun, 6 Jul 2008 14:05:07 +0300
Message-ID: <20080706110507.GA6615@frodo>
References: <20080706102630.GA29934@doriath.ww600.siemens.net> <20080706103050.GB20019@kedavra.cpe.vivax.com.br> <20080706103332.GA28505@doriath.ww600.siemens.net>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080706103332.GA28505-nIupHZaCssqR2kOLt6zJ8ErlnG4Plg33XqFh9Ls21Oc@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Baryshkov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sun, Jul 06, 2008 at 02:33:32PM +0400, Dmitry Baryshkov wrote:
> Actually the ohci-omap.c:start_hnp does a bit more than just
> otg_start_hnp(tranceiver). Maybe it should be merged. I dunno.

Most likely it should be merged, or at least the name should change.

--
	- Balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
