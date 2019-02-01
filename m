From: Tony Lindgren <tony@atomide.com>
Subject: Re: Droid 4 modem support in kernel & ofono
Date: Fri, 1 Feb 2019 12:50:32 -0800
Message-ID: <20190201205032.GF5720@atomide.com>
References: <20190201203616.GA2087@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190201203616.GA2087@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ofono@ofono.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [190201 20:36]:
> Hi!
> 
> Ok, so I got calls and smses somehow working in kernel&ofono ... which
> is really all I need.

Nice :)

I think the SIM card reading and writing should be doable
using dlci10 /dev/motmdm10 for AT+CRSM calls..

> I pushed the tree to git@github.com:pavelmachek/ofono.git , branch
> d4... But I had to do some "rather interesting" hacks. D4 modem
> expects packets and current kernel drivers rely on write() boundaries
> and flush(). .. which is a bit of problem for in ofonod, as it expects
> to work with bytestream with no explicit packet boundaries.
> 
> However D4 still uses normal AT commands, so... it would be good to be
> able to use AT parsing framework in ofono.
> 
> I believe easiest solution would be to automatically do the packet
> splitting in kernel, it should be as easy as splitting on \r and
> ^Z. (Currently packets are only generated when \r or ^Z is seen on
> write boundary, but that does not work well for ofono).

OK yeah it's worth trying. I hit that issue too with the
flush needed for droid4-sms-tools scripts. And the traffic
we're seeing is minimal and AFAIK there's no network port
for ts27010. And SMS messages are PDU encoded anyways.

Hmm should we do it for \r\n and \r? Otherwise the \n
will be left out of the packet :)

Regards,

Tony
