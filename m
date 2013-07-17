From: Oleksandr Kozaruk <oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 2/2] iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver
Date: Wed, 17 Jul 2013 16:45:57 +0300
Message-ID: <51E6A015.8040705@ti.com>
References: <1373613482-28390-1-git-send-email-oleksandr.kozaruk@ti.com> <1373613482-28390-3-git-send-email-oleksandr.kozaruk@ti.com>,<51E05F6C.1060506@metafoo.de> <2A7ABDFCE21540479A5AEB0244A684D5E3D067@DNCE04.ent.ti.com> <51E3DE21.9060105@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51E3DE21.9060105-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Nayak, Rajendra" <rnayak-l0cyMroinI0@public.gmane.org>, "Ujfalusi, Peter" <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, "jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org" <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org" <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>, "Kim, Milo" <Milo.Kim-l0cyMroinI0@public.gmane.org>, "Krishnamoorthy, Balaji T" <balajitk-l0cyMroinI0@public.gmane.org>, "gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-dis>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 15, 2013 at 01:33:53PM +0200, Lars-Peter Clausen wrote:
 > On 07/15/2013 01:09 PM, Kozaruk, Oleksandr wrote:
 > [...]
 > >
 > >>> +     ret = devm_request_threaded_irq(dev, irq, NULL,
 > >>> + twl6030_gpadc_irq_handler,
 > >>> + IRQF_ONESHOT, "twl6030_gpadc", gpadc);
 > >>
 > >> You access memory in the interrupt handler which is freed before 
the interrupt
 > >> handler is freed.
 > > Thanks for pointing this. devm_* will free memory for irq after the 
driver
 > > is removed and memory for the device is freed. I took me awhile to 
understand
 > > this. Is there going to be something like devm_iio_device_alloc? 
whould it be helpfull?
 > >
 >
 > Yes, I think it certainly makes sense to add a 
devm_iio_device_alloc(), care
 > to send a patch?

Anything like this? (of course it's not a patch)

struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv)
{
     struct iio_dev *indio_dev;
     size_t alloc_size;

     alloc_size = sizeof(struct iio_dev);
     if (sizeof_priv) {
         alloc_size = ALIGN(alloc_size, IIO_ALIGN);
         alloc_size += sizeof_priv;
     }
     /* ensure 32-byte alignment of whole construct ? */
     alloc_size += IIO_ALIGN - 1;

     indio_dev = devm_kzalloc(dev, alloc_size, GFP_KERNEL);
     if (indio_dev) {
         indio_dev->dev.groups = indio_dev->groups;
         indio_dev->dev.type = &iio_device_type;
         indio_dev->dev.bus = &iio_bus_type;
         device_initialize(&indio_dev->dev);
         dev_set_drvdata(&indio_dev->dev, (void *)indio_dev);
         mutex_init(&indio_dev->mlock);
         mutex_init(&indio_dev->info_exist_lock);
         INIT_LIST_HEAD(&indio_dev->channel_attr_list);

         indio_dev->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
         if (indio_dev->id < 0) {
             /* cannot use a dev_err as the name isn't available */
             printk(KERN_ERR "Failed to get id\n");
             kfree(dev);
             return NULL;
         }
         dev_set_name(&indio_dev->dev, "iio:device%d", indio_dev->id);
         INIT_LIST_HEAD(&indio_dev->buffer_list);
     }

     return indio_dev;
}
EXPORT_SYMBOL(devm_iio_device_alloc);

Regards,
OK
