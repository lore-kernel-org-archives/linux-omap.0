From: Ilkka Koskinen <ikoskine@nokia.com>
Subject: Re: [Resend PATCH 2/2] twl4030: Enable low-power mode to 32kHz
 oscillator
Date: Thu, 22 Oct 2009 14:05:32 +0300 (EEST)
Message-ID: <alpine.DEB.2.00.0910221346030.3792@tumpelo.ntc.nokia.com>
References: <1256044973-14548-1-git-send-email-ilkka.koskinen@nokia.com> <1256044973-14548-2-git-send-email-ilkka.koskinen@nokia.com> <20091021221718.GB17796@sortiz.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754724AbZJVLGc@vger.kernel.org>
In-Reply-To: <20091021221718.GB17796@sortiz.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Hi Samuel,

On Thu, 22 Oct 2009, ext Samuel Ortiz wrote:
> On Tue, Oct 20, 2009 at 04:22:53PM +0300, Ilkka Koskinen wrote:
>> +struct twl4030_clock_init_data {
>> +     int ck32k_lowpwr_enable;
> I guess you could use a bool here ?

Good point. I'll change it.

Cheers, Ilkka

>> +};
>> +
>>  struct twl4030_bci_platform_data {
>>       int *battery_tmp_tbl;
>>       unsigned int tblsize;
>> @@ -403,6 +407,7 @@ extern void twl4030_power_init(struct twl4030_power_data *triton2_scripts);
>>
>>  struct twl4030_platform_data {
>>       unsigned                                irq_base, irq_end;
>> +     struct twl4030_clock_init_data          *clock;
>>       struct twl4030_bci_platform_data        *bci;
>>       struct twl4030_gpio_platform_data       *gpio;
>>       struct twl4030_madc_platform_data       *madc;
>> --
>> 1.6.0.4
>>
>
> --
> Intel Open Source Technology Centre
> http://oss.intel.com/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
