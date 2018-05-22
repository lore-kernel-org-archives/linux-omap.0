From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [EXTERNAL] [PATCHv2 0/5] Runtime PM support for wlcore
Date: Tue, 22 May 2018 06:55:11 -0700
Message-ID: <20180522135511.GI98604@atomide.com>
References: <20180517185029.71716-1-tony@atomide.com>
 <bff51dcc6fd441d9ab42db273219aaf4@ti.com>
 <20180521163830.GZ98604@atomide.com>
 <20180521224339.GD98604@atomide.com>
 <38ddca4c73bb4dbf835a84133035dbfb@ti.com>
 <20180522133158.GE98604@atomide.com>
 <eae7c720c09549f0b4ff83f88ad6959b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <eae7c720c09549f0b4ff83f88ad6959b-l0cyMroinI0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>, "Mishol, Guy" <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Hahn, Maital" <maitalm-l0cyMroinI0@public.gmane.org>, "Altshul, Maxim" <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Loewy, Chen" <c-loewy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Reizer, Eyal <eyalr-l0cyMroinI0@public.gmane.org> [180522 13:50]:
> > 
> > OK try replacing the pm_runtime_put_noidle() above with just
> > pm_runtime_put_sync(). The reason why I put noidle there was the
> > wlcore_fw_sleep() call, with that gone put_sync should do the trick.
> > 
> 
> I have tried that already. Same problem. The last call to:
> ret = wlcore_raw_write32(wl, HW_ACCESS_ELP_CTRL_REG, ELPCTRL_SLEEP)
> 
> which allows the firmware to get into ELP state during wowlan suspend is 
> only completing after system resume for some unknown reason...

Hmm maybe try also adding wl1271_power_off(wl) after put_sync()?

Regards,

Tony
