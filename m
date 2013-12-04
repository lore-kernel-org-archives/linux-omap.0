From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/4] Regulators: TPS65218: Add Regulator driver for TPS65218
 PMIC
Date: Wed, 4 Dec 2013 11:29:15 +0530
Message-ID: <529EC4B3.7030009@ti.com>
References: <1386053006-6480-1-git-send-email-j-keerthy@ti.com> <1386053006-6480-4-git-send-email-j-keerthy@ti.com> <20131203151654.GB27568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131203151654.GB27568-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Thanks for the review Mark.

On Tuesday 03 December 2013 08:46 PM, Mark Brown wrote:
> On Tue, Dec 03, 2013 at 12:13:24PM +0530, Keerthy wrote:
>
>> +static int tps65218_ldo1_dcdc3_vsel_to_uv(unsigned int vsel)
>> +{
>> +	int uV = 0;
>> +
>> +	if (vsel <= 26)
>> +		uV = vsel * 25000 + 900000;
>> +	else
>> +		uV = (vsel - 26) * 50000 + 1550000;
>> +
>> +	return uV;
>> +}
> Use regulator_map_voltage_linear_range() (and similarly for most of the
> other functions).

Ok.

>> +static const struct of_device_id tps65218_of_match[] = {
>> +	TPS65218_OF_MATCH("ti,tps65218-dcdc1", tps65218_pmic_regs[0]),
>> +	TPS65218_OF_MATCH("ti,tps65218-dcdc2", tps65218_pmic_regs[1]),
>> +	TPS65218_OF_MATCH("ti,tps65218-dcdc3", tps65218_pmic_regs[2]),
>> +	TPS65218_OF_MATCH("ti,tps65218-dcdc4", tps65218_pmic_regs[3]),
>> +	TPS65218_OF_MATCH("ti,tps65218-dcdc5", tps65218_pmic_regs[4]),
>> +	TPS65218_OF_MATCH("ti,tps65218-dcdc6", tps65218_pmic_regs[5]),
>> +	TPS65218_OF_MATCH("ti,tps65218-ldo1", tps65218_pmic_regs[6]),
>> +};
>> +MODULE_DEVICE_TABLE(of, tps65218_of_match);
> Indexing into another array by magic number like this is both error
> prone and hard to read.  Either use defined constants or individual
> variables for the things being referenced.
Okay.

Regards,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
