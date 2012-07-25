From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: Re: [PATCH v4 1/4] ARM: OMAP4: Remove un-used control module headers
 and defines.
Date: Wed, 25 Jul 2012 15:17:48 +0400
Message-ID: <500FD5DC.7010002@dev.rtsoft.ru>
References: <500FD2E9.8050408@dev.rtsoft.ru> <20120725110635.GE16794@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:53940 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756422Ab2GYLRu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jul 2012 07:17:50 -0400
In-Reply-To: <20120725110635.GE16794@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>

  Hi, Balbi.

On 07/25/2012 03:06 PM, Felipe Balbi wrote:
> Hi,
>
> On Wed, Jul 25, 2012 at 03:05:13PM +0400, Konstantin Baydarov wrote:
>> Most of the OMAP4 control module register defines are not used and
>> can be removed. Keep only needed defines and move them to common
>> control module header just like other OMAP versions.
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>> Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
> Wasn't this one authored by Santosh ?? Where's his From: Santosh
> Shilimkar ???

I hit "edit as new" when I sent patches through thunderbird, I'll fix in the next series.

  BR,
    Konstantin Baydarov.

>

