From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v3 2/2] iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver
Date: Mon, 15 Jul 2013 13:33:53 +0200
Message-ID: <51E3DE21.9060105@metafoo.de>
References: <1373613482-28390-1-git-send-email-oleksandr.kozaruk@ti.com> <1373613482-28390-3-git-send-email-oleksandr.kozaruk@ti.com>,<51E05F6C.1060506@metafoo.de> <2A7ABDFCE21540479A5AEB0244A684D5E3D067@DNCE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2A7ABDFCE21540479A5AEB0244A684D5E3D067-bXo5r3zvlxeIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Kozaruk, Oleksandr" <oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>
Cc: "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Nayak, Rajendra" <rnayak-l0cyMroinI0@public.gmane.org>, "Ujfalusi, Peter" <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, "jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org" <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org" <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>, "Kim, Milo" <Milo.Kim-l0cyMroinI0@public.gmane.org>, "Krishnamoorthy, Balaji T" <balajitk-l0cyMroinI0@public.gmane.org>, "gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-dis>
List-Id: linux-omap@vger.kernel.org

On 07/15/2013 01:09 PM, Kozaruk, Oleksandr wrote:
[...]
> 
>>> +     ret = devm_request_threaded_irq(dev, irq, NULL,
>>> +                                     twl6030_gpadc_irq_handler,
>>> +                                     IRQF_ONESHOT, "twl6030_gpadc", gpadc);
>>
>> You access memory in the interrupt handler which is freed before the interrupt
>> handler is freed.
> Thanks for pointing this. devm_* will free memory for irq after the driver
> is removed and memory for the device is freed. I took me awhile to understand
> this. Is there going to be something like devm_iio_device_alloc? whould it be helpfull?
> 

Yes, I think it certainly makes sense to add a devm_iio_device_alloc(), care
to send a patch?
