From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v4 00/11] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Fri, 11 Jul 2014 12:24:22 -0500
Message-ID: <53C01DC6.9040804@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com> <53BF996E.8020801@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39492 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114AbaGKRYv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Jul 2014 13:24:51 -0400
In-Reply-To: <53BF996E.8020801@zonque.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Suman Anna <s-anna@ti.com>, Benoit Cousson <bcousson@baylibre.com>, =?ISO-8859-1?Q?Pascal_H=FCrst?= <pascal.huerst@bluewin.ch>

On 07/11/2014 02:59 AM, Daniel Mack wrote:
> On 07/11/2014 04:55 AM, Dave Gerlach wrote:
>> This series adds suspend/resume support for am335x. Version 3 of this
>> series can be found at [1]. I apologize for the large delay between this
>> and the previous revision. This code has been heavily refined
>> since the last version based on the various comments received for v3. The
>> major change from previous version is moving all wkup_m3 code into a
>> remoteproc based driver. The new driver handles all IPC and fw loading
>> and exposes a small API to be used by PM code to achieve low power states.
>
> Thanks a lot for this new series, Dave!
>
> I've given it a quick test on a custom AM335x board and can confirm
> success. Tested with both DDR2 and DDR3 versions, both work fine, and
> power consumption drops to a reasonable level.
>

I appreciate you trying it out!

Regards,
Dave

> I'd be very happy if these patches made it in for 3.17, but I haven't
> followed the discussion on the patches this set depends on.
>
>
> Best regards,
> Daniel
>

