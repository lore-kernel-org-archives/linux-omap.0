From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [EXTERNAL] Re: [RFT 3/6] wlcore: Add support for runtime PM
Date: Tue, 12 Jun 2018 23:42:38 -0700
Message-ID: <20180613064238.GC112168@atomide.com>
References: <20180529180605.73622-1-tony@atomide.com>
 <20180529180605.73622-4-tony@atomide.com>
 <20180531171420.GQ5705@atomide.com>
 <fe42f9d6bb744cd39e38db8f51c0b74e@ti.com>
 <20180605042000.GA5738@atomide.com>
 <20180605104404.GD5738@atomide.com>
 <b55bd6bf93eb4b7884ad05e44eded929@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b55bd6bf93eb4b7884ad05e44eded929-l0cyMroinI0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>, "Mishol, Guy" <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Hahn, Maital" <maitalm-l0cyMroinI0@public.gmane.org>, "Altshul, Maxim" <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Reizer, Eyal <eyalr-l0cyMroinI0@public.gmane.org> [180606 05:22]:
> Latest wl18xx firmware was running fine for two days without the crash, so it was indeed just a logging issue in this case.

OK good to hear.

> However, trying a wl1281 module and enabling PLT mode it boots ok but after a couple of seconds the below crash is seen.
> Seems like a similar crash to the one I have seen before,right?

Sorry for the delay, only today had enough time to figure
this one out, see below.

> sh-4.4# calibrator wlan0 plt power_mode on
> [   57.198492] wlcore: power up
> [   57.757871] wlcore: firmware booted in PLT mode PLT_ON (PLT 7.3.10.2.142)
> sh-4.4#
> sh-4.4#
> sh-4.4# ca[   86.485020] ------------[ cut here ]------------
> [   86.490334] WARNING: CPU: 0 PID: 502 at drivers/net/wireless/ti/wlcore/main.c:806

This happens on runtime_suspend() where we are already in PLT
and then that error gets stored and then next pm_runtime_get()
returns -EINVAL. The patch below should fix it. I'll fold it
into the runtime PM related patch assuming it works for you.

Regards,

Tony

8< -------
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -6677,7 +6677,7 @@ static int __maybe_unused wlcore_runtime_suspend(struct device *dev)
 
 	/* We do not enter elp sleep in PLT mode */
 	if (wl->plt)
-		return -EINVAL;
+		return 0;
 
 	/* Nothing to do if no ELP mode requested */
 	if (wl->sleep_auth != WL1271_PSM_ELP)
