From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 00/30] ARM: OMAP2+: hwmod module clock type support
Date: Tue, 12 Apr 2016 16:55:28 +0300
Message-ID: <570CFE50.5010709@ti.com>
References: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
 <20160411173518.GA5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160411173518.GA5995@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/11/2016 08:40 PM, Tony Lindgren wrote:
> Hi,
>
> Nice to see this moving along :)
>
> * Tero Kristo <t-kristo@ti.com> [160411 01:20]:
>>
>> The ordering on this set is kind of tricky to avoid any boot issues,
>> and it still currently causes a boot breakage between the DTS data
>> introduction and removal of hwmod data; this generates duplicate
>> entries for clocks which is prone to cause issues (both DT and hwmod
>> have the same entries in place under the hwmod data is removed.) I
>> didn't quite figure out a good way to avoid this, and could use some
>> guidance here. Shall we squash the DT + hwmod data patches together?
>> This avoids the boot breakage but creates pretty large patches. Also,
>> AMx3xx data needs to be grouped together as part of their data is
>> re-used commonly by both SoCs.
>
> How about use clocks from dts if clocks property is defined? Otherwise
> fall back to the old static data. Then drop the static data later on
> with follow up patches.

The underlying issue is the hardcoded names of hwmod clocks within hwmod 
data. I think I figured out a fix for this, I am adding a few patches to 
this series to lookup main_clk based on the hwmod name itself. This 
allows re-directing the main_clk to the DT module clock in case one is 
available for the hwmod. The bisect issues seem to be gone with this 
also, I need to cleanup the patches a bit and re-post.

-Tero
