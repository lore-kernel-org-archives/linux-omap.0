From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [EXTERNAL] [PATCHv2 0/5] Runtime PM support for wlcore
Date: Tue, 22 May 2018 06:50:39 -0700
Message-ID: <20180522135039.GH98604@atomide.com>
References: <20180517185029.71716-1-tony@atomide.com>
 <bff51dcc6fd441d9ab42db273219aaf4@ti.com>
 <20180521163830.GZ98604@atomide.com>
 <20180521224339.GD98604@atomide.com>
 <3793c7c0d2b140389c7b92a407125650@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3793c7c0d2b140389c7b92a407125650-l0cyMroinI0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>, "Mishol, Guy" <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Hahn, Maital" <maitalm-l0cyMroinI0@public.gmane.org>, "Altshul, Maxim" <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Loewy, Chen" <c-loewy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Reizer, Eyal <eyalr-l0cyMroinI0@public.gmane.org> [180522 06:42]:
> It still crash.
> The crash is different now.
> It also complains about:
> [   60.544224] Unbalanced enable for IRQ 65
> Need down/up of the interface to recover after it.

Oh OK so no need for this patch and interrupts are already
enabled at that point. Sounds like you found the real reason
with the patch you posted.

Regards,

Tony
