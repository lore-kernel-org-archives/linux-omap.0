From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v3 1/3] clk: ti: am335x/am4372: Add tbclk to pwm node
Date: Mon, 21 Mar 2016 21:34:23 +0200
Message-ID: <56F04CBF.7080506@ti.com>
References: <1458263723-25770-1-git-send-email-fcooper@ti.com>
 <1458263723-25770-2-git-send-email-fcooper@ti.com>
 <20160321184318.GS25972@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160321184318.GS25972@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Franklin S Cooper Jr <fcooper@ti.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, mturquette@baylibre.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 03/21/2016 08:43 PM, Stephen Boyd wrote:
> On 03/17, Franklin S Cooper Jr wrote:
>> Add tblck to the pwm nodes. This insures that the ehrpwm driver has access
>> to the time-based clk.
>>
>> Do not remove similar entries for ehrpwm node. Later patches will switch
>> from using ehrpwm node name to pwm. But to maintain ABI compatibility we
>> shouldn't remove the old entries.
>>
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>> ---
>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
>
> Are there any plans to get off these DT_CLK entries entirely?

The series that adds support for the hwmod clock type for OMAPs has a 
support patch that should address this problem at least partially; I am 
planning to post next rev of that set soonish. It should allow getting 
rid of majority of the clock aliases, I will remove any aliases I can at 
the same time.

-Tero

