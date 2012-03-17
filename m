From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v7 1/3] Documentation: common clk API
Date: Fri, 16 Mar 2012 20:38:54 -0700
Message-ID: <4F64074E.2070903@codeaurora.org>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <CAP245DXV5oE+-y+PQCcSM016h-J+UgTi1efmdrcyeQge4k1Cfw@mail.gmail.com>
 <201203161218.05125.arnd.bergmann@linaro.org>
 <201203162057.58706.arnd@arndb.de>
 <alpine.DEB.2.00.1203161509470.4395@utopia.booyaka.com>
 <20120316234706.GJ3852@pengutronix.de> <4F63E0D3.3060106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F63E0D3.3060106@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robherring2@gmail.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@stericsson.com>, Arnd Bergmann <arnd@arndb.de>, patches@linaro.org, Magnus Damm <magnus.damm@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linaro-dev@lists.linaro.org, Jeremy Kerr <jeremy.kerr@canonical.com>, linux-omap@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 03/16/2012 05:54 PM, Rob Herring wrote:
> On 03/16/2012 06:47 PM, Sascha Hauer wrote:
>> Hi Paul,
>>
>> On Fri, Mar 16, 2012 at 04:21:17PM -0600, Paul Walmsley wrote:
>>> Hi
>>>
>>> On Fri, 16 Mar 2012, Arnd Bergmann wrote:
>>>
>>>
>>> If the common clock code is to go upstream now, it should be marked as
>>> experimental.
>>
>> No, please don't do this. This effectively marks the architectures using
>> the generic clock framework experimental. We can mark drivers as 'you
>> have been warned', but marking an architecture as experimental is the
>> wrong sign for both its users and people willing to adopt the framework.
>> Also we get this:
>>
>> warning: (ARCH_MX1&&  MACH_MX21&&  ARCH_MX25&&  MACH_MX27) selects COMMON_CLK which has unmet direct dependencies (EXPERIMENTAL)
>>
>> (and no, I don't want to support to clock frameworks in parallel)
>>
>
> +1
>
> For simple users at least, the api is perfectly adequate and it is not
> experimental (unless new means experimental).
>

+1 - not experimental please.

While I agree with Mike and Paul that there is room for a lot of 
improvements to the clock APIs, I think the existing APIs in this patch 
series can become macro wrappers around any new APIs improvements we add 
in the future.

We should have really done that for the 
clk_prepare_enable/unprepare_disable(), but it should certainly be 
doable for future API additions now that we have the atomic/non-atomic 
differentiation out of the way.

Thanks,
Saravana


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
