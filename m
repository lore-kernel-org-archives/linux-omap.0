From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 1/8] DSPBRIDGE: Cleanup SSI handling - remove IO_ADDRESS
Date: Fri, 8 Jan 2010 15:56:00 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DC9561D@dlee03.ent.ti.com>
References: <1262912426-29974-1-git-send-email-omar.ramirez@ti.com>
 <20100108142031.GE11897@annwn.felipec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34221 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753416Ab0AHV4H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 16:56:07 -0500
In-Reply-To: <20100108142031.GE11897@annwn.felipec.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>


>From: Felipe Contreras [mailto:felipe.contreras@nokia.com]
>
>On Fri, Jan 08, 2010 at 02:00:26AM +0100, Omar Ramirez Luna wrote:
>> This patch cleans SSI clock preparation and also removes
>> the dependency on IO_ADDRESS variants for easier maintenance.
>
>So this patch is:

Cleaning ssi handling

> * reorganizing SSI configuration
> * doing some code-style cleanups
> * using ioremap()
>
>That doesn't look very atomic to me.

I'll split this and resend...

>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>> ---
>>  arch/arm/plat-omap/include/dspbridge/drv.h |    7 ++++++
>>  drivers/dsp/bridge/services/clk.c          |   30 ++++++++++++++-------------
>>  2 files changed, 23 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-
>omap/include/dspbridge/drv.h
>> index d14613f..59c26fc 100644
>> --- a/arch/arm/plat-omap/include/dspbridge/drv.h
>> +++ b/arch/arm/plat-omap/include/dspbridge/drv.h
>> @@ -115,6 +115,13 @@
>>  #define OMAP_DMMU_BASE 0x5D000000
>>  #define OMAP_DMMU_SIZE 0x1000
>>
>> +#define OMAP_SSI_BASE		0x48058000
>> +#define OMAP_SSI_SIZE		0x1000
>> +
>> +#define SSI_AUTOIDLE			(1 << 0)
>> +#define SSI_SIDLE_SMARTIDLE	(2 << 3)
>> +#define SSI_MIDLE_NOIDLE		(1 << 12)
>> +
>>  #define OMAP_PRCM_VDD1_DOMAIN 1
>>  #define OMAP_PRCM_VDD2_DOMAIN 2
>
>Isn't this some abuse of arch/arm? In general things in header files are
>meant to be used in more than one source file, and it doesn't seem
>anybody would use these other than clk.c.

I kind of agree but I thought it was worse to have registers defined all over the place, like in _tiomap.h (where some of these registers are defined along with MBX...)

That said I'll keep this within clk.c

- omar
