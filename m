From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP5: DSS hwmod data
Date: Sun, 16 Mar 2014 13:41:14 +0200
Message-ID: <53258DDA.50005@compulab.co.il>
References: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com> <532037E0.1080309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:52561 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbaCPLl5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 16 Mar 2014 07:41:57 -0400
In-Reply-To: <532037E0.1080309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tomi,

(resending in the text format)

Where can I get those unpublished omap5 and omap5-uevm display patches 
to test the video out with this patch?
I'll appreciate your assistance in additional setup (like required uEvm 
.dts changes and DSI panel connection short guide).

Thanks you in advance,

Dmitry Lifshitz

On 03/12/2014 12:33 PM, Tomi Valkeinen wrote:
> On 12/03/14 12:26, Tomi Valkeinen wrote:
>> Hi,
>>
>> This patch adds hwmod data for omap5 display subsystem. I have tested this on
>> omap5-uevm with a DSI panel. I cannot test omap5-uevm's hdmi output yet, as the
>> mainline is missing omap5 HDMI driver.
>>
>> I do see this when booting:
>>
>>    omap_hwmod: dss_dispc: cannot be enabled for reset (3)
>>    omap_hwmod: dss_dsi1: cannot be enabled for reset (3)
>>    omap_hwmod: dss_dsi2: cannot be enabled for reset (3)
>>    omap_hwmod: dss_hdmi: cannot be enabled for reset (3)
>>    omap_hwmod: dss_rfbi: cannot be enabled for reset (3)
>>
>> But at least DSI works just fine.
> Oh, I forgot to say that I tested this on top of the DSS DT branch, and
> unpublished omap5 and omap5-uevm display patches. So if applied to the
> current mainline, the hwmods are not used at all (except the reset at
> boot time, I think).
>
> But if this gets merged for 3.15, it'll make adding omap5 DSS support
> easier for 3.16 as the HWMOD data is already there.
>
>   Tomi
>
>

