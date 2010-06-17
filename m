From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v4 2/4] OMAP4: Keyboard device registration
Date: Thu, 17 Jun 2010 14:08:18 -0700
Message-ID: <87mxutl64d.fsf@deeprootsystems.com>
References: <x0066660@ti.com>
	<1276704555-30625-1-git-send-email-x0066660@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5BEFCC3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5BEFCC3@dbde02.ent.ti.com> (Charulatha Varadarajan's message of "Thu\, 17 Jun 2010 11\:37\:09 +0530")
Sender: linux-input-owner@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "Arce, Abraham" <x0066660@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

"Varadarajan, Charulatha" <charu@ti.com> writes:

[...]

>> +
>> +int omap4_init_kp(struct omap4_keypad_platform_data *kp)
>> +{
>> +	struct omap_hwmod *oh;
>> +	struct omap_device *od;
>> +	struct omap4_keypad_platform_data *pdata;
>> +
>> +	unsigned int id = 0;
>> +	char *name = "omap4-keypad";
>> +	char *oh_name = "kbd";
>> +
>> +	if (!cpu_is_omap44xx())
>> +		return -ENODEV;
>> +
>> +	oh = omap_hwmod_lookup(oh_name);
>
> Use omap_hwmod_for_each_by_class() instead of lookup by name.

Yes.

>> +	if (!oh) {
>> +		pr_err("Could not look up %s\n", oh_name);
>> +		return -EIO;
>> +	}
>> +
>> +	pdata = kp;
>> +
>> +	pdata->base = oh->_rt_va;
>> +	pdata->irq = oh->mpu_irqs[0].irq;
>
> Use platform_get_() APIs to get base addr & irq instead of passing
> it as pdata

Yes.

Thanks Charu!

For all those working on OMAP hwmod conversions, please take some time
to read the reviews of the other hwmod conversions that have already
been posted and reviewed (some of them multiple times) so we don't
keep duplicating the same mistakes and wasting review time.

Thanks,

Kevin
