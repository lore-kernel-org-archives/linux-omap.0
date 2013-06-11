From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 04/22] input/ti_am33x_tsc: Order of TSC wires, made configurable
Date: Tue, 11 Jun 2013 16:35:56 +0200
Message-ID: <51B735CC.9080909@linutronix.de>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de> <1370950268-7224-5-git-send-email-bigeasy@linutronix.de> <20130611142324.GD29135@zurbaran>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20130611142324.GD29135@zurbaran>
Sender: linux-input-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, "Patil, Rachna" <rachna@ti.com>
List-Id: linux-omap@vger.kernel.org

On 06/11/2013 04:23 PM, Samuel Ortiz wrote:
> Hi Sebastian,

Hi Samuel,

> On Tue, Jun 11, 2013 at 01:30:50PM +0200, Sebastian Andrzej Siewior wrote:
>> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
>> index eeead15..2d78af8 100644
>> --- a/include/linux/mfd/ti_am335x_tscadc.h
>> +++ b/include/linux/mfd/ti_am335x_tscadc.h
>> @@ -116,6 +113,13 @@
>>  #define CNTRLREG_8WIRE		CNTRLREG_AFE_CTRL(3)
>>  #define CNTRLREG_TSCENB		BIT(7)
>>  
>> +#define XPP			STEPCONFIG_XPP
>> +#define XNP			STEPCONFIG_XNP
>> +#define XNN			STEPCONFIG_XNN
>> +#define YPP			STEPCONFIG_YPP
>> +#define YPN			STEPCONFIG_YPN
>> +#define YNN			STEPCONFIG_YNN
> What is that for ? Isn't STEPCONFIG_XPP explicit enough ?

Yeah :P It was added by the original author of the patch, I have no
problem getting rid of it.

> 
> Cheers,
> Samuel.

Sebastian
