From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1 6/6] USB: MUSB: OMAP: get PHY by phandle for dt boot
Date: Tue, 22 Jan 2013 16:38:29 +0100
Message-ID: <50FEB275.80504@ti.com>
References: <1358848694-20145-1-git-send-email-kishon@ti.com> <1358848694-20145-7-git-send-email-kishon@ti.com> <50FE9F5C.2010501@ti.com> <50FEA447.1090701@ti.com> <50FEA696.8000506@ti.com> <50FEAE96.30706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50FEAE96.30706-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kishon <kishon-l0cyMroinI0@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 01/22/2013 04:21 PM, kishon wrote:
> But it's better to check if deferred probing
> takes place whenever a new driver is bound to a device as you just me=
ntioned.

Whenever you load (might be also when you unload) a driver the deferred
modules will try to probe again. This is to check back if the dependenc=
y of
the deferred modules has been fulfilled by the new driver or not.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
