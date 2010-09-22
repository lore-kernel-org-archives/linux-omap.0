From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 7/9 v3] OMAP: Hwmod api changes
Date: Wed, 22 Sep 2010 15:28:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009221527270.18576@utopia.booyaka.com>
References: <1285201816-26516-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-582606343-1285190877=:18576"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1285201816-26516-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Content-ID: <alpine.DEB.2.00.1009221527580.18576-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Basak, Partha" <p-basak2-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-582606343-1285190877=:18576
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1009221527581.18576-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>

Hello Hema,

On Wed, 22 Sep 2010, Hema HK wrote:

> OMAP USBOTG modules has a requirement to set the auto idle bit only after
> setting smart idle bit. Modified the _sys_enable api to set the smart idl=
e
> first and then the autoidle bit. Setting this will not have any impact on=
 the
> other modules.

Please incorporate the comments from Beno=EEt and Sergei and post this patc=
h=20
separately from your other MUSB patches, and we'll try to get it in for=20
2.6.37.


- Paul
--155748971-582606343-1285190877=:18576--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
