From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 05/33] CLK: omap: add DT duplicate clock registration
 mechanism
Date: Thu, 1 Aug 2013 18:30:26 +0300
Message-ID: <51FA7F12.6010407@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-6-git-send-email-t-kristo@ti.com> <51F808A8.6000503@ti.com>
 <51F8E1F5.20706@ti.com> <51FA6FCA.3050900@ti.com> <51FA7C39.8090100@ti.com>
 <51FA7DB6.3060002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51FA7DB6.3060002@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: paul@pwsan.com, khilman@linaro.org, mturquette@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 08/01/2013 06:24 PM, Nishanth Menon wrote:
> On 08/01/2013 10:18 AM, Tero Kristo wrote:
>> On 08/01/2013 05:25 PM, Nishanth Menon wrote:
>>> On 07/31/2013 05:07 AM, Tero Kristo wrote:
>>>> On 07/30/2013 09:40 PM, Nishanth Menon wrote:
>>>>> On 07/23/2013 02:20 AM, Tero Kristo wrote:
> [..]
>>> if we can get rid of usage of omap_hwmod_get_main_clk by catching them
>>> with [1], then we can force the drivers to pick up based on device node
>>> clocks= property.
>>>
>>> It might be easier to fix 1 driver - timer, rather than introduce am33x,
>>> omap4, omap5 dra7 specific "SoC clk driver".
>>>
>>> with that this entire patch becomes redundant.
>>
>> It is not that simple. Looking at the architectures this set supports, I
>> see clock alias nodes at least for following drivers:
>>
>> - GPT timer
>> - USB
>> - DCAN
>> - EMAC
>> - VPFE
>> - UART
>> - SSI
>> - DSS
>> - security
>> - MMC
>> - MCBSP
>> - MCSPI
>>
>> I am _not_ going to fix all of these during the initial phase. :P
>>
>> But yes, eventually these should go away.
>
> How many of these are needed to boot? what functionality do we expect
> with the series -> we can constraint saying that remaining drivers
> should fix themselves the right way, else dont have the feature -
> example cpufreq- fix it the right way, or wont see the feature enabled.
>
> introducing a "way out" for all of these just invites more guys to screw
> around claiming "it was done before - see here"..
>
> lets just fix the darned basic ones, refuse to provide "way out" and let
> the others fix themselves.
>

Yea, that would be one way. I guess someone like Tony should comment on 
this.
