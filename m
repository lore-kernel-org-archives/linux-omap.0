From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: ti: drop locking code from mux/divider drivers
Date: Tue, 24 Nov 2015 11:37:29 +0200
Message-ID: <56542FD9.9080005@ti.com>
References: <1443727237-21809-1-git-send-email-grygorii.strashko@ti.com>
 <562AA243.5010504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <562AA243.5010504@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Michael Turquette <mturquette@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

On 10/24/2015 12:10 AM, Grygorii Strashko wrote:
> On 10/01/2015 10:20 PM, Grygorii Strashko wrote:
>> TI's mux and divider clock drivers do not require locking and they do
>> not initialize internal spinlocks. This code was occasionally
>> copy-posted from generic mux/divider drivers. So remove it.
>>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>
> Gentle ping.

Queued for 4.4-rc-fixes, thanks.

-Tero

>
>>   drivers/clk/ti/divider.c | 16 +++-------------
>>   drivers/clk/ti/mux.c     | 15 +++------------
>>   2 files changed, 6 insertions(+), 25 deletions(-)
>>
>

