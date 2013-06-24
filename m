From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH] ARM: multi_v7: Add OMAP with ramdisk config bits
Date: Mon, 24 Jun 2013 20:19:06 +0530
Message-ID: <51C85C62.5030709@ti.com>
References: <1371071282-14750-1-git-send-email-santosh.shilimkar@ti.com> <20130618082422.GE5523@atomide.com> <51C07253.3040909@ti.com> <51C858B4.2020106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39110 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161Ab3FXOtr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jun 2013 10:49:47 -0400
In-Reply-To: <51C858B4.2020106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>

On Monday 24 June 2013 08:03 PM, Sricharan R wrote:
> Hi,
> On Tuesday 18 June 2013 08:14 PM, Santosh Shilimkar wrote:
>> On Tuesday 18 June 2013 04:24 AM, Tony Lindgren wrote:
>>> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130612 14:14]:
>>>> Add ramdisk fileystem related options which lets OMAP5 and Keystone
>>>> SOCs to boot till shell with multi_v7_config.
>>> Please add also other v7 omaps.
>>>
>> Should have done first place. Sorry.
>> Will update other machines and after testing, repost it.
>>
>> Regards,
>> Santosh
>>
>  Since CONFIG_ARCH_OMAP2PLUS=y is set in the patch,
>  OMAP3, OMAP4 are getting enabled by default.
>
>  I tested OMAP4 PANDA on mainline + multi_v7_config + above patch
>  and it booted up fine.
  Also tested on OMAP3 beagle-xm and beagle-bone black (am335x-bone.dtb)
  and booted up fine.

Regards,
 Sricharan
