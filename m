From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 00/33] ARM: OMAP2+: PRCM/omap ctrl cleanups against
 3.19-rc1
Date: Wed, 25 Feb 2015 20:47:07 +0200
Message-ID: <54EE18AB.2050402@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com> <20150213183327.GQ2531@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50593 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752552AbbBYSrG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2015 13:47:06 -0500
In-Reply-To: <20150213183327.GQ2531@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com, linux-arm-kernel@lists.infradead.org

On 02/13/2015 08:33 PM, Tony Lindgren wrote:
> Hi Tero,
>
> * Tero Kristo <t-kristo@ti.com> [150213 08:16]:
>> Hi,
>>
>> Updates since v1:
>>
>> - fixed omap2/am33xx boot issues
>> - added regmap support to generic omap clock core
>> - control module driver converted to use syscon
>
> I made some comments to patch 25 of this series detailing
> how we should limit the syscon usage to the scm_conf register
> area only.
>
>> - dropped patches for removing legacy pad muxing support (this is still
>>    needed)
>
> Sounds like this can be moved to the DSS driver using the
> syscon area as long as these are not in the pinctrl-single
> padconf register area. Preferrably implementing some standard
> Linux framework, along the lines pbias-regulator.c is handling
> the SCM register for MMC.
>

I've done some updates/fixes to this set, mostly to address your 
comments and rebase it on top of 4.0-rc1. Will be posting a v3 in a bit.

-Tero
