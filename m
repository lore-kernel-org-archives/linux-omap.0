From: Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] ti_tscadc: Update with IIO map interface & deal with partial activation
Date: Mon,  6 May 2013 14:48:57 +0200
Message-ID: <1367844539-6812-1-git-send-email-jlu@pengutronix.de>
References: <1351698938-3839-1-git-send-email-panto@antoniou-consulting.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1351698938-3839-1-git-send-email-panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Cc: rachna-l0cyMroinI0@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Pantelis,

while trying out your patch on a custom AM335x board, I noticed that the
sysfs entries ware missing. This is fixed in the first patch, you might want
to squash that into your original patch.

The second one makes sure that the iio framework does not read invalid data.

Regards,
Jan
