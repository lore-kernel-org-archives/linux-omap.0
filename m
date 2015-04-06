From: Nishanth Menon <nm@ti.com>
Subject: Re: LDP: next-20150402: twl4030 regression?
Date: Mon, 06 Apr 2015 08:53:36 -0500
Message-ID: <55228FE0.2040702@ti.com>
References: <5522886D.5050409@ti.com> <20150406134541.GE6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20150406134541.GE6023@sirena.org.uk>
Sender: linux-next-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/06/2015 08:45 AM, Mark Brown wrote:
> On Mon, Apr 06, 2015 at 08:21:49AM -0500, Nishanth Menon wrote:
> 
>> https://github.com/nmenon/kernel-test-logs/blob/next-20150401/omap2plus_defconfig/ldp.txt
>> looks clean, but
> 
>> https://github.com/nmenon/kernel-test-logs/blob/next-20150402/omap2plus_defconfig/ldp.txt#L488
>> seems to have picked up a regression in the regulator driver.
> 
> Please provide actual bug reports if you're trying to report something -

Apologies, I should have been a little more clear.

> at least a description of the problem you're seeing and some attempt at

Test was a simple boot test. There seems to be a lockdep reported at the
very least in the log provided (see
https://github.com/nmenon/kernel-test-logs/blob/next-20150402/omap2plus_defconfig/ldp.txt#L488
).

> analysis.  For example say what the test was, and if there's logs paste
> the relevant section into the e-mail.  Just randomly pasting a couple of
> web links in and saying "there's a problem" isn't helpful.

Not sure if folks have already seen this or not - clicking the link
should show the lockdep report straight out of the box.. I am thinking
that is a problem... but I might be subjective here :)

> 
> Please also CC people responsible for relevant drivers and systems.
> 

Only quick change I could see was in regulator core, Will try to dig
more at this later today. I dont see the filesystem mounted either, but
that could be something else.

--
Regards,
Nishanth Menon
