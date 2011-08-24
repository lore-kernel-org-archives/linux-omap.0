From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP: Move omap2_init_common_devices out of
 init_early
Date: Wed, 24 Aug 2011 17:48:27 +0530
Message-ID: <4E54EC13.6040509@ti.com>
References: <20110824115048.2985.24230.stgit@kaulin> <20110824115433.2985.98712.stgit@kaulin> <4E54EA5E.8010603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:54300 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752028Ab1HXMSf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Aug 2011 08:18:35 -0400
Received: by mail-gw0-f44.google.com with SMTP id 20so1089186gwb.17
        for <linux-omap@vger.kernel.org>; Wed, 24 Aug 2011 05:18:34 -0700 (PDT)
In-Reply-To: <4E54EA5E.8010603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wednesday 24 August 2011 05:41 PM, Cousson, Benoit wrote:
> Hi Tony,
>
> On 8/24/2011 1:54 PM, Tony Lindgren wrote:
>> There's no need to call omap2_init_common_devices from init_early.
>> It reprograms the memory timings for some boards, so it's better to
>> do it later so we have a chance to get console messages if something
>> goes wrong.
>
> BTW, I did some comment on that function in my OMAP4 device-tree series,
> because the name is misleading.
> That function is just initializing the SDRC controller present in OMAP2
> & 3. OMAP4 platform should not even call it.
> In fact, I'm now wondering were the OMAP4 EMIF is configured?
>
In the boot-loader at this point of time. EMIF driver should
make the configuration in kernel which is work in progress.

> void __init omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs0,
> struct omap_sdrc_params *sdrc_cs1)
> {
> if (cpu_is_omap24xx() || omap3_has_sdrc()) {
> omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
> _omap2_init_reprogram_sdrc();
> }
> }
>
> I guess it used to do much more than that in the past.
>
> Shouldn't we rename it to clarify its purpose?
>
I agree.

Regards
Santosh
