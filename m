From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH 3.19-rc2 v15 5/8] arm: omap1: Migrate debug_ll macros
 to use 8250.S
Date: Tue, 20 Jan 2015 09:00:17 +0000
Message-ID: <54BE1921.5050902@linaro.org>
References: <1420461624-4410-1-git-send-email-daniel.thompson@linaro.org> <1420461624-4410-6-git-send-email-daniel.thompson@linaro.org> <20150119213845.GL18552@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150119213845.GL18552@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Paul Bolle <pebolle@tiscali.nl>, linaro-kernel@lists.linaro.org, patches@linaro.org, spear-devel@list.st.com, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 19/01/15 21:38, Tony Lindgren wrote:
> * Daniel Thompson <daniel.thompson@linaro.org> [150105 04:49]:
>> The omap1's debug-macro.S is similar to the generic 8250 code. Compared to
>> the 8520 code the omap1 macro automatically determines what UART to use
>> based on breadcrumbs left by the bootloader and automatically copes with
>> the eccentric register layout on OMAP7XX.
>>
>> This patch drops both these features and relies instead on the generic
>> 8250 macros:
>>
>> 1. Dropping support for the bootloader breadcrumbs is identical to the
>>    way the migration was handled for OMAP2 (see 808b7e07464d...).
>>
>> 2. Support for OMAP7XX still exists but it must be configured by hand
>>    (DEBUG_OMAP7XXUART1/2/3) rather than handled at runtime.
>>
>> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Arnd Bergmann <arnd.bergmann@linaro.org>
>> Cc: linux-omap@vger.kernel.org
>> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Daniel, I suggest you upload this patch into Russell's patch tracking
> system to get it merged. That at least shrinks down your patch series
> if the other patches need more work.

This has been in the patch tracker for a week or so:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8271/1

I'm very aware that this patch (and indeed the whole patch set) has been
knocking round for longer than it should have. The changelog for this
patchset is certainly not one to be especially proud off ;-) .


Daniel.
