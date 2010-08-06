From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-SR][PATCH 01/12] omap3: voltage: cleanup pr_xxxx
Date: Fri, 6 Aug 2010 08:10:44 -0500
Message-ID: <4C5C09D4.50406@ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com> <1281047052-21346-2-git-send-email-nm@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB032401CE69@dbde02.ent.ti.com> <4C5BED13.6080702@gmail.com> <20100806121807.GD31326@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50712 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab0HFNKt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 09:10:49 -0400
In-Reply-To: <20100806121807.GD31326@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, "Gopinath, Thara" <thara@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

Mark Brown had written, on 08/06/2010 07:18 AM, the following:
> On Fri, Aug 06, 2010 at 06:08:03AM -0500, Nishanth Menon wrote:
> 
>> Well that is my motivation here. if driver reports a warning to kernel  
>> syslog, well, I expect the log to contain the function name for me to  
>> maintain faster.
> 
> That's really not the expectation for Linux log messages - the general
> approach to find the source of a message is generally to just grep for
> the message text which is usually very effective.

taking a small sample set of pr_xyz(); (pr which spans a single line):

$ git grep pr_ drivers/|grep ")"|grep __func__|wc -l
589
$ git grep pr_ drivers/|grep ")"|grep -v __func__|wc -l
5373
$ git grep pr_fmt drivers/|wc -l
138

Reading Documentation/dynamic-debug-howto.txt, I see that you are in a 
one way right. I can get fine grained control over the log by enabling 
CONFIG_DYNAMIC_DEBUG.

At the same time, I have wondered on the usage of pr_fmt() in many of 
the drivers. in a way, if i wanted to be that verbose in a driver, I 
could in theory do:
#define pr_fmt(fmt) "%s:" fmt, __func__ and get the benefit throughout 
the file..

but overall, I still disagree that we dont need to have the function 
name in log is a speed booster for maintenance folks.
a) when the strings are split up when they go multiple lines:
E.g.:
	"abcd "
	"efg"
print comes out abcd efg
i) you do a git grep "abcd efg" will return nada
ii) if you do a git grep of "abcd", you will probably see half a dozen 
prints there, then open each file to see where the "real" message is, 
and you find the file searching a bit


b) when there are couple more usage in cases of commonly used error 
message- (e.g. invalid parameters),  you end up getting multiple hits, 
and you are left guessing where it came from

in this example: lets see: (on l-o pm branch):
git grep "DEBUG option not enabled" .
arch/arm/mach-omap2/smartreflex.c:              pr_notice("DEBUG option 
not enabled!\n  \
arch/arm/mach-omap2/voltage.c:          pr_notice("DEBUG option not 
enabled!\n  \

now open up both the files to find exactly what you are looking for.

c) time required:
$ time git grep "DEBUG option not enabled" .
arch/arm/mach-omap2/smartreflex.c:              pr_notice("DEBUG option 
not enabled!\n  \
arch/arm/mach-omap2/voltage.c:          pr_notice("DEBUG option not 
enabled!\n  \

real	1m34.722s
user	0m0.440s
sys	0m1.820s

Vs cscope or ctags where it is rather instantaneous if you know the 
function name..
-- 
Regards,
Nishanth Menon
