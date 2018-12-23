From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [EXTERNAL] Re: [PATCH] wlcore: Fix bringing up wlan0 again if
 powered down briefly
Date: Sun, 23 Dec 2018 08:02:26 -0800
Message-ID: <20181223160226.GK6707@atomide.com>
References: <20181217164207.20081-1-tony@atomide.com>
 <CAPDyKFoLnNWsBfaUwqwL31J=zb0UOQjXUKi7Sj0AUsnNoC6bYg@mail.gmail.com>
 <20181218155439.GB6707@atomide.com>
 <CAPDyKFr2xx6fmdgjd10C1jekWg-yZPk32fGWEPO2PyexjofJ1A@mail.gmail.com>
 <20181220231401.GG6707@atomide.com>
 <c22e2ab61b494ea0852c0f4654fef92d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c22e2ab61b494ea0852c0f4654fef92d-l0cyMroinI0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>, "Mishol, Guy" <guym-l0cyMroinI0@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ricardo Salveti <rsalveti-3fX5ma9fJBTk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Reizer, Eyal <eyalr-l0cyMroinI0@public.gmane.org> [181223 07:38]:
> You are ok as long as the wlan_enable pin Does go down for a sufficient amount of time 
> turning the wl18xx device off.
> The firmware can only be downloaded once after power on.
> In between down/up you have to make sure the wlan_enable is fully going through on->off->on 
> and the wl18xx device is fully reset. 
> On power on the firmware is loaded by the driver and this will fail in case the reset didn't happen

OK thanks for confirming that it's the enable pin that needs to toggle.

Sounds like I need to get the wlcore pwrseq changes done and posted as
the long term solution.

And for a short term fix, we should just add msleep(50) for now with
updated patch description.

Does that that sound OK to everybody?

Regards,

Tony
