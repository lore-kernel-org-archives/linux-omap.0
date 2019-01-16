From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2] wlcore: sdio: Fixup power on/off sequence
Date: Wed, 16 Jan 2019 16:48:40 +0100
Message-ID: <CAPDyKFpAc=xSsLKgMm-2H4WkD34ieRS91wH4GbwD=GH01-pt3A@mail.gmail.com>
References: <20190116113723.15668-1-ulf.hansson@linaro.org> <20190116154311.GP5544@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20190116154311.GP5544-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ricardo Salveti <rsalveti-3fX5ma9fJBTk1uMJSBkQmQ@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 16 Jan 2019 at 16:43, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>
> * Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [190116 11:37]:
> > During "wlan-up", we are programming the FW into the WiFi-chip. However,
> > re-programming the FW doesn't work, unless a power cycle of the WiFi-chip
> > is made in-between the programmings.
> >
> > To conform to this requirement and to fix the regression in a simple way,
> > let's start by allowing that the SDIO card (WiFi-chip) may stay powered on
> > (runtime resumed) when wl12xx_sdio_power_off() returns. The intent with the
> > current code is to treat this scenario as an error, but unfortunate this
> > doesn't work as expected, so let's fix this.
> >
> > The other part is to guarantee that a power cycle of the SDIO card has been
> > completed when wl12xx_sdio_power_on() returns, as to allow the FW
> > programming to succeed. However, relying solely on runtime PM to deal with
> > this isn't sufficient. For example, userspace may prevent runtime suspend
> > via sysfs for the device that represents the SDIO card, leading to that the
> > mmc core also keeps it powered on. For this reason, let's instead do a
> > brute force power cycle in wl12xx_sdio_power_on().
> >
> > Fixes: 728a9dc61f13 ("wlcore: sdio: Fix flakey SDIO runtime PM handling")
> > Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > ---
> >
> > Changes in v2:
> >       - Keep the SDIO host claimed when calling mmc_hw_reset().
> >       - Add a fixes tag.
>
> This v2 version works for me as tested with:
>
> # while [ 1 ]; do ifconfig wlan0 down; ifconfig wlan0 up; done
> [  181.364990] wlcore: down
> [  182.116424] wlcore: firmware booted (Rev 6.3.10.0.141)
> [  182.151641] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
> [  182.166778] wlcore: down
> [  182.773132] wlcore: firmware booted (Rev 6.3.10.0.141)
> [  182.811096] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
> ...
>
> Thanks for fixing this issue properly, and feel free to add:
>
> Tested-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Thanks for testing, great news!

Before queuing this as fix, let's also see what the Hikey folkz thinks
of this. I have pinged Anders and he is currently running a test
suite.

Kalle, can you please tag this for stable as well?

Kind regards
Uffe
