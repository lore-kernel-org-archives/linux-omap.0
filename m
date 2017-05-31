From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3b 0/5] ARM: OMAP2+: preparation for clk/clkctrl support
Date: Wed, 31 May 2017 17:40:54 +0300
Message-ID: <d683d2b5-0dcb-c311-b7ab-a543edc1c813@ti.com>
References: <1496155669-1677-1-git-send-email-t-kristo@ti.com>
 <20170530181618.GC3730@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170530181618.GC3730@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 30/05/17 21:16, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [170530 07:51]:
>> Hi,
>>
>> This is an alternative solution against v3 [1] of this series.
>>
>> [1] https://www.spinics.net/lists/arm-kernel/msg581965.html
>>
>> This series is different in that it parses the hwmod data in the fly
>> and swaps the main_clk info with clkctrl implementations if those
>> are present. Patch #1 / #2 are old from v3 of the series, rest are
>> new. Patches #3 / #4 add some infrastructure support for parsing
>> the clock data, and patch #5 does the clock swapping.
>>
>> With this series, it is not necessary to populate clkctrl clock
>> entries to DT at all, thus the transition should be smoother.
> 
> Yeah OK I think this is the way to go to avoid changing
> device tree multiple times. The only issues I have are
> for patches 4 and 5 that I already commented on there.

Ok, I'll post v4 based on this series and fixup the issues with patch #4 
/ #5. I'll abandon the original v3 series.

-Tero
