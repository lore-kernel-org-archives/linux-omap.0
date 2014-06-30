From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 2/6] mailbox/omap: add support for parsing dt devices
Date: Mon, 30 Jun 2014 11:00:25 -0500
Message-ID: <53B18999.2020506@ti.com>
References: <1403660878-56350-1-git-send-email-s-anna@ti.com> <1403660878-56350-3-git-send-email-s-anna@ti.com> <20140628170709.GB23634@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140628170709.GB23634@xo-6d-61-c0.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, Jassi Brar <jaswinder.singh@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

On 06/28/2014 12:07 PM, Pavel Machek wrote:
> Hi!
> 
>> The non-DT support has to be maintained for now to not break
>> OMAP3 legacy boot, and the legacy-style code will be cleaned
>> up once OMAP3 is also converted to DT-boot only.
> 
>> @@ -587,24 +606,157 @@ static int omap_mbox_unregister(struct omap_mbox_device *mdev)
>>  	return 0;
>>  }
>>  
>> +static const struct omap_mbox_device_data omap2_data = {
>> +	.num_users	= 4,
>> +	.num_fifos	= 6,
>> +	.intr_type	= MBOX_INTR_CFG_TYPE1,
>> +};
>> +
>> +static const struct omap_mbox_device_data omap3_data = {
>> +	.num_users	= 2,
>> +	.num_fifos	= 2,
>> +	.intr_type	= MBOX_INTR_CFG_TYPE1,
>> +};
>> +
>> +static const struct omap_mbox_device_data am335x_data = {
>> +	.num_users	= 4,
>> +	.num_fifos	= 8,
>> +	.intr_type	= MBOX_INTR_CFG_TYPE2,
>> +};
> 
> So you use compatible strings to look up 3 integers. Would it be better to have
> num_users/num_fifos/intr_type directly in the device tree? That should be cleaner
> and more flexible...
> 
> If you do that, would it be possible to have share compatible string?

Yeah, I have actually encoded the .num_users and .num_fifos in DT in the
previous version [1] with shared compatible strings, but dropped those
properties in favour of adding minimal custom properties to DT based on
some offline IRC comments. I have no objections either way, but there is
really nothing to be gained from minimizing compatible strings.

Tony,
Any comments on this?

regards
Suman

[1] https://patchwork.kernel.org/patch/2839662/
