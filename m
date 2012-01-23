From: Kevin Hilman <khilman@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Mon, 23 Jan 2012 14:11:16 -0800
Message-ID: <87k44ikr23.fsf@ti.com>
References: <20120113222045.37f9b4ec@notabene.brown>
	<1326870839.1954.23.camel@deskari>
	<20120118221538.342b4782@notabene.brown>
	<1326886940.1999.5.camel@lappy>
	<20120119073032.74cc0992@notabene.brown>
	<WC20120119101721.07072A@terrafix.co.uk>
	<1326969658.1935.24.camel@deskari>
	<WC20120119112911.670749@terrafix.co.uk>
	<1326973019.7926.7.camel@lappy>
	<WC20120119122128.020787@terrafix.co.uk> <87y5t3trek.fsf@ti.com>
	<20120120080508.0dc0c758@notabene.brown> <87ty3rql2q.fsf@ti.com>
	<20120121231216.16c7e318@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:44049 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753850Ab2AWWLX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jan 2012 17:11:23 -0500
Received: by ghrr18 with SMTP id r18so1876809ghr.39
        for <linux-omap@vger.kernel.org>; Mon, 23 Jan 2012 14:11:21 -0800 (PST)
In-Reply-To: <20120121231216.16c7e318@notabene.brown> (NeilBrown's message of
	"Sat, 21 Jan 2012 23:12:16 +1100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Joe Woodward <jw@terrafix.co.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org

NeilBrown <neilb@suse.de> writes:

> On Thu, 19 Jan 2012 16:22:37 -0800 Kevin Hilman <khilman@ti.com> wrote:
>
>> NeilBrown <neilb@suse.de> writes:
>> 
>> > On Thu, 19 Jan 2012 11:37:39 -0800 Kevin Hilman <khilman@ti.com> wrote:
>> >
>> >> "Joe Woodward" <jw@terrafix.co.uk> writes:

>> >> 

[...]

>> At least this part is expected.  
>> 
>> In the kernel you're using the UART clocks are enabled/disabled during
>> the idle path depending on the low-power state being targetted, so would
>> expect to see lots of UART clock gating going on.
>
> Even though uarts 1,2,4 aren't even in use?

Yes.  Our UART idle management before v3.3 was, um... a disaster.

> Maybe this is fixed in 3.3?

As of v3.3, the UARTs are managed independently using runtime PM
autosupend, so only UART that are in use should be coming on and back
off again.

However, as Paul has recently posted some UART fixes, you'll see that we
have a few kinks to work out in the UART driver as well.

Kevin
