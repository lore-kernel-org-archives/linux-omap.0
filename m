From: Andy Green <andy.green@linaro.org>
Subject: Re: [PATCH 2 2/4] net ethernet introduce mac_la_ap helper
Date: Tue, 03 Jul 2012 12:38:41 +0800
Message-ID: <4FF27751.9050004@linaro.org>
References: <20120702063545.26782.98908.stgit@build.warmcat.com> <20120702064054.26782.79849.stgit@build.warmcat.com> <201207021612.57028.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:59869 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932110Ab2GCEiv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jul 2012 00:38:51 -0400
In-Reply-To: <201207021612.57028.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: s-jan@ti.com, patches@linaro.org, tony@atomide.com, rostedt@goodmis.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07/03/12 00:12, the mail apparently from Arnd Bergmann included:
> On Monday 02 July 2012, Andy Green wrote:
>> From: Andy Green <andy@warmcat.com>
>>
>> This introduces a small helper in net/ethernet, which registers a
>> network notifier on init, and accepts registrations of expected asyn=
chronously-

> Yes, looks good to me in principle. It needs to get sent to the linux=
-kernel
> and netdev mailing lists for review though. A few small comments.

I wanted to hear that it had actually converged with what was being=20
talked about first.  I just sent out a v3 with the relevant patch also=20
cc-d to those lists but stg mail didn't seem to send it to them.  I'll=20
wait for any further comments here and resend the whole thing including=
=20
those lists.

> I find the name a bit non-obvious, not sure if we can come up with th=
e
> perfect one.=09
>
> How about mac-platform?

Done.

>>   endif   # if NET
>
> This one needs to be either a silent option (only selected by the
> platforms that want it) or the header file has to provide a
> static-inline fallback that does nothing, so we don't get
> a build failure on platforms that need it if the option gets
> disabled.
>
> I'd prefer making it a silent option because then we don't bloat
> the kernel if someone accidentally enables it on a platform that
> does not use it.

Done.  It's already added as a select on the Panda board config.

I also moved it out of the "if NET" clause and took care about the case=
=20
that CONFIG_NET is off but we still have mac-platform references.

>> +static struct mac_la_ap mac_la_ap_list;
>
> The normal way to do this is to have just a list head that the
> entries get added to:
>
> static LIST_HEAD(mac_la_ap_list);
>
> That also takes care of the initialization.

Thanks for normalizing it, done.

>> +DEFINE_MUTEX(mac_la_ap_mutex);
>> +bool mac_la_ap_started;
>
> These should all be static.

Right, done.

> I think it would be simpler to register the notifier from an
> initcall and drop the mac_la_ap_started variable.

That was my first approach, to structure it as a real driver.  I had=20
tried a few likely-looking initcall levels but the init of the helper=20
was coming after the init of the network code.

I found this time that core_initcall works, so I used that, dropped the=
=20
flag.  But isn't it a bit tricky with these to know if the prerequisite=
=20
you're trying to ensure is already initialized might not actually be at=
=20
the same initcall level and you're working by accident?

>> +int mac_la_ap_register_device_macs(const struct mac_la_ap *macs)
>> +{
>
>> +}
>> +EXPORT_SYMBOL_GPL(mac_la_ap_register_device_macs);
>
>
> I'm not sure if there is any point in exporting this function, my fee=
ling
> is that it would only ever be called from built-in code. If we can ca=
ll it
> from a module, we should probably also allow this file to be a loadab=
le
> module as well.

Being a modular API for platform code to call doesn't make sense, I got=
=20
rid of the export.

-Andy

--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
