From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/2] ARM: dts: Use MMC pwrseq instead regulators for IGEP
 WiFi init
Date: Mon, 7 Dec 2015 16:14:06 -0800
Message-ID: <20151208001406.GS23396@atomide.com>
References: <1449165729-993-1-git-send-email-javier@osg.samsung.com>
 <20151203181624.GW23396@atomide.com>
 <566089E1.7050805@osg.samsung.com>
 <20151203192719.GZ23396@atomide.com>
 <CAFqH_536_sG7fju=u39aMKmzXt8KDCxU1-dFM03H060zbh5qxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFqH_536_sG7fju=u39aMKmzXt8KDCxU1-dFM03H060zbh5qxw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, =?utf-8?Q?Agust=C3=AD?= Fontquerni i Gorchs <afontquerni-VIneJrwqLopBDgjK7y7TUQ@public.gmane.org>, Pau Pajuel <ppajuel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [151204 06:40]:
> 2015-12-03 20:27 GMT+01:00 Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
> > * Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org> [151203 10:29]:
> >
> >> Since is working for the boards with the libertas chip, I preferred
> >> to remove the DTS hack but left the boards with wlcore chip since
> >> you said the startup-delay-us is needed there (but probably we should
> >> add to the regulators in the boards that don't have it then).
> >
> > OK
> 
> I guess will be interesting cc'ing the ISEE people. Added Agusti and Pau.

Applying these both into omap-for-v4.5/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
