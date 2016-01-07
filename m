From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: Nokia N900: u-SD card in v4.2+
Date: Thu, 7 Jan 2016 11:10:27 +0530
Message-ID: <568DFA4B.7030308@ti.com>
References: <20160106204627.GA21477@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160106204627.GA21477@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday 07 January 2016 02:16 AM, Pavel Machek wrote:
> Hi!
> 
> In v4.1, both internal MMC and u-SD cards work ok.
> 
> In v4.2, only the internal MMC is detected. In v4.3, not even internal
> MMC works. In v4.4, only the internal MMC is detected.
> 
> Does it work for you? Any patches?

I don't have Nokia N900 to check this, but can you share your config and kernel
logs? Check if CONFIG_REGULATOR_PBIAS is present in your config.
CONFIG_REGULATOR_PBIAS is now mandatory for all omap3+ SoCs to work.

Thanks
Kishon

> 
> (I do have hack in the dts to disable back cover detection...)
> 
> 									Pavel
> 
