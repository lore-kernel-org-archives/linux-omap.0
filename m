From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: MTD : Kernel oops when remounting ubifs as read/write
Date: Thu, 14 Mar 2013 14:23:32 +0200
Message-ID: <1363263812.11441.112.camel@sauron.fi.intel.com>
References: <5134CEF9.5070502@mimc.co.uk>
	 <1363087506.3348.62.camel@sauron.fi.intel.com>
	 <51405F3A.3090901@mimc.co.uk>
	 <1363252425.11441.94.camel@sauron.fi.intel.com>
	 <51419E3A.8030007@mimc.co.uk>
	 <1363257009.11441.97.camel@sauron.fi.intel.com>
	 <5141B154.6050504@mimc.co.uk>
	 <1363260202.11441.108.camel@sauron.fi.intel.com>
	 <5141BC63.6060501@mimc.co.uk>
	 <1363263529.11441.109.camel@sauron.fi.intel.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363263529.11441.109.camel@sauron.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, adrian.hunter@intel.com
List-Id: linux-omap@vger.kernel.org

On Thu, 2013-03-14 at 14:18 +0200, Artem Bityutskiy wrote:
> > Is this size larger than the allocated buffer ?
> 
> I believe so.

Err, I mean, the buffer is large enough. I do not believe there is a
stupid bug like too small buffer. This code has worked for years and I
do not think it was changes much.

The oops may be cause by memory corruption - some of your drivers may
corrupt memory. You need to spend more time debugging this carefully.

Do you have fastmap UBI feature enabled?

-- 
Best Regards,
Artem Bityutskiy
