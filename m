From: Thomas Weber <thomas.weber.linux@googlemail.com>
Subject: Re: [RFC/PATCH] ARM: OMAP: Fix build for OMAP3 only builds
Date: Wed, 02 Nov 2011 13:37:31 +0100
Message-ID: <4EB1398B.80901@gmail.com>
References: <1318421036-1498-1-git-send-email-weber@corscience.de> <B85A65D85D7EB246BE421B3FB0FBB5930328C7C406@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34196 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab1KBLiV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Nov 2011 07:38:21 -0400
Received: by eye27 with SMTP id 27so27205eye.19
        for <linux-omap@vger.kernel.org>; Wed, 02 Nov 2011 04:38:19 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930328C7C406@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: Thomas Weber <weber@corscience.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>

Am 27.10.2011 07:32, schrieb Nori, Sekhar:
> On Wed, Oct 12, 2011 at 17:33:56, Thomas Weber wrote:
>> When building for OMAP3 only I get the
>> following errors:
>>
>> In function `omap2420_init_early':
>> undefined reference to `omap2_set_globals_242x'
>> undefined reference to `omap2xxx_voltagedomains_init'
>> undefined reference to `omap242x_powerdomains_init'
>> undefined reference to `omap242x_clockdomains_init'
>> undefined reference to `omap2420_hwmod_init'
>>
>> In function `omap2430_init_early':
>> undefined reference to `omap2_set_globals_243x'
>> undefined reference to `omap2xxx_voltagedomains_init'
>> undefined reference to `omap243x_powerdomains_init'
>> undefined reference to `omap243x_clockdomains_init'
>> undefined reference to `omap2430_hwmod_init'
>>
>> In function `omap4430_init_early':
>> undefined reference to `omap2_set_globals_443x'
>> undefined reference to `omap44xx_voltagedomains_init'
>> undefined reference to `omap44xx_powerdomains_init'
>> undefined reference to `omap44xx_clockdomains_init'
>> undefined reference to `omap44xx_hwmod_init'
>> undefined reference to `omap4xxx_clk_init'
>>
>> With this patch the omapXXXX_init_early will be compiled only
>> when their SOC's are selected.
>>
>> Signed-off-by: Thomas Weber <weber@corscience.de>
> 
> I was facing the same problem and this patch helped
> me get rid of it.
> 
> Tested-by: Sekhar Nori <nsekhar@ti.com>
> 
> Thanks,
> Sekhar
> 
> --

Hello Tony,

what is the status of this patch?

There is also another patch fixing the same problem.

[PATCH v2] arm: omap: Fix errors and warnings when building for one board

Thomas

