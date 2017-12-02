From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: linux-next on Nokia N900: hang on boot
Date: Sat, 2 Dec 2017 12:19:54 +0100
Message-ID: <20171202111954.4gg43xkb2wf5ebmn@pali>
References: <20171202101456.GA1810@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171202101456.GA1810@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On Saturday 02 December 2017 11:14:56 Pavel Machek wrote:
> Hi!
> 
> next from 2017-12-01 was tested.
> 
> MMC is detected, but then I see wtl4030_bci: .. battery temperature
> out of range, and machine halts. This is just before userspace would
> be started.
> 
> 4.15-rc1 seems to work ok on the box.
> 
> Any ideas?

twl4030_bci is not available on Nokia N900, so we should not try to read
its registers.

-- 
Pali Rohár
pali.rohar@gmail.com
