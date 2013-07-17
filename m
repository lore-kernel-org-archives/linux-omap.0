From: Oleksandr Kozaruk <oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver
Date: Wed, 17 Jul 2013 12:49:40 +0300
Message-ID: <51E668B4.1010000@ti.com>
References: <1373974023-23521-1-git-send-email-oleksandr.kozaruk@ti.com> <1373974023-23521-3-git-send-email-oleksandr.kozaruk@ti.com> <c8f86766-822b-4fe3-ae2a-e0b12412ef39@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c8f86766-822b-4fe3-ae2a-e0b12412ef39-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, milo.kim-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello Jonathan,

 >Two very quick comments based on quick glance as it may be a while 
before I can do a full review.

 >We still have channels that are only usable for temperature being 
output to user space as voltage channels? Is the conversion so very hard?

Can you please clarify what should return temperature channel for 
in_tempX_input (processed)? Is it voltage or Celsius degree?
in_tempX_raw should return ADC code? Right?

Regards,
OK.
