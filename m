From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/2] TWL: USB: Start using twl4030/5030 regulator driver
Date: Tue, 10 Feb 2009 23:23:30 -0800
Message-ID: <200902102323.30395.david-b@pacbell.net>
References: <> <1234336002-26372-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1234336002-26372-1-git-send-email-kalle.jokiniemi-sMOQStClEysAvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Jokiniemi <kalle.jokiniemi-sMOQStClEysAvxtiuMwx3w@public.gmane.org>
Cc: lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jouni.hogander-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 10 February 2009, Kalle Jokiniemi wrote:
> These couple of patches enable dynamic swithcing of the
> regulators used by twl4030 usb tranceiver.
> 
> This set replaces the single patch "USB: disable twl4030
> USB regulators when cable unplugged" sent previously.
> The change to previous version is that possible errors
> in regulator_get are now handled and the twl4030 usb
> driver requires TWL_REGULATOR support to be compiled.

It'd make more sense to me as a single patch ... :)

And also, instead of *continuing* after the regulators
can't be acquired, it's better to abort.  It's not
going to be able to do anything ... so don't finish
probing, and don't register this "dead" transceiver.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
