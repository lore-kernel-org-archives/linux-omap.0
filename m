From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 9/9] ARM: omap: select CPU_FREQ_TABLE where needed
Date: Mon, 26 Mar 2012 16:09:07 -0700
Message-ID: <87limnq7sb.fsf@ti.com>
References: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
	<1332522836-29517-10-git-send-email-mathieu.poirier@linaro.org>
	<20120323182746.GF9859@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120323182746.GF9859@atomide.com> (Tony Lindgren's message of
	"Fri, 23 Mar 2012 11:27:46 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: mathieu.poirier@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * mathieu.poirier@linaro.org <mathieu.poirier@linaro.org> [120323 10:17]:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The omap platform requires CPU_FREQ_TABLE support to be enabled for its
>> CPU_FREQ implementations, so automatically select that when CPU_FREQ
>> is enabled.
>
> I think this is also solved now, Kevin might be able to confirm this.

Yes, this is solved in mainline by selecting it from
drivers/cpufreq/Kconfig.arm

Kevin
