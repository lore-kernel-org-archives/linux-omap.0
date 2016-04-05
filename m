From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] iio: light: new driver for the ROHM BH1780
Date: Tue, 5 Apr 2016 09:50:23 +0200
Message-ID: <CACRpkdbi=big65-yMXXipE1i_YSDo=7BMWDohXcVCpwSi5HMPg@mail.gmail.com>
References: <1459326847-9444-1-git-send-email-linus.walleij@linaro.org>
	<5700E7AF.6040903@kernel.org>
	<CACRpkdYkqzvu_fMcDPy8i0OCpGdGQ39S534HbCQL8T93gadKmQ@mail.gmail.com>
	<20160404074239.GT7800@tbergstrom-lnx.Nvidia.com>
	<20160404223546.GC8755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160404223546.GC8755-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 5, 2016 at 12:35 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> Adding linux-omap to Cc. I suggest do a minimal patch to remove the
> sysfs interface, then revert the patch if needed. I don't think
> people are using it.

The old driver in misc is just using sysfs for everything, so removing the
sysfs is like deleting the driver. Once the IIO driver is merged I guess
I'll boldly post a patch to delete it and then a patch to activate the new
driver in the OMAP defconfig.

Yours,
Linus Walleij
