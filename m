From: Romain Perier <romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC][PATCH 1/4] regulator: Add helper function to get "poweroff-source"
 property
Date: Thu, 02 Oct 2014 19:43:00 +0200
Message-ID: <542D8EA4.6080903@gmail.com>
References: <1412098186-5042-1-git-send-email-romain.perier@gmail.com> <20141001180759.GH4273@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141001180759.GH4273-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?windows-1252?Q?=22heiko=40sntech=2Ede_?= =?windows-1252?Q?=3E=3E_Heiko_St=FCbner=22?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Adding the corresponding drivers and DT maintainers to the loop (parts=20
of the kernel which use this property)

Le 01/10/2014 20:07, Mark Brown a =E9crit :
> On Tue, Sep 30, 2014 at 05:29:43PM +0000, Romain Perier wrote:
>
>> +/**
>> + * of_get_regulator_poweroff_source - Get poweroff-source for given=
 device_node
>> + * @np: Pointer to the given device_node
>> + *
>> + * return true if present false otherwise
>> + */
>> +bool of_get_regulator_poweroff_source(const struct device_node *np)
>> +{
>> +	return of_property_read_bool(np, "poweroff-source");
>> +}
>> +EXPORT_SYMBOL_GPL(of_get_regulator_poweroff_source);
> This isn't really a regulator specific thing - it's common for the
> actual implementation to be to simply cut power but it could be
> something that doesn't look like a regulator doing it like a system
> monitor.  I'd rename this to something like is_system_poweroff_source=
().
>
> You probably also want to CC the DT maintainers on this and add some
> documentation of this as a standard property, not entirely sure where
> exactly but I'm sure the DT people could advise.
