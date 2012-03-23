From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 13/13] Add dummy smsc911x regulators to zoom-debugboard.
Date: Fri, 23 Mar 2012 10:49:10 +0200
Message-ID: <4F6C3906.5070605@compulab.co.il>
References: <20120321194133.GP9859@atomide.com> <1332393594-23993-1-git-send-email-Russ.Dill@ti.com> <1332393594-23993-14-git-send-email-Russ.Dill@ti.com> <20120322113722.GF3091@opensource.wolfsonmicro.com> <CA+Bv8XZudbzx_CpiYzOJ5q9BvcBDJiWzxfCakEGzODN-6Mv03Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:59309
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753965Ab2CWIt2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Mar 2012 04:49:28 -0400
In-Reply-To: <CA+Bv8XZudbzx_CpiYzOJ5q9BvcBDJiWzxfCakEGzODN-6Mv03Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org

Hi Russ, Mark,

On 03/22/12 20:29, Russ Dill wrote:
> On Thu, Mar 22, 2012 at 4:37 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Wed, Mar 21, 2012 at 10:19:54PM -0700, Russ Dill wrote:
>>
>>> +static struct regulator_consumer_supply dummy_supplies[] = {
>>> +     REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
>>> +     REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
>>
>> Why do none of these boards use -1 as the ID for the device?
> 
> Commit 21b42731 (omap: convert boards that use SMSC911x to use
> gpmc-smsc911x) changed several board files to use the gpmc-smsc911x.c
> common code rather than register the device themselves, in the process
> it changed many of the id's from -1 to 0. This happened in the 3.0
> merge window. I can certainly change it back.

IIRC, everybody were very sensible to each new l-o-f back then,
so making the id = 0 (leaving it uninitialized) helped with
reducing some ~10 lines more...
Of course we can change this now, but what is the real problem
with having device id = 0 and not -1?


-- 
Regards,
Igor.
