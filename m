From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP: update omap1 and omap2plus defconfigs
Date: Wed, 08 Feb 2012 13:09:02 +0200
Message-ID: <4F3257CE.7070909@compulab.co.il>
References: <20120208053556.GB1426@atomide.com> <1328696173-17226-1-git-send-email-grinberg@compulab.co.il> <20120208101958.GT1275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:35421
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755332Ab2BHLJO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 06:09:14 -0500
In-Reply-To: <20120208101958.GT1275@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Russell,

On 02/08/12 12:19, Russell King - ARM Linux wrote:
> On Wed, Feb 08, 2012 at 12:16:13PM +0200, Igor Grinberg wrote:
>> This patch updates omapX_defconfig to 3.3-rc1 and enables
>> the CONFIG_DEBUG_SECTION_MISMATCH.
> 
> You shouldn't enable this in the kernel supplied defconfigs.

Hmmm... Ok, looks like I've forgot the purpose of defconfigs...
It is intended for users rather than developers (right?) and
the CONFIG_DEBUG_SECTION_MISMATCH has no use for users?
Is it the case, or is there anything else?

> 
>> The update is done by:
>> 1) make mrproper && make omapX_defconfig
>> 2) Enable the CONFIG_DEBUG_SECTION_MISMATCH
>> 3) make savedefconfig
>> 4) cp defconfig arch/arm/configs/omapX_defconfig
>>
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> ---
>> After updating omap1_defconfig,
>> there are several section mismatch warnings seen.
>> Hopefully, I will have time to fix those tomorrow
>> (unless someone will be kind enough to fix them before me).
>> The mismatches are:
> 
> The correct way is to build with:
> 
> make ... CONFIG_DEBUG_SECTION_MISMATCH=y
> 
> or set it in your private configuration.

In my current setup, command line switch would be most appropriate.
Thanks for suggestion.


-- 
Regards,
Igor.
