From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 5/5] bus: ti-sysc: Simplify cleanup upon failures in
 sysc_probe()
Date: Thu, 27 Jun 2019 10:24:21 -0500
Message-ID: <d1a5c892-abc1-8978-67ee-92c4ecb3622a@ti.com>
References: <20190625233315.22301-1-s-anna@ti.com>
 <20190625233315.22301-6-s-anna@ti.com> <20190627121158.GJ5447@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190627121158.GJ5447@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 6/27/19 7:11 AM, Tony Lindgren wrote:
> Hi,
> 
> * Suman Anna <s-anna@ti.com> [190625 23:33]:
>> The clocks are not yet parsed and prepared until after a successful
>> sysc_get_clocks(), so there is no need to unprepare the clocks upon
>> any failure of any of the prior functions in sysc_probe(). The current
>> code path would have been a no-op because of the clock validity checks
>> within sysc_unprepare(), but let's just simplify the cleanup path by
>> returning the error directly.
>>
>> While at this, also fix the cleanup path for a sysc_init_resets()
>> failure which is executed after the clocks are prepared.
> 
> Sounds like this should get queued separately as a fix for v5.3-rc
> cycle, probably got broken with the recent ti-sysc init order changes.

Yeah, this patch does not depend on the previous 4 patches, so can be
picked up independently for v5.3-rc as well.

regards
Suman
