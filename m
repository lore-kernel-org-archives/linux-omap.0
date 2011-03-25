From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] omap: hwmod: add syss reset done flags to omap2, omap3
 hwmods
Date: Fri, 25 Mar 2011 15:42:12 +0100
Message-ID: <4D8CA9C4.3060504@ti.com>
References: <1298542123-3654-1-git-send-email-avinashhm@ti.com> <alpine.DEB.2.00.1103031427580.10981@utopia.booyaka.com> <20110314161609.GA10506@avinash-laptop> <alpine.DEB.2.00.1103242336410.21987@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59366 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059Ab1CYOmA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 10:42:00 -0400
In-Reply-To: <alpine.DEB.2.00.1103242336410.21987@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Mahadeva, Avinash" <avinashhm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Hilman, Kevin" <khilman@ti.com>

Hi Paul,

On 3/25/2011 6:38 AM, Paul Walmsley wrote:
> Hi Avinash,
>
>>> On Thu, 24 Feb 2011, Avinash.H.M wrote:
>>>
>>>> Some of the omap2, omap3 peripherals support software reset. This
>>>> can be done through the softreset bit in sysconfig register.
>>>> The reset status can be checked through resetdone bit of
>>>> sysstatus register. syss_has_reset_status is added to the hwmod
>>>> database of peripherals which have resetdone bit in sysstatus register.
>>>>
>>>> Cc: Rajendra Nayak<rnayak@ti.com>
>>>> Cc: Paul Walmsley<paul@pwsan.com>
>>>> Cc: Benoit Cousson<b-cousson@ti.com>
>>>> Cc: Kevin Hilman<khilman@ti.com>
>>>> Reviewed-by: Govindraj.R<govindraj.raja@ti.com>
>>>> Signed-off-by: Avinash.H.M<avinashhm@ti.com>
>
> This patch is causing I2C softreset timeouts in the hwmod layer on OMAP2
> and 3.  Could you please take a look at this and figure out what is going
> on?

I think this is probably due to the nasty I2C softreset bug with 
discussed last year with Paul Brady.

AFAIR, the I2C cannot be reset by just writing to the SYSCONFIG 
softreset bit. You need to play with other registers too.

Avinash,
You should try to look at 3430 or 3630 errata. You will probably find 
the bug I'm referring to.


Benoit

