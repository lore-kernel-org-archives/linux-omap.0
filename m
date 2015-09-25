From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: ti: clk-7xx: Remove hardwired ABE clock
 configuration
Date: Fri, 25 Sep 2015 10:03:40 +0300
Message-ID: <5604F1CC.5080809@ti.com>
References: <1440401702-32420-1-git-send-email-peter.ujfalusi@ti.com>
 <55F68AC1.1040807@ti.com> <55F90F59.60102@ti.com> <5604F0D8.60402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <5604F0D8.60402@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/25/2015 09:59 AM, Peter Ujfalusi wrote:
> Tero,
>
> On 09/16/2015 09:42 AM, Tero Kristo wrote:
>> On 09/14/2015 11:52 AM, Peter Ujfalusi wrote:
>>> Hi Tero,
>>>
>>> On 08/24/2015 10:35 AM, Peter Ujfalusi wrote:
>>>> The ABE related clocks should be configured via DT and not have it wired
>>>> inside of the kernel.
>>>
>>> can you take a look at this patch? It will not cause any regression since we
>>> do not have audio support mainline and the pending series does not need this
>>> part anymore.
>>
>> This patch looks okay to me. So, you are saying this doesn't depend on
>> anything? Isn't this causing any boot-time issues with the ABE DPLL left
>> dangling with boot setup, potentially blocking PM? I am just wondering if we
>> should group this patch with the rest of the audio support patches for dra7.
>
> Without this patch the ABE DPLL will have frequency which is not going to be
> correct to be used with the ATL. The ATL is disabled by default and only
> enabled when we use the audio. Which is not the case w/o the other series.
>

Ok, queuing for 4.3-rc fixes.

-Tero
