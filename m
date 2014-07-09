From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 6/7] regulator: tps65218: Add get_voltage ops for dcdc5
 and dcdc6
Date: Wed, 9 Jul 2014 09:10:22 +0530
Message-ID: <53BCB9A6.7000500@ti.com>
References: <1404814597-4404-1-git-send-email-j-keerthy@ti.com> <1404814597-4404-7-git-send-email-j-keerthy@ti.com> <20140708141126.GW30458@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140708141126.GW30458-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 08 July 2014 07:41 PM, Mark Brown wrote:
> On Tue, Jul 08, 2014 at 03:46:36PM +0530, Keerthy wrote:
>
>> +static int tps65218_pmic_dcdc56_get_voltage(struct regulator_dev *dev)
>> +{
>> +	struct tps65218 *tps = rdev_get_drvdata(dev);
>> +	unsigned int rid = rdev_get_id(dev);
>> +
>> +	return tps->info[rid]->min_uV;
>> +}
> Set fixed_uV in the descriptor.
Okay. I will do that. Thanks for the review.

Regards,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
