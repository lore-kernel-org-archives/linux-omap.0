From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-SR][PATCH 01/12] omap3: voltage: cleanup pr_xxxx
Date: Fri, 6 Aug 2010 08:37:52 -0500
Message-ID: <4C5C1030.60405@ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com> <1281047052-21346-2-git-send-email-nm@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB032401CE69@dbde02.ent.ti.com> <4C5BED13.6080702@gmail.com> <20100806121807.GD31326@sirena.org.uk> <4C5C09D4.50406@ti.com> <20100806133206.GK398@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55898 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761366Ab0HFNh5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Aug 2010 09:37:57 -0400
In-Reply-To: <20100806133206.GK398@rakim.wolfsonmicro.main>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, "Gopinath, Thara" <thara@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

Mark Brown had written, on 08/06/2010 08:32 AM, the following:
> On Fri, Aug 06, 2010 at 08:10:44AM -0500, Nishanth Menon wrote:
> 
>> a) when the strings are split up when they go multiple lines:
>> E.g.:
>> 	"abcd "
>> 	"efg"
>> print comes out abcd efg
> 
> That's generally considered bad practice for precisely this reason.

I agree, but we dont normally have an cleaner option other than:
a) reduce the size of the print message
b) reduce the nesting to give us more space to print ;)

but things get a little more worse now that I think of my personal 
experience,
e.g.:
pr_info("%s is not active\n", my_struct->name);

if name is "mpu", then you get a print of:
mpu is not active, and a git grep does not match up either...


> 
>> c) time required:
>> $ time git grep "DEBUG option not enabled" .
>> arch/arm/mach-omap2/smartreflex.c:              pr_notice("DEBUG
>> option not enabled!\n  \
>> arch/arm/mach-omap2/voltage.c:          pr_notice("DEBUG option not
>> enabled!\n  \
> 
>> real	1m34.722s
>> user	0m0.440s
>> sys	0m1.820s
> 
>> Vs cscope or ctags where it is rather instantaneous if you know the
>> function name..
> 
> Interesting, I see better performance than that, especially hot cache,
> and of course an educated guess as to where to look helps greatly.
tell me about it.. ;) mebbe I can use this thread to get a machine 
upgrade budget :P.. but I guess there are a lot more folks stuck like me..
just for curiosity sake, this data was on a dual core
model name	: Intel(R) Pentium(R) 4 CPU 3.40GHz
bogomips	: 6800.29

with a 7200RPM SATA 500GB drive :(..

-- 
Regards,
Nishanth Menon
