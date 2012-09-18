From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCH] serial: omap: Remove unnecessary checks from suspend/resume
Date: Tue, 18 Sep 2012 17:14:15 +0530
Message-ID: <CAKdam56UKpc3icL7J7+Om=5Qk_P4ckWM+XY5E+GFvXieAAxjyA@mail.gmail.com>
References: <1347968154-27997-1-git-send-email-sourav.poddar@ti.com>
	<20120918113444.GG24047@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120918113444.GG24047@arwen.pp.htv.fi>
Sender: linux-serial-owner@vger.kernel.org
To: balbi@ti.com
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, tony@atomide.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Tue, Sep 18, 2012 at 5:04 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Tue, Sep 18, 2012 at 05:05:54PM +0530, Sourav Poddar wrote:
>> Drop the check for "up" being valid on suspend/resume callbacks.
>> It should be valid always. Get rid of the "pdata" check also as
>> serial_omap_get_context_loss_count() checks for it.
>>
>> Tested on omap4 panda and 3630 based Beagle board.
>
> you need a blank line here. Other than that:
>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
>
> ps: what kind of tests did you run, btw ?
>
Boot tested on Panda.
Boot and PM tested(hitiing Off) on Beagle.
>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>> ---
>>  drivers/tty/serial/omap-serial.c |   23 +++++++++--------------
>>  1 files changed, 9 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
>> index f175385..3c05c5e 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -1222,10 +1222,8 @@ static int serial_omap_suspend(struct device *dev)
>>  {
>>       struct uart_omap_port *up = dev_get_drvdata(dev);
>>
>> -     if (up) {
>> -             uart_suspend_port(&serial_omap_reg, &up->port);
>> -             flush_work_sync(&up->qos_work);
>> -     }
>> +     uart_suspend_port(&serial_omap_reg, &up->port);
>> +     flush_work_sync(&up->qos_work);
>>
>>       return 0;
>>  }
>> @@ -1234,8 +1232,8 @@ static int serial_omap_resume(struct device *dev)
>>  {
>>       struct uart_omap_port *up = dev_get_drvdata(dev);
>>
>> -     if (up)
>> -             uart_resume_port(&serial_omap_reg, &up->port);
>> +     uart_resume_port(&serial_omap_reg, &up->port);
>> +
>>       return 0;
>>  }
>>  #endif
>> @@ -1553,17 +1551,14 @@ static int serial_omap_runtime_suspend(struct device *dev)
>>  static int serial_omap_runtime_resume(struct device *dev)
>>  {
>>       struct uart_omap_port *up = dev_get_drvdata(dev);
>> -     struct omap_uart_port_info *pdata = dev->platform_data;
>>
>> -     if (up && pdata) {
>> -                     u32 loss_cnt = serial_omap_get_context_loss_count(up);
>> +     u32 loss_cnt = serial_omap_get_context_loss_count(up);
>>
>> -                     if (up->context_loss_cnt != loss_cnt)
>> -                             serial_omap_restore_context(up);
>> +     if (up->context_loss_cnt != loss_cnt)
>> +             serial_omap_restore_context(up);
>>
>> -             up->latency = up->calc_latency;
>> -             schedule_work(&up->qos_work);
>> -     }
>> +     up->latency = up->calc_latency;
>> +     schedule_work(&up->qos_work);
>>
>>       return 0;
>>  }
>> --
>> 1.7.1
>>
>
> --
> balbi
