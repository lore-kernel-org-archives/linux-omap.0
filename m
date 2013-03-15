From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: MTD : Kernel oops when remounting ubifs as read/write
Date: Fri, 15 Mar 2013 10:42:01 +0200
Message-ID: <1363336921.11441.119.camel@sauron.fi.intel.com>
References: <5134CEF9.5070502@mimc.co.uk>
	 <1363087506.3348.62.camel@sauron.fi.intel.com>
	 <51405F3A.3090901@mimc.co.uk>
	 <1363252425.11441.94.camel@sauron.fi.intel.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363252425.11441.94.camel@sauron.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, adrian.hunter@intel.com
List-Id: linux-omap@vger.kernel.org

On Thu, 2013-03-14 at 11:13 +0200, Artem Bityutskiy wrote:
> On Wed, 2013-03-13 at 11:12 +0000, Mark Jackson wrote:
> > Sorry ... this just locks up the unit.
> 
> OK, I've reproduced the issue with 3.9-rc2 in nandsim, see the details
> below. The patch I proposed did not get the error path correctly, but it
> does fix the issue.
> 
> I think what you treat as "lockup" is the fixup process. UBIFS basically
> reads the entire UBI volume and writes it back. And it uses the atomic
> change UBI service, which means it also calculates CRC of everything it
> writes. And this all just takes a lot of time. This has to be done only
> once on the first mount.
> 
> I've attached the following:
> 
> 1. The patch which fixes the issue when I use nandsim. It is also
>    inlined in the end. Please, give it a try and be more patient -
>    wait longer. Please, do report your results back.

>From your last e-mail I see that the patch solves the issue for you if
the CRC32 problem is worked-around. I am pushing this fix to the ubifs
git tree. Thanks for the report.

-- 
Best Regards,
Artem Bityutskiy
