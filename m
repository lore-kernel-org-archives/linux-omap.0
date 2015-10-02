From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v2] clk: ti: fix dual-registration of uart4_ick
Date: Fri, 2 Oct 2015 09:07:19 +0300
Message-ID: <560E1F17.9060609@ti.com>
References: <1443535268-22586-1-git-send-email-ben.dooks@codethink.co.uk>
 <20151002001539.GA12338@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20151002001539.GA12338@codeaurora.org>
Sender: stable-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, stable@vger.kernel.org, mturquette@baylibre.com, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/02/2015 03:15 AM, Stephen Boyd wrote:
> On 09/29, Ben Dooks wrote:
>> On the OMAP AM3517 platform the uart4_ick gets registered
>> twice, causing any power managment to /dev/ttyO3 to fail
>> when trying to wake the device up.
>>
>> This solves the following oops:
>>
>> [] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa09e008
>> [] PC is at serial_omap_pm+0x48/0x15c
>> [] LR is at _raw_spin_unlock_irqrestore+0x30/0x5c
>>
>> Cc: stable@vger.kernel.org
>> Cc: mturquette@baylibre.com
>> Cc: sboyd@codeaurora.org
>> Cc: linux-clk@vger.kernel.org
>> Cc: linux-omap@vger.kernel.org
>> Cc: t-kristo@ti.com
>> Cc: linux-kernel@lists.codethink.co.uk
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>
> Which patch broke this? Adding a Fixes: line will help us figure
> out where to backport this.
>

The issue has been around since the legacy clock data code already, I am 
not quite sure which initially broke it though. As such, we can use the 
initial clock conversion commit as a fixes by for this:

commit aafd900cab87d339dc3004c241eebc854005124b
Author: Tero Kristo <t-kristo@ti.com>
Date:   Fri Aug 2 14:04:19 2013 +0300

     CLK: TI: add omap3 clock init file

I'll add a fixes tag to this and queue it for 4.3-rc-fixes.

-Tero
