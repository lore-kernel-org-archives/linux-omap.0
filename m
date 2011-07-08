From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: EHCI-OMAP failure following unlink
Date: Fri, 8 Jul 2011 10:42:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107081037440.2208-100000@iolanthe.rowland.org>
References: <1310122965-23612-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1310122965-23612-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: Ed Endejan <Edward.Endejan-V0pBNiWQZm+Rq8AjE7tl8g@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, gadiyar-l0cyMroinI0@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Sorry for hijacking this CC: list...

Can somebody at TI comment on these two email threads?

	http://marc.info/?t=130944419900001&r=1&w=2
	http://marc.info/?t=130866132200001&r=1&w=2

The gist of the problem is that Ed's OMAP EHCI controllers sometimes
stop working when an unlink occurs.  Other EHCI controllers have no
trouble.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
