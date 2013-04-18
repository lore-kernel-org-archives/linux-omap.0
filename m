From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH 3/6] driver: serial: omap: add prepare/complete callback
 for "no_console_suspend" case
Date: Thu, 18 Apr 2013 17:37:48 +0530
Message-ID: <516FE214.6010008@ti.com>
References: <1366198467-6757-1-git-send-email-sourav.poddar@ti.com> <1366198467-6757-4-git-send-email-sourav.poddar@ti.com> <20130418035801.GB18349@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20130418035801.GB18349@arwen.pp.htv.fi>
Sender: linux-serial-owner@vger.kernel.org
To: balbi@ti.com
Cc: gregkh@linuxfoundation.org, tony@atomide.com, rmk+kernel@arm.linux.org.uk, khilman@linaro.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,
On Thursday 18 April 2013 09:28 AM, Felipe Balbi wrote:
> Hi,
>
> On Wed, Apr 17, 2013 at 05:04:24PM +0530, Sourav Poddar wrote:
>> @@ -1632,6 +1650,8 @@ static const struct dev_pm_ops serial_omap_dev_pm_ops = {
>>   	SET_SYSTEM_SLEEP_PM_OPS(serial_omap_suspend, serial_omap_resume)
>>   	SET_RUNTIME_PM_OPS(serial_omap_runtime_suspend,
>>   				serial_omap_runtime_resume, NULL)
>> +	.prepare        = serial_omap_prepare,
>> +	.complete       = serial_omap_complete,
> if CONFIG_PM_SLEEP isn't defined, this will break compilation.
>
True.

Then, will it not be  a better idea to add a similar macro[1] in 
include/linux/pm.h for
prepare/complete callback as it is present for suspend/resume ?.

[1]:
#ifdef CONFIG_PM_SLEEP
#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
         .suspend = suspend_fn, \
         .resume = resume_fn, \
         .freeze = suspend_fn, \
         .thaw = resume_fn, \
         .poweroff = suspend_fn, \
         .restore = resume_fn,
#else
#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
#endif



~Sourav

