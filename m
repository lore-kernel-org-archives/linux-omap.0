From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: kconfig: Enable devicetree by default
 for OMAP2+ systems
Date: Tue, 13 Dec 2011 14:34:00 +0100
Message-ID: <4EE75448.4010701@ti.com>
References: <y>  <1323190149-6492-2-git-send-email-b-cousson@ti.com> <1323782836.1877.79.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39634 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764Ab1LMNeL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 08:34:11 -0500
In-Reply-To: <1323782836.1877.79.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, tony@atomide.com
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/13/2011 2:27 PM, Tomi Valkeinen wrote:
> Hi,
>
> On Tue, 2011-12-06 at 17:49 +0100, Benoit Cousson wrote:
>> devicetree will become the mandatory boot method for OMAP2+.
>> In order to avoid cluttering the OMAP code with #ifdef CONFIG_OF,
>> select USE_OF by default for every OMAP2+ systems.
>> Select as well the APPENDED_DTB and ATAG_DTB_COMPAT to allow legacy
>> boot loader to keep working properly.
>
> APPENDED_DTB sounds a bit dangerous to be enabled by default according
> to the config help text.

The help is indeed really scary :-)

Tony,
Do we want to keep it by default? Or should we fix the kconfig help?

Regards
Benoit

