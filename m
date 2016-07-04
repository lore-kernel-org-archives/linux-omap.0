From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 2/5] ARM: OMAP2+: hwmod: fetch main_clk based on hwmod name
Date: Mon, 4 Jul 2016 12:17:57 +0300
Message-ID: <577A29C5.3010209@ti.com>
References: <1467292503-4376-1-git-send-email-t-kristo@ti.com>
 <1467292503-4376-3-git-send-email-t-kristo@ti.com>
 <20160704065428.GS28140@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160704065428.GS28140@atomide.com>
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
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 04/07/16 09:54, Tony Lindgren wrote:
> Hi,
>
> * Tero Kristo <t-kristo@ti.com> [160630 06:18]:
>> With the transition to hwmod module clocks, all hwmods will have
>> their main clocks named <hwmod_name>_mod_ck. Use this info to
>> fetch main_clk, and use it if found.
> ..
>
>>   static int _init_main_clk(struct omap_hwmod *oh)
>>   {
>>   	int ret = 0;
>> +	char name[32];
>> +	static int max_len;
>> +	struct clk *clk;
>>
>> -	if (!oh->main_clk)
>> -		return 0;
>> +	strcpy(name, oh->name);
>> +	strcat(name, "_mod_ck");
>> +
>> +	if (strlen(name) > max_len)
>> +		max_len = strlen(name);
>
> Just noticed that this needs some improvments to avoid nasty
> bugs early on. You don't seem to have max_len defined, and
> you should do a strncpy using #define MOD_CLK_MAX_LEN (32 + 7)
> or something similar instead of the strcpy and leave room for
> the strcat.
>
> Care to update and repost just this one?

Yeah, let me fix this and repost a bit later today.

-Tero
