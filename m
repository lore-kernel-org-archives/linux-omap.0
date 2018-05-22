From: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Subject: RE: [EXTERNAL] [PATCHv2 0/5] Runtime PM support for wlcore
Date: Tue, 22 May 2018 13:26:01 +0000
Message-ID: <38ddca4c73bb4dbf835a84133035dbfb@ti.com>
References: <20180517185029.71716-1-tony@atomide.com>
 <bff51dcc6fd441d9ab42db273219aaf4@ti.com>
 <20180521163830.GZ98604@atomide.com> <20180521224339.GD98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>, "Mishol, Guy" <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Hahn, Maital" <maitalm-l0cyMroinI0@public.gmane.org>, "Altshul, Maxim" <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Loewy, Chen" <c-loewy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> >
> > 8< ------------------------
> > diff --git a/drivers/net/wireless/ti/wlcore/main.c
> > b/drivers/net/wireless/ti/wlcore/main.c
> > --- a/drivers/net/wireless/ti/wlcore/main.c
> > +++ b/drivers/net/wireless/ti/wlcore/main.c
> > @@ -1867,8 +1867,6 @@ static int __maybe_unused
> > wl1271_op_resume(struct ieee80211_hw *hw)
> >  			if (ret)
> >  				wl12xx_queue_recovery_work(wl);
> >  		}
> > -
> > -		wlcore_enable_interrupts(wl);
> >  	}
> >
> >  	if (pending_recovery) {
> > @@ -1877,6 +1875,8 @@ static int __maybe_unused
> > wl1271_op_resume(struct ieee80211_hw *hw)
> >  		goto out_sleep;
> >  	}
> >
> > +	wlcore_enable_interrupts(wl);
> > +
> >  	ret =3D pm_runtime_get_sync(wl->dev);
> >  	if (ret < 0) {
> >  		pm_runtime_put_noidle(wl->dev);
>=20
> It still crash.
> The crash is different now.
> It also complains about:
> [   60.544224] Unbalanced enable for IRQ 65
> Need down/up of the interface to recover after it.
> Log below:
>=20

Actually the below patch removing the call to wlcore_fw_sleep() avoids this=
 error.
The downside is that the wl8 firmware remains fully active during supend, s=
o we
Would need to find the root cause why the last call allowing the wilink8 fi=
rmware=20
To go into ELP mode during suspend is only completing on resume and not dur=
ing
Suspend enter.

diff --git a/drivers/net/wireless/ti/wlcore/main.c
b/drivers/net/wireless/ti/wlcore/main.c
index 4c297aa..8df1ae6 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -1789,7 +1789,6 @@ static int wl1271_op_suspend(struct ieee80211_hw *hw,
                goto out_sleep;

 out_sleep:
-       pm_runtime_put_noidle(wl->dev);
        mutex_unlock(&wl->mutex);

        if (ret < 0) {
@@ -1821,15 +1820,7 @@ static int wl1271_op_suspend(struct ieee80211_hw *hw=
,
         */
        cancel_delayed_work(&wl->tx_watchdog_work);

-       /*
-        * Use an immediate call for allowing the firmware to go into power
-        * save during suspend.
-        * Using a workque for this last write was only hapenning on resume
-        * leaving the firmware with power save disabled during suspend,
-        * while consuming full power during wowlan suspend.
-        */
-       wlcore_fw_sleep(wl);
-
+       pm_runtime_put_noidle(wl->dev);
        return 0;
 }

With this wowlan seems to work ok and suspend/resume is not crashing when=20
enabling wowlan. See below:

root@am335x-evm:/usr/share/wl18xx#
root@am335x-evm:/usr/share/wl18xx#
root@am335x-evm:/usr/share/wl18xx#
root@am335x-evm:/usr/share/wl18xx# iw phy0 wowlan enable any
root@am335x-evm:/usr/share/wl18xx#
root@am335x-evm:/usr/share/wl18xx# echo mem > /sys/power/state
[   63.794805] PM: suspend entry (deep)
[   63.798455] PM: Syncing filesystems ... done.
[   65.779673] Freezing user space processes ... (elapsed 0.001 seconds) do=
ne.
[   65.788878] OOM killer disabled.
[   65.792117] Freezing remaining freezable tasks ... (elapsed 0.001 second=
s) done.
[   65.801196] Suspending console(s) (use no_console_suspend to debug)
[   65.952459] pm33xx pm33xx: PM: Successfully put all powerdomains to targ=
et state
[   65.952459] PM: Wakeup source GPIO0
[   65.977028] net eth0: initializing cpsw version 1.12 (0)
[   66.074419] SMSC LAN8710/LAN8720 4a101000.mdio:00: attached PHY driver [=
SMSC LAN8710/LAN8720] (mii_bus:phy_addr=3D4a101000.mdio:00, irq=3DPOLL)
[   66.236312] OOM killer enabled.
[   66.239604] Restarting tasks ... done.
[   66.282501] PM: suspend exit
root@am335x-evm:/usr/share/wl18xx#

BR,
Eyal
