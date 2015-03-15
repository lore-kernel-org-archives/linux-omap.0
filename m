From: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 0/6] wlcore: add device-tree support
Date: Sun, 15 Mar 2015 10:58:45 +0200
Message-ID: <CAB3XZEc0FOayfmrWvD-aq0Ez987G4JFkvHxO-ttF48z_F=_9Vg@mail.gmail.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
	<55030C42.6020206@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55030C42.6020206-d2DlULPkwbNWk0Htik3J/w@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org>
Cc: "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Julien Boibessot <julien.boibessot-d2DlULPkwbNWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

hi S=C3=A9bastien,

On Fri, Mar 13, 2015 at 6:11 PM, S=C3=A9bastien Szymanski
<sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org> wrote:
> Hello,
>
> On 03/12/2015 01:09 PM, Eliad Peller wrote:
>>
>> NOTE: all the platform patches were compile-tested
>> only. I'm looking for some wl12xx card (that i should
>> have somewhere) to test the wl12xx changes (wrt. clocks),
>> but haven't found it yet.
>>
>
> I have tested this series on a APF6 board, i.MX6 based board with a
> Jorjin WG7311-0A Wifi/BT module which is based on the wl1271l.
>
> It works. I was able to power up the wlan0 interface and ping google.
>
thanks for testing it!

Eliad.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
