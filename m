From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 03/10] mfd: twl-core: Add initial DT support for twl4030/twl6030
Date: Mon, 19 Dec 2011 14:53:29 +0100
Message-ID: <4EEF41D9.30101@ti.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com> <1323439361-1647-4-git-send-email-b-cousson@ti.com> <20111219120321.GM11800@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53124 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752450Ab1LSNxm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 08:53:42 -0500
In-Reply-To: <20111219120321.GM11800@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: tony@atomide.com, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Balaji T K <balajitk@ti.com>, Graeme Gregory <gg@slimlogic.co.uk>

Salut Samuel,

On 12/19/2011 1:03 PM, Samuel Ortiz wrote:
> Hi Benoit,
>
> On Fri, Dec 09, 2011 at 03:02:34PM +0100, Benoit Cousson wrote:
>> Add initial device-tree support for twl familly chips.
>> The current version is missing the regulator entries due
>> to the lack of DT regulator bindings for the moment.
>> Only the simple sub-modules that do not depend on
>> platform_data information can be initialized properly.
>>
>> Add documentation for the Texas Instruments TWL Integrated Chip.
> Thanks, patch applied.

Thanks,
Benoit


