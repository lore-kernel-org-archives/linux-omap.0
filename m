From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v3 0/4] clk: clk: Add functions to save/restore clock
 context en-masse
Date: Mon, 13 Aug 2018 18:25:30 +0300
Message-ID: <ff0fdd50-a674-9475-290a-053ebf415ff8@ti.com>
References: <1529568907-19930-1-git-send-email-j-keerthy@ti.com>
 <20180710055605.GF99251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180710055605.GF99251@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>
Cc: sboyd@kernel.org, linux-clk@vger.kernel.org, d-gerlach@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/07/18 08:56, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [180621 01:18]:
>> Deep enough power saving mode can result into losing context of the clock
>> registers also, and they need to be restored once coming back from the power
>> saving mode. Hence add functions to save/restore clock context.
> 
> Patches 1 to 3 look good to me:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Stephen, if no more comments, can you please set up an immutable
> branch for me as otherwise the last patch might cause merge
> conflicts?
> 
> Regards,
> 
> Tony
> 

Stephen, Mike,

Any concerns about this series? This series touches core clock APIs 
slightly, but from my side these look fine. Do you want to pick #1-#3 up 
yourself or do you want me to setup a pull-req? Patch #4 seems like 
should go in via Tony's tree.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
