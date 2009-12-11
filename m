From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [RFC/PATCH 1/5] usb: otg: add notifier support
Date: Fri, 11 Dec 2009 11:55:38 +0000
Message-ID: <20091211115538.GB25806@sirena.org.uk>
References: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com> <1260531086-23857-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1260531086-23857-2-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Madhusudhan Chikkature <madhu.cr-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 11, 2009 at 01:31:22PM +0200, Felipe Balbi wrote:
> The notifier will be used to communicate usb events
> to other drivers like the charger chip.

> This can be used as source of information to kick
> usb charger detection as described by the USB
> Battery Charging Specification 1.1 and/or to
> pass bMaxPower field of selected usb_configuration
> to charger chip in order to use that information
> as input current on the charging profile
> setup.

This one looks reasonable to me, though I've not thought it through
properly yet.  Could you please add me to the CC list for future
revisions of this - I've got some charger drivers that could use this?
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
