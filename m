From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH 3/5] omap-serial: Fix the error handling in the omap_serial
 probe
Date: Fri, 10 Feb 2012 11:30:05 +0530
Message-ID: <4F34B265.3040304@ti.com>
References: <1326709360-26020-1-git-send-email-shubhrajyoti@ti.com> <1326709360-26020-4-git-send-email-shubhrajyoti@ti.com> <CAAL8m4xVOiGjOHvf=Uy4m9QbqxO21pFeB2HcC_zGijj-+VF_jw@mail.gmail.com> <4F19354A.4040707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <4F19354A.4040707@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Friday 20 January 2012 03:05 PM, Shubhrajyoti wrote:
> On Friday 20 January 2012 02:19 PM, Govindraj wrote:
>> On Mon, Jan 16, 2012 at 3:52 PM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
>>> The patch does the following
>>>
>>> - The pm_runtime_disable is called in the remove not in the error
>>>  case of probe.The patch calls the pm_runtime_disable in the error
>>>  case.
>>> - The  up is not freed in the error path. Fix the memory leak by calling
>>>  kfree in the error path.
>>> - Also the iounmap is not called fix the same by calling iounmap in the
>>>  error case of probe and remove .
>>> - Make the name of the error tags more meaningful.
>>>
>>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>>> ---
>>>  drivers/tty/serial/omap-serial.c |   27 +++++++++++++++++----------
>>>  1 files changed, 17 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
>>> index 1c24269..8c6f137 100644
>>> --- a/drivers/tty/serial/omap-serial.c
>>> +++ b/drivers/tty/serial/omap-serial.c
>>> @@ -1369,14 +1369,14 @@ static int serial_omap_probe(struct platform_device *pdev)
>>>
>>>        dma_rx = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
>>>        if (!dma_rx) {
>>> -               ret = -EINVAL;
>>> -               goto err;
>>> +               ret = -ENXIO;
>>> +               goto do_release_region;
>>>        }
>>>
>>>        dma_tx = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
>>>        if (!dma_tx) {
>>> -               ret = -EINVAL;
>>> -               goto err;
>>> +               ret = -ENXIO;
>>> +               goto do_release_region;
>>>        }
>>>
>>>        up = kzalloc(sizeof(*up), GFP_KERNEL);
>>> @@ -1403,7 +1403,7 @@ static int serial_omap_probe(struct platform_device *pdev)
>>>                dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n",
>>>                                                                up->port.line);
>>>                ret = -ENODEV;
>>> -               goto err;
>>> +               goto err_port_line;
>>>        }
>>>
>>>        sprintf(up->name, "OMAP UART%d", up->port.line);
>>> @@ -1412,7 +1412,7 @@ static int serial_omap_probe(struct platform_device *pdev)
>>>        if (!up->port.membase) {
>>>                dev_err(&pdev->dev, "can't ioremap UART\n");
>>>                ret = -ENOMEM;
>>> -               goto err;
>>> +               goto err_ioremap;
>>>        }
>>>
>>>        up->port.flags = omap_up_info->flags;
>>> @@ -1458,16 +1458,22 @@ static int serial_omap_probe(struct platform_device *pdev)
>>>
>>>        ret = uart_add_one_port(&serial_omap_reg, &up->port);
>>>        if (ret != 0)
>>> -               goto do_release_region;
>>> +               goto err_add_port;
>>>
>>>        pm_runtime_put(&pdev->dev);
>>>        platform_set_drvdata(pdev, up);
>>>        return 0;
>>> -err:
>>> -       dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
>>> -                               pdev->id, __func__, ret);
>>> +
>>> +err_add_port:
>>> +       pm_runtime_disable(&pdev->dev);
>>> +       iounmap(up->port.membase);
>>> +err_ioremap:
>>> +err_port_line:
>>> +       kfree(up);
>>>  do_release_region:
>>>        release_mem_region(mem->start, resource_size(mem));
>>> +       dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
>>> +                               pdev->id, __func__, ret);
>>>        return ret;
>>>  }
>>>
>>> @@ -1476,6 +1482,7 @@ static int serial_omap_remove(struct platform_device *dev)
>>>        struct uart_omap_port *up = platform_get_drvdata(dev);
>>>
>>>        if (up) {
>>> +               iounmap(up->port.membase);
>> you can build omap-serial as module insmod and rmmod
>> the module and test this patch.
>>
>> This can be done on zoom board which uses a non-omap uart
>> as console.
> Yes will do that and post another version.
yes , there was a missing memory release just tested with that patch.

thanks,
>> --
>> Thanks,
>> Govindraj.R

