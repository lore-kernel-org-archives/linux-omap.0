From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: MTD : Kernel oops when remounting ubifs as read/write
Date: Thu, 14 Mar 2013 14:18:49 +0200
Message-ID: <1363263529.11441.109.camel@sauron.fi.intel.com>
References: <5134CEF9.5070502@mimc.co.uk>
	    <1363087506.3348.62.camel@sauron.fi.intel.com>
	    <51405F3A.3090901@mimc.co.uk>
	   <1363252425.11441.94.camel@sauron.fi.intel.com>
	   <51419E3A.8030007@mimc.co.uk>
	  <1363257009.11441.97.camel@sauron.fi.intel.com>
	  <5141B154.6050504@mimc.co.uk>
	 <1363260202.11441.108.camel@sauron.fi.intel.com>
	 <5141BC63.6060501@mimc.co.uk>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5141BC63.6060501@mimc.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, adrian.hunter@intel.com
List-Id: linux-omap@vger.kernel.org

On Thu, 2013-03-14 at 12:02 +0000, Mark Jackson wrote:
> But there's also a call to crc with a size of 122880 bytes, and that's
> when the oops occurs.
> 
This is when we do the atomic LEB change.

> Is this size larger than the allocated buffer ?

I believe so.

-- 
Best Regards,
Artem Bityutskiy
