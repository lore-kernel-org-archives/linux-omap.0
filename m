From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2 0/2] ARM: l2c: OMAP4/AM437x: Additional register programming
 support.
Date: Fri, 2 Jan 2015 13:47:20 -0600
Message-ID: <54A6F5C8.2050008@ti.com>
References: <1420220628-23742-1-git-send-email-nm@ti.com> <54A6E79E.7010203@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54A6E79E.7010203@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Santosh <ssantosh@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

On 01/02/2015 12:46 PM, santosh.shilimkar@oracle.com wrote:
> On 1/2/15 9:43 AM, Nishanth Menon wrote:
>> Hi,
>> OMAP4 and AM437x ROM code provides services to program PL310's latency
>> registers and AM437x provides service for programming Address filter
>> registers.
>>
>> Provide support in the kernel for the same.
>>
>> V2 of the series contains documentation update and a bug fix due to a
>> typo introduced during patch split :(
>>
>> Nishanth Menon (2):
>>    ARM: l2c: OMAP4/AM437x: Introduce support for cache latency
>>      programming
>>    ARM: l2c: AM437x: Introduce support for cache filter programming
>>
> Looks fine to me ...
> Feel free to add my ack if you need one ...
> 
> Minor: The subject looks like I2C though it is L2C ;-)
> 
Yeah, the thought did occur to me, but decided instead to go with the
existing $subject conventions of arch/arm/mach-omap2/omap4-common.c
ARM: l2c: omap2+: get rid of init call
ARM: l2c: omap2+: get rid of redundant cache replacement policy setting
ARM: l2c: omap2: remove explicit non-secure access bits
ARM: l2c: omap2: remove cache size override
ARM: l2c: omap2: remove explicit SMI calls to enable L2 cache
ARM: l2c: omap2: implement new write_sec method
ARM: l2c: remove platforms/SoCs setting early BRESP
ARM: l2c: fix register naming
ARM: l2c: omap2: remove ES1.0 support

..

If folks feel strongly about this, I can capitalize the same and post
a v3 to help confusing fonts on certain mail clients and terminals.
let me know if folks want me to.


-- 
Regards,
Nishanth Menon
