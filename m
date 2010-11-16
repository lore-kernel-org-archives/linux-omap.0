From: Grant Erickson <marathon96@gmail.com>
Subject: Re: [PATCH] Add OMAP Support for Generic PWM Devices using Dual-mode
 Timers
Date: Tue, 16 Nov 2010 11:11:34 -0800
Message-ID: <C9081766.1FEE4%marathon96@gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB5930247387A4A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38983 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755972Ab0KPTLo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 14:11:44 -0500
Received: by gxk23 with SMTP id 23so593701gxk.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Nov 2010 11:11:43 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930247387A4A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 11/16/10 10:54 AM, Premi, Sanjeev wrote:
> [sp] pr_info(), dev_info() are already macros - conditional to DEBUG.
>      We should use them instead of defining another layer.

The macros pr_devel, pr_dbg, and dev_dbg are so conditionalized; however,
*_info are straight pass-throughs to printk and dev_printk, respectively.

>> +struct pwm_device {
>> + struct list_head       head;
>> + struct platform_device     *pdev;
>> + struct omap_dm_timer     *dm_timer;
>> + struct omap2_pwm_platform_config   config;
>> + const char      
>>   *label;
>> + unsigned int        use_count;
>> + unsigned int        pwm_id;
>> +};
> 
> [sp] This block has mix of tabs and white spaces. We should be consistent.
>      There are similar instances below as well...
> 
>      You may also want to line up the field names - they start at different
> columns.

Will do. Oddly, these sailed through checkpatch.pl.

>> +int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
>> +{
>> + int status = 0;
>> + const bool enable = true;
>> + const bool autoreload = true;
>> + const bool toggle = true;
>> + const int trigger = OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE;
> 
> [sp] Based on code abobe, I believe that OMAP...COMPARE is macro;
>      shouldn't we use it as is - where trigger is used in code below?

We certainly could; however, I found the above constants to make the code
far more self-documenting.

>> + if (pdata == NULL) {
>> +  dev_err(&pdev->dev, "Could not find required
>> platform data.\n");
>> +  status = -ENOENT;
>> +  goto done;
> 
> [sp] We can simply return status from here. goto and label can be avoided.
> 
>> + }
>> +
>> + /* Allocate memory for the driver-private PWM data and state */
>> +
>> + pwm = kzalloc(sizeof(struct pwm_device), GFP_KERNEL);
>> +
>> + if (pwm == NULL) {
>> +  dev_err(&pdev->dev, "Could not allocate memory.\n");
>> +  status = -ENOMEM;
>> +  goto done;
> 
> [sp] We can simply return status from here. goto and label can be avoided.

We certainly can; however, I prefer to code my functions so there's a single
exit point or block, even if it's a trivial return. See chapter 7 in
Documentation/CodingStyle.txt.

Thanks for your feedback and comments.

Regards,

Grant


