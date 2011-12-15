From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: kconfig: Enable devicetree by default
 for OMAP2+ systems
Date: Thu, 15 Dec 2011 17:28:49 +0100
Message-ID: <4EEA2041.6070304@ti.com>
References: <y> <1323190149-6492-2-git-send-email-b-cousson@ti.com> <1323782836.1877.79.camel@deskari> <4EE75448.4010701@ti.com> <20111213223855.GW32251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54405 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756221Ab1LOQ3A (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 11:29:00 -0500
In-Reply-To: <20111213223855.GW32251@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/13/2011 11:38 PM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [111213 05:02]:
>> On 12/13/2011 2:27 PM, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> On Tue, 2011-12-06 at 17:49 +0100, Benoit Cousson wrote:
>>>> devicetree will become the mandatory boot method for OMAP2+.
>>>> In order to avoid cluttering the OMAP code with #ifdef CONFIG_OF,
>>>> select USE_OF by default for every OMAP2+ systems.
>>>> Select as well the APPENDED_DTB and ATAG_DTB_COMPAT to allow legacy
>>>> boot loader to keep working properly.
>>>
>>> APPENDED_DTB sounds a bit dangerous to be enabled by default according
>>> to the config help text.
>>
>> The help is indeed really scary :-)
>
> Heh, but it's also true.
>
>> Tony,
>> Do we want to keep it by default? Or should we fix the kconfig help?
>
> Let's just leave out those two from omap2plus_defconfig then.

OK. I'll do that.

Benoit

