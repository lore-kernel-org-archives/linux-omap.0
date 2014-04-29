From: sourav <sourav.poddar@ti.com>
Subject: Re: [PATCH 3/5] arm: omap2: skip device build from platform code
 for dt.
Date: Tue, 29 Apr 2014 14:21:36 +0530
Message-ID: <535F6818.5060406@ti.com>
References: <1397651532-31456-1-git-send-email-sourav.poddar@ti.com> <1397651532-31456-4-git-send-email-sourav.poddar@ti.com> <alpine.DEB.2.02.1404281827410.14616@utopia.booyaka.com> <20140428183922.GV30292@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37546 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680AbaD2IwP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Apr 2014 04:52:15 -0400
In-Reply-To: <20140428183922.GV30292@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Paul Walmsley <paul@pwsan.com>, tony@atomide.com, zbr@ioremap.net, michael.opdenacker@free-electrons.com, wsa@the-dreams.de, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday 29 April 2014 12:09 AM, Felipe Balbi wrote:
> On Mon, Apr 28, 2014 at 06:28:45PM +0000, Paul Walmsley wrote:
>> On Wed, 16 Apr 2014, Sourav Poddar wrote:
>>
>>> For SOCs with dt enabled, device should be build through device tree.
>>> Prevent device build call from platform code, if device tree is
>>> enabled.
>>>
>>> Signed-off-by: Sourav Poddar<sourav.poddar@ti.com>
>> Isn't OMAP2+ only supporting DT device enumeration now?
> At least OMAP3 still isn't Dt-only.
>
Yes, for omap3 boards only, I have kept a #ifndef. Else we could
have remove this code.
