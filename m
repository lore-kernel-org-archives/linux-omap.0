From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 11/12] usb: musb: adding high bandwidth support
Date: Fri, 20 Feb 2009 16:02:34 -0800
Message-ID: <200902201602.35014.david-b@pacbell.net>
References: <20090219052749.125178129@blue.kroah.org> <20090219054845.GL26729@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090219054845.GL26729-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 18 February 2009, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org wrote:
> From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> 
> Tested with Creative (Live! Cam Optia) USB camera which uses
> high bandwidth isochronous interface.FIFO table has been updated
> for Rx high bandwidth case.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

NAK on this one ... Ajay, please re-issue with udpates
to verify that the silicon supports high bandwith ISO!

There's code in musb_core_init():

        if (reg & MUSB_CONFIGDATA_HBRXE) {
                strcat(aInfo, ", HB-ISO Rx");
                strcat(aInfo, " (X)");          /* no driver support */
        }
        if (reg & MUSB_CONFIGDATA_HBTXE) {
                strcat(aInfo, ", HB-ISO Tx");
                strcat(aInfo, " (X)");          /* no driver support */
        }

What it needs to do is save a flag instead of
printing the " (X)" ... and test that flag later,
instead of assuming it's set.

Examples:

 - DaVinci DM6446 and DM355 don't support high bandwidth
   for either RX or TX.

 - Neither does TUSB6010 (and presumably TUSB6020), which
   was sort of extracted from the DM6446 (adding more RAM,
   splitting out the fibula and tibula chips, etc)

 - OMAP3 ES2.1 and ES3.1 support it for RX and TX ... but
   the ES3.0 chips only support it for RX (goofage?)

I don't know what the Blackfin or ST-Micro parts do, but
one shouldn't assume they always support it either.

Also, I suspect you should probably create a new fifo_mode
table to support this.  These changes will break some
composite gadget code I've seen ... and I'm curious why
you didn't just configure that endpoint in shared-FIFO mode,
so that it'd support both RX and TX in high bandwidth.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
