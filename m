From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: dts: Add am57xx-beagle-x15
Date: Thu, 6 Nov 2014 10:42:59 -0600
Message-ID: <545BA513.2090907@ti.com>
References: <1415290702-11353-1-git-send-email-nm@ti.com> <20141106163207.GF16896@saruman> <545BA3E6.90105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <545BA3E6.90105@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Rini <trini@ti.com>, balbi@ti.com
Cc: devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, beagleboard@googlegroups.com, linux-kernel@vger.kernel.org, gerald@granddesignsgroup.com, fcooper@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 11/06/2014 10:37 AM, Tom Rini wrote:

>>> device_type = "memory"; +		reg = <0x80000000 0x40000000>; /* 1GB
>>> to start. Target 2GB */
>>
>> 1GiB ? Why would you put this here btw ? u-boot fills this one up.
> 
> Yes, it should either be the full and correct value or 0x0 (like a
> number of PowerPC platforms do) so it's clear something else gives us
> the right value here.

Honest mistake, my bad.. I thought I cleaned up the patch! Sigh!!! i
will repost with proper 2GB. it is better that way in case being used
with "other bootloaders" which are not exactly too good like u-boot.


-- 
Regards,
Nishanth Menon
