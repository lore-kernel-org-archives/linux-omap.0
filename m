From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v2 09/11] mfd: twl-core: Collect global variables behind
 one private structure (global)
Date: Mon, 11 Feb 2013 14:22:25 -0600
Message-ID: <51195301.8000606@ti.com>
References: <1358344439-23017-1-git-send-email-peter.ujfalusi@ti.com> <1358344439-23017-10-git-send-email-peter.ujfalusi@ti.com> <51154A7A.2010709@ti.com> <5115E3B9.6090100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5115E3B9.6090100@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org


On 02/08/2013 11:50 PM, Peter Ujfalusi wrote:
> On 02/08/2013 07:56 PM, Jon Hunter wrote:
>>>  /**
>>>   * twl_i2c_write - Writes a n bit register in TWL4030/TWL5030/TWL60X0
>>>   * @mod_no: module number
>>> @@ -322,16 +323,17 @@ int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
>>>  		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
>>>  		return -EPERM;
>>>  	}
>>> -	if (unlikely(!inuse)) {
>>> +	if (unlikely(!twl_priv->ready)) {
>>
>> This is causing the kernel to panic on all my omap2 boards when booting linux-next
>> because twl_priv is not initialised yet.
> 
> Good catch.
> I just wonder from where the twl_* call is coming on OMAP2. AFAIK the twl code
> is for OMAP3/4, for OMAP2 Menelaus is the one which is used.
> I'm currently working on to remove all those twl_* calls from random places in
> the kernel so we will only access twl via the MFD stack.

Good point. I just noticed that none of my omap2+ board were booting and
on omap3/4 I was the panic in the twl code. I can't say that I checked
the panic on omap2, so may be that was another problem?

I will update the changelog and re-send the patch.

Cheers
Jon
