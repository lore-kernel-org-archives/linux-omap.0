From: Pavel Machek <pavel@ucw.cz>
Subject: Re: N900 device tree conversion: how to do first step
Date: Sun, 9 Jun 2013 19:30:06 +0200
Message-ID: <20130609173006.GC16066@amd.pavel.ucw.cz>
References: <20130609015944.GA23559@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130609015944.GA23559@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, lauri.leukkunen@nokia.com
List-Id: linux-omap@vger.kernel.org

On Sun 2013-06-09 03:59:44, Pavel Machek wrote:
> Hi!
> 
> I'd like to convert Nokia N900 to device tree.
> 
> Unfortunately, serial port is not easily available (very special cable
> would be needed, does someone know where to get one?) and I don't have
> BDI (and very special cable would be needed, too).
> 
> So I tried doing very small first step, hoping that I get booting
> system... obviously I did not.
> 
> I tried formally switching to device tree while still booting using
> hardcoded functions. No luck. Does anyone see what I did wrong?
> 
> Is it possible that n900 has its main memory somewhere else than
> 0x80000000?

Interesting. It seems that memory setup from atags is indeed 
	     0x8000 0000 size 0x0800 0000
	     0x8800 0000 size 0x0800 0000

. But hopefully that's just complicated way of saying 
	     0x8000 0000 size 0x1000 0000
	     
.

Anyway, I now see problem with my reasoning: kernel is full of

if (of_have_populated_dt())

tests, so it is impossible to switch to device tree, and still expect
old-style init to work :-(.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
