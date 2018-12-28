From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [EXTERNAL] Re: [PATCH] wlcore: Fix bringing up wlan0 again if
 powered down briefly
Date: Fri, 28 Dec 2018 12:01:00 +0100
Message-ID: <CAPDyKFoEOGACs4Wnm7UgKab2b1-7+v8+31DpC+p=8XxcQhSpcQ@mail.gmail.com>
References: <20181217164207.20081-1-tony@atomide.com> <CAPDyKFoLnNWsBfaUwqwL31J=zb0UOQjXUKi7Sj0AUsnNoC6bYg@mail.gmail.com>
 <20181218155439.GB6707@atomide.com> <CAPDyKFr2xx6fmdgjd10C1jekWg-yZPk32fGWEPO2PyexjofJ1A@mail.gmail.com>
 <20181220231401.GG6707@atomide.com> <c22e2ab61b494ea0852c0f4654fef92d@ti.com> <20181223160226.GK6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20181223160226.GK6707-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>, "Mishol, Guy" <guym-l0cyMroinI0@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ricardo Salveti <rsalveti-3fX5ma9fJBTk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sun, 23 Dec 2018 at 17:02, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>
> Hi,
>
> * Reizer, Eyal <eyalr-l0cyMroinI0@public.gmane.org> [181223 07:38]:
> > You are ok as long as the wlan_enable pin Does go down for a sufficient amount of time
> > turning the wl18xx device off.
> > The firmware can only be downloaded once after power on.
> > In between down/up you have to make sure the wlan_enable is fully going through on->off->on
> > and the wl18xx device is fully reset.
> > On power on the firmware is loaded by the driver and this will fail in case the reset didn't happen
>
> OK thanks for confirming that it's the enable pin that needs to toggle.
>
> Sounds like I need to get the wlcore pwrseq changes done and posted as
> the long term solution.

Just to make sure we are talking about the same things here. The
pwrseq thingy, is already implemented in the mmc core. When it comes
to Hikey, there is already a pwrseq node deployed in the DTB. So, we
should be fine.

Here are the MMC pwrseq bindings:
Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
Documentation/devicetree/bindings/mmc/mmc.txt

Here is the Hikey DTS file:
arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts

>
> And for a short term fix, we should just add msleep(50) for now with
> updated patch description.
>
> Does that that sound OK to everybody?

Unfortunate, that doesn't work. Because, if user space via sysfs has
prevented runtime suspend, the SDIO card never becomes power off with
a call to pm_runtime_put*(), not even after waiting 50 ms.

If we need a short term solution, I think there are two options.

1) Call pm_runtime_force_suspend() instead of pm_runtime_put*() at
"down". This makes sure the card becomes powered off. At "up", call
pm_runtime_force_resume() instead of pm_runtime_get_sync(). Because
the runtime PM usage count it > 1, at "up", pm_runtime_force_resume()
will power up the card, rather than deferring it.

The problem with 1), is if there is an ACPI PM domain attached to the
SDIO card device. Then this doesn't work. I can't tell if that is ever
the case here.

2) At "up", after the call to pm_runtime_get_sync(), add a call to
mmc_hw_reset(). This forces the mmc core to power cycle and re-init
the SDIO card. This may in some cases be a waste, as the card may
already have been power cycled, but at least we should now always be
able to re-program the firmware.

If there is no rush, I think we may consider to move away from using
runtime PM to control power for SDIO cards. Because, what we seem to
need, is a simple interface (reference counted) to power-on/off SDIO
cards.

Kind regards
Uffe
