From: "Krogerus Heikki (EXT-Teleca/Helsinki)"
	<ext-heikki.krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC/PATCH 4/5] usb: musb: isp1704: add registers from isp1704
Date: Fri, 11 Dec 2009 14:35:04 +0200
Message-ID: <4B223C78.2060908@nokia.com>
References: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com> <1260531086-23857-5-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1260531086-23857-5-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Madhusudhan Chikkature <madhu.cr-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Balbi Felipe (Nokia-D/Helsinki) wrote:
> transceiver used on RX-51 board.
>
> NYET-Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> ---
>   

There are now many ULPI transceivers in use. Let's add the global ULPI 
register definitions. isp170x transceivers have only one vendor-specific 
register. The Power Control.

-- 
heikki

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
