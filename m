From: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] omap: i2c: Add calls for pinctrl state select
Date: Tue, 28 Apr 2015 13:05:14 +0200
Message-ID: <553F696A.8060408@gmail.com>
References: <1429693667-28942-1-git-send-email-pascal.huerst@gmail.com> <55383D9A.4020302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55383D9A.4020302-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On 23.04.2015 02:32, Nishanth Menon wrote:
> few nitpicks:
> i2c: omap:  in $subject instead of omap: i2c:
> I usually would do:
> git log --no-merges --oneline drivers/i2c/busses/i2c-omap.c
> and look for common usage.

Aargh, thanks for pointing that out, I'll fix that.

> On 04/22/2015 04:07 AM, pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>> From: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> This adds calls to pinctrl subsystem in order to switch pin states
>> on suspend/resume if you provide a "sleep" state in DT.
>>
>> Signed-off-by: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/i2c/busses/i2c-omap.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index 0e89419..8261941 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -38,6 +38,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/i2c-omap.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/pinctrl/consumer.h>
>>
>>  /* I2C controller revisions */
>>  #define OMAP_I2C_OMAP1_REV_2		0x20
>> @@ -1423,6 +1424,8 @@ static int omap_i2c_runtime_suspend(struct device *dev)
>>  		omap_i2c_read_reg(_dev, OMAP_I2C_STAT_REG);
>>  	}
>>
>> +	pinctrl_pm_select_sleep_state(dev);
>> +
>>  	return 0;
>>  }
>>
>> @@ -1431,6 +1434,8 @@ static int omap_i2c_runtime_resume(struct device *dev)
>>  	struct platform_device *pdev = to_platform_device(dev);
>>  	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
>>
>> +	pinctrl_pm_select_default_state(dev);
>> +
>>  	if (!_dev->regs)
>>  		return 0;
>>
>> --
>> 2.1.0
>>
> Build tested with omap2plus_defconfig on linus master (27cf3a16b253)
> and next-20150422
> While I do understand that the sleep state and default states are
> optional - might be nice to state it in commit message (as a result of
> which we dont do error checks).

Thanks for testing. I'll fix the commit message and send in v3.

> Would you think adding relevant documentation in
> Documentation/devicetree/bindings/i2c/i2c-omap.txt might be good as
> well? I mean, folks should know looking at dt documentation that this
> bus driver does indeed support this option..

I'm not sure about that. Actually this is all handled by the pinctrl
subsystem, so I would guess that documentation belongs there, since in:

Documentation/devicetree/bindings/i2c/i2c-at91.txt
Documentation/devicetree/bindings/i2c/i2c-nomadik.txt

is no documentation about that as well. But there is documentation in:

Documentation/pinctrl.txt

right? Otherwise, I would say we should add documentation for all
devices, so it is consistent.
