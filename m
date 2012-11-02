From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: OMAP: hwmod: Add possibility to count hwmod
 resources based on type
Date: Fri, 2 Nov 2012 09:50:23 +0100
Message-ID: <5093894F.7040300@ti.com>
References: <1351596296-13825-1-git-send-email-peter.ujfalusi@ti.com> <1351596296-13825-2-git-send-email-peter.ujfalusi@ti.com> <509106FD.2040804@ti.com> <509374A4.8050806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59903 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755313Ab2KBIu3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 04:50:29 -0400
In-Reply-To: <509374A4.8050806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Salut P=E9ter,

On 11/2/2012 8:22 AM, P=E9ter Ujfalusi wrote:
> Hi Benoit,
>
> On 10/31/2012 12:09 PM, Cousson, Benoit wrote:
>> Hi Peter,
>>
>> That's great you've have done that fix.
>>
>> On 10/30/2012 12:24 PM, Peter Ujfalusi wrote:
>>> Add flags parameter for omap_hwmod_count_resources() so users can t=
ell which
>>> type of resources they are interested when counting them in hwmod d=
atabase.
>>
>> Mmm, does it worth doing that for every resources considering that t=
his is a
>> temporary situation and than only the DMA resources are an issue so =
far?
>
> I think it is better to have nice API - even for a short term - than =
introduce
> a new wrapper just to count the DMA resources.
> Yes we only use this to either count all resources or to count the DM=
A
> resources only, but the other options does not look better either:
> 1. omap_hwmod_count_dma_resources(struct omap_hwmod *oh)
> 2. omap_hwmod_count_resources(struct omap_hwmod *oh, bool dma_only)

=46air enough. I'm OK with that. I'll take theses patches, except if Pa=
ul=20
already have a 3.8 branch for hwmod.

Regards,
Benoit

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
