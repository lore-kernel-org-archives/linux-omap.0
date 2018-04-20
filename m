From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: bq27000: directory/files exists even when hardware is not
 available
Date: Fri, 20 Apr 2018 09:48:26 +0200
Message-ID: <20180420074826.c7cy4z3tq7c56ccs@pali>
References: <20180420074036.GA16257@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180420074036.GA16257@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, afd@ti.com, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday 20 April 2018 09:40:36 Pavel Machek wrote:
> Hi!
> 
> On droid4 (4.17-rc1), /sys/class/power_supply/bq27000-battery exists
> even when hardware is not present (as on Droid 4).
> 
> Any ideas?
> 									Pavel

Somebody must have registered bq device into power_supply subsystem.
Maybe DT note is present?

-- 
Pali Rohár
pali.rohar@gmail.com
