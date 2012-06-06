From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: Please help! AM35xx mm/slab.c BUG
Date: Wed, 06 Jun 2012 13:37:15 +0300
Message-ID: <4FCF32DB.7000208@bitmer.com>
References: <1338878255.13133.YahooMailNeo@web125205.mail.ne1.yahoo.com> <20120605070853.GE12766@atomide.com> <1338913755.88514.YahooMailNeo@web125201.mail.ne1.yahoo.com> <1338963298.87083.YahooMailNeo@web125204.mail.ne1.yahoo.com> <CAMQu2gw2bGNwot_xVPdAsYjZChzzNib2USg8Ci+W5aLbenPnqA@mail.gmail.com> <20120606071024.GP12766@atomide.com> <1338969083.99043.YahooMailNeo@web125201.mail.ne1.yahoo.com> <20120606084123.GU12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:42717 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755810Ab2FFKjQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Jun 2012 06:39:16 -0400
In-Reply-To: <20120606084123.GU12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: CF Adad <cfadad@rocketmail.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

my 2 cents.

On 06/06/2012 11:41 AM, Tony Lindgren wrote:
> * CF Adad <cfadad@rocketmail.com> [120606 00:55]:
>>
>> Do you folks know of a good reference for properly calculating these GPMC settings?
> 
> In theory you just need to know the timings of connected components,
> then check which ones depend on cycles and which ones depend on time.
> 
I afraid paper-and-pencil gpmc exercise is often required but after that
it is more easy to see from charts if e.g. original settings were not
optimal or too near to edge. Helps to understand and point possible
problems on oscilloscope measurements too.

> Also take into account latencies added by level shifters if you have those.
> Paul Walmsley noticed a few years ago that those affected the smsc911x
> timings if not accounted for.
> 
I've noticed the same. Even one-directional level shifters easily add a
few ns and double amount in read operation since then there are two
level shifters in a path: one in clk/cs/oe/etc cpu-to-chip signal and
one on chip-to-cpu side.

Pay also attention if there are extra latencies in chip. Chip memory
reads/writes may be slower than chip register access (probably similar
than smsc fifo issue what Tony mentioned earlier in this thread).

-- 
Jarkko
