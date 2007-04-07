From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [RFC-PATCH] Move i2c adaptor speed from a module parameter
 toplatform device resource
Date: Sat, 07 Apr 2007 10:34:20 -0500
Message-ID: <4617B9FC.8060102@gmail.com>
References: <9C23CDD79DA20A479D4615857B2E2C47A19D34@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47A19D34@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Syed Mohammed, Khasim stated on 4/6/2007 5:00 PM:
>> This, however, requires the following follow up patches:
>> * Move i2c platform from plat-omap to respective board files.
>> *    Reasoning: I2C speed at 100Khz is not always optimal for I2C1 by
>> *      default (e.g. 3430).
>> *    Impact: all board files will need to have it...but it will ensure
>> *    that the i2c init is done in the proper sequence - 1 followed by
>>     
> 2.
>
> We had discussed this before, but Tony was not "for" this approach.
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-November/008
>
>   
The argument then was that we could have a common definition for all
platform. if we look at our code, if have enough amount of #ifdefs that
we have been trying to avoid..
at the very least, it should move out to mach-omapx/devices.c
Regards,
Nishanth Menon
