From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP3: PM: fix save secure RAM to restore MPU power state
Date: Wed, 26 Jan 2011 12:48:44 -0800
Message-ID: <87bp33xufn.fsf@ti.com>
References: <1296003011-26427-1-git-send-email-khilman@ti.com>
	<854C6400F5AA6644BA6FE7953F3E769B0376F954@008-AM1MPN1-012.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:34260 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753725Ab1AZUss (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Jan 2011 15:48:48 -0500
Received: by mail-yi0-f53.google.com with SMTP id 17so315465yib.12
        for <linux-omap@vger.kernel.org>; Wed, 26 Jan 2011 12:48:48 -0800 (PST)
In-Reply-To: <854C6400F5AA6644BA6FE7953F3E769B0376F954@008-AM1MPN1-012.mgdnok.nokia.com>
	(Tero Kristo's message of "Wed, 26 Jan 2011 09:27:03 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tero,

<Tero.Kristo@nokia.com> writes:

>>Currently, on HS/EMU devices, MPU power state forced to on during PM
>>init by the save secure RAM code.  Rather than forcing the state of
>>MPU powerdomain to on, simply read the current value and restore it
>>after the ROM code has run.
>>
>>This only affects the !CPUidle case since when CPUidle is enabled, the
>>MPU power state is dynamically changed by CPUidle.  In the !CPUidle
>>case, MPU power state is initialized once at init and never touched.
>>
>>Cc: Tero Kristo <tero.kristo@nokia.com>
>>Signed-off-by: Kevin Hilman <khilman@ti.com>
>>---
>>If no objectsions, will be queued in my pm-fixes branch for 2.6.38-rc.
>
> Looks good to me. Ack, if you need one.
>  

Thanks, I was looking for your ack.

Kevin
