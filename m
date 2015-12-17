From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 09/19] ARM: dts: am335x: replace gpio-key,wakeup with
 wakeup-source property
Date: Thu, 17 Dec 2015 09:58:13 -0800
Message-ID: <20151217175812.GU23396@atomide.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-10-git-send-email-sudeep.holla@arm.com>
 <567040E7.7060308@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <567040E7.7060308-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org> [151215 08:33]:
>=20
>=20
> On 21/10/15 11:10, Sudeep Holla wrote:
> >Though the keyboard driver for GPIO buttons(gpio-keys) will continue=
 to
> >check for/support the legacy "gpio-key,wakeup" boolean property to
> >enable gpio buttons as wakeup source, "wakeup-source" is the new
> >standard binding.
> >
> >This patch replaces the legacy "gpio-key,wakeup" with the unified
> >"wakeup-source" property in order to avoid any futher copy-paste
> >duplication.
> >
> >Cc: "Beno=C3=AEt Cousson" <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> >Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>=20
> Ping, do you prefer taking via your tree or should I send to armsoc
> directly ?

Sorry I did not realized you're waiting for me to pick this one,
applying into omap-for-v4.5/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
