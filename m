From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: PATCH V4 1/2] input: CMA3000 Accelerometer Driver
Date: Tue, 30 Nov 2010 17:05:53 +0000
Message-ID: <4CF52EF1.3050000@cam.ac.uk>
References: <37129.10.24.255.17.1291028260.squirrel@dbdmail.itg.ti.com> <4CF38E4D.3070309@cam.ac.uk> <20101130075911.GC15731@core.coreip.homeip.net> <5B8D58FB9E1C487FA94F2498E0B9E9AB@wipblrx0099946>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <5B8D58FB9E1C487FA94F2498E0B9E9AB@wipblrx0099946>
Sender: linux-input-owner@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, saaguirre@ti.com, Shubhrajyoti@ti.com
List-Id: linux-omap@vger.kernel.org

On 11/30/10 12:50, Hemanth V wrote:
> ----- Original Message ----- From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
>>
>> Yep, almost there.
>>
>> Hemanth, does the driver still work if you apply the patch below?
> 
> Yes works pretty well, Thanks for your efforts
> 
> Some minor changes as below required.
> 
> <snip>
> 
>> +struct cma3000_accl_data {
>> + const struct cma3000_bus_ops *bus_ops;
>> + const struct cma3000_platform_data *pdata;
>> +
>> + struct device *dev;
>> + struct input_dev *input_dev;
>> +
>> + int bit_to_mg;
>> + int irq;
>> +
>> + int g_range;
>> + u8 mode;
>> +
>> + struct mutex mutex;
> 
> Need a comment to overcome checkpatch warning.
> 
>>
>> - pr_info("CMA3000 Accelerometer : Revision %x\n", ret);
>> + data->dev = dev;
>> + data->input_dev = input_dev;
>> + data->bus_ops = bops;
>> + data->pdata = pdata;
> 
> Need to add data->irq = irq, else exit routine will dump stack
> 
>>
>> - data->input_dev->name = "cma3000-accelerometer";
>> + data->g_range = pdata->g_range;
>> + if (data->g_range != CMARANGE_2G && data->g_range != CMA3000_RANGE8G) {
> 
> Need to change this to "data->g_range != CMARANGE_2G   && data->g_range != CMARANGE_8G "
> 
>> - input_set_abs_params(data->input_dev, ABS_Z, -g_range,
>> - g_range, fuzz_z, 0);
>> - input_set_abs_params(data->input_dev, ABS_MISC, 0,
>> - 1, 0, 0);
> 
> We use this ABS_MISC event to report free fall.
Free fall isn't a conventional user input...  The lis3 driver
and similar (currently hiding in hwmon)
handle this via a separately registered chrdev.  It might not
be the best plan, but it is an existing interface so we need to
involve them in any discussion if you want to change it.


> 
> 
> 
> 

