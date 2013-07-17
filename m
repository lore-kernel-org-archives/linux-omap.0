From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 2/2] iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver
Date: Wed, 17 Jul 2013 16:47:14 +0200
Message-ID: <51E6AE72.2060008@metafoo.de>
References: <1373613482-28390-1-git-send-email-oleksandr.kozaruk@ti.com> <1373613482-28390-3-git-send-email-oleksandr.kozaruk@ti.com>,<51E05F6C.1060506@metafoo.de> <2A7ABDFCE21540479A5AEB0244A684D5E3D067@DNCE04.ent.ti.com> <51E3DE21.9060105@metafoo.de> <51E6A015.8040705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51E6A015.8040705@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "benoit.cousson@linaro.org" <benoit.cousson@linaro.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "ch.naveen@samsung.com" <ch.naveen@samsung.com>, "poeschel@lemonage.de" <poeschel@lemonage.de>, "Kim, Milo" <Milo.Kim@ti.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-dis>
List-Id: linux-omap@vger.kernel.org

On 07/17/2013 03:45 PM, Oleksandr Kozaruk wrote:
> On Mon, Jul 15, 2013 at 01:33:53PM +0200, Lars-Peter Clausen wrote:
>> On 07/15/2013 01:09 PM, Kozaruk, Oleksandr wrote:
>> [...]
>> >
>> >>> +     ret = devm_request_threaded_irq(dev, irq, NULL,
>> >>> + twl6030_gpadc_irq_handler,
>> >>> + IRQF_ONESHOT, "twl6030_gpadc", gpadc);
>> >>
>> >> You access memory in the interrupt handler which is freed before the
> interrupt
>> >> handler is freed.
>> > Thanks for pointing this. devm_* will free memory for irq after the driver
>> > is removed and memory for the device is freed. I took me awhile to
> understand
>> > this. Is there going to be something like devm_iio_device_alloc? whould
> it be helpfull?
>> >
>>
>> Yes, I think it certainly makes sense to add a devm_iio_device_alloc(), care
>> to send a patch?
> 
> Anything like this? (of course it's not a patch)
> 

No. I think you can for example use devm_regulator_get() as a template. But
instead of regulator_get() and regulator_put() use iio_device_alloc() and
iio_device_free().

> struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv)
> {
>     struct iio_dev *indio_dev;
>     size_t alloc_size;
> 
>     alloc_size = sizeof(struct iio_dev);
>     if (sizeof_priv) {
>         alloc_size = ALIGN(alloc_size, IIO_ALIGN);
>         alloc_size += sizeof_priv;
>     }
>     /* ensure 32-byte alignment of whole construct ? */
>     alloc_size += IIO_ALIGN - 1;
> 
>     indio_dev = devm_kzalloc(dev, alloc_size, GFP_KERNEL);
>     if (indio_dev) {
>         indio_dev->dev.groups = indio_dev->groups;
>         indio_dev->dev.type = &iio_device_type;
>         indio_dev->dev.bus = &iio_bus_type;
>         device_initialize(&indio_dev->dev);
>         dev_set_drvdata(&indio_dev->dev, (void *)indio_dev);
>         mutex_init(&indio_dev->mlock);
>         mutex_init(&indio_dev->info_exist_lock);
>         INIT_LIST_HEAD(&indio_dev->channel_attr_list);
> 
>         indio_dev->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
>         if (indio_dev->id < 0) {
>             /* cannot use a dev_err as the name isn't available */
>             printk(KERN_ERR "Failed to get id\n");
>             kfree(dev);
>             return NULL;
>         }
>         dev_set_name(&indio_dev->dev, "iio:device%d", indio_dev->id);
>         INIT_LIST_HEAD(&indio_dev->buffer_list);
>     }
> 
>     return indio_dev;
> }
> EXPORT_SYMBOL(devm_iio_device_alloc);
> 
> Regards,
> OK
