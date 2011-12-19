From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP: I2C: prepare to use hwmod reset in driver
Date: Mon, 19 Dec 2011 23:07:40 +0530
Message-ID: <4EEF7664.3000203@ti.com>
References: <alpine.DEB.2.00.1112160254320.12660@utopia.booyaka.com> <20111216195002.GL32251@atomide.com> <alpine.DEB.2.00.1112161314180.12660@utopia.booyaka.com> <20111216204123.GM32251@atomide.com> <alpine.DEB.2.00.1112161357250.12660@utopia.booyaka.com> <20111217002409.GB6464@atomide.com> <4EED9DD4.3020506@ti.com> <4EEF6714.2040208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:44432 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751172Ab1LSRht (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 12:37:49 -0500
Received: by mail-iy0-f171.google.com with SMTP id w33so11149020iag.16
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 09:37:45 -0800 (PST)
In-Reply-To: <4EEF6714.2040208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Monday 19 December 2011 10:02 PM, Cousson, Benoit wrote:
> Hi Shubhro,
>
> On 12/18/2011 9:01 AM, Shubhrajyoti wrote:
>
> [...]
>
>> The driver does a reset in the error path.
>> Since we are not supposed to access the sysc reg the function is needed.
>
> I'm just wondering what will happen to the driver if this callback is
> not provided during the device creation? This is what will happen
> during DT boot for example?
>
> Is it a mandatory function?
This is used in the recovery mechanism in case of errors like some one
holding the bus and not releasing it etc.

>
> Thanks,
> Benoit

