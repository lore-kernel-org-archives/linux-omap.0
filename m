From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 01/27] ARM: OMAP2+: clock: export driver API to setup/get
 clock features
Date: Tue, 2 Jun 2015 13:22:59 +0300
Message-ID: <556D8403.4070100@ti.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
 <1432566032-10860-2-git-send-email-t-kristo@ti.com>
 <20150528220410.GG24204@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150528220410.GG24204@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: paul@pwsan.com, mturquette@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 05/29/2015 01:04 AM, Stephen Boyd wrote:
> On 05/25, Tero Kristo wrote:
>> +
>> +/**
>> + * ti_clk_get_features - get clock driver features flags
>> + *
>> + * Get TI clock driver features description. Returns a pointer
>> + * to the current feature setup.
>> + */
>> +struct ti_clk_features *ti_clk_get_features(void)
>
> const?

Ok changed locally in the branch.

-Tero

>
>> +{
>> +	return &ti_clk_features;
>> +}
>>   #endif
>
