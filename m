From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] ARM: TWD: Consolidate local timers support
Date: Thu, 2 Dec 2010 15:24:16 +0000
Message-ID: <AANLkTinse2AS4gj0-5H3tZsXbhzW1AT8xY8gT9qo8j35@mail.gmail.com>
References: <20101130173105.GA26929@oksana.dev.rtsoft.ru>
	<20101130221615.GA9424@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101130221615.GA9424@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Anton Vorontsov <avorontsov@mvista.com>, Paul Walmsley <paul@pwsan.com>, Kukjin Kim <kgene.kim@samsung.com>, Benoit Cousson <b-cousson@ti.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Colin Cross <ccross@android.com>, Varun Swara <Varun.Swara@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 30 November 2010 22:16, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 30, 2010 at 08:31:05PM +0300, Anton Vorontsov wrote:
>> This greatly reduces amount of platform-specific code, and thus
>> makes it easier to add local timers for new platforms.
>>
>> Technically, it's not very nice to place machine-specific (i.e.
>> local_timer_setup()) routine into the machine-agnostic code.
>> But the true thing is: currently all machines want the same thing.
>
> I've just been talking to someone this week about (presumably) non-TWD
> local timers.

FYI, Cortex-A15 comes with some architected timers different from the
current ones (specs publicly available in the same place as LPAE).
We'll push some patches at some point.

-- 
Catalin
