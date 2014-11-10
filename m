From: =?koi8-r?B?5dfHxc7JyiDwz8zRy8/X?= <zbr-i6C2adt8DTjR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] w1: omap-hdq: support device probing with device-tree.
Date: Mon, 10 Nov 2014 03:10:04 +0300
Message-ID: <17841415578204@web5g.yandex.ru>
References: <20141108103032.5426db7a@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141108103032.5426db7a-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi

08.11.2014, 02:30, "NeilBrown" <neilb-l3A5Bk7waGM@public.gmane.org>:
> This driver has no 'compatible' string and so is not found when
> using device-tree.
>
> Add one with value to match
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Ahdqw1w: 1w@480b2000 {
> device in omap3.dtsi.
>
> Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>

Looks good to me
Acked-by: Evgeniy Polyakov <zbr-i6C2adt8DTjR7s880joybQ@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
