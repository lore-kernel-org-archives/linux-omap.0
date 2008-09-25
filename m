From: "Girish. S. G." <girishsg@ti.com>
Subject: Re: [PATCH] twl4030-gpio: Remove default pullup enable/disable of
     GPIO
Date: Thu, 25 Sep 2008 23:45:48 +0530 (IST)
Message-ID: <42395.192.168.10.88.1222366548.squirrel@dbdmail.itg.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB028BF72A8E@dbde02.ent.ti.com>
    <200809251020.51152.david-b@pacbell.net>
Reply-To: girishsg@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58766 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533AbYIYSQH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Sep 2008 14:16:07 -0400
In-Reply-To: <200809251020.51152.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

> On Thursday 25 September 2008, Pakaravoor, Jagadeesh wrote:
>> From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
>>
>> One twl4030_request_gpio() should not tamper with the pullup
>> enabling/disabling of the rest of the GPIOs. So removing the default
>> pullup values written to REG_GPIOPUPDCTR1.
>>
>> Signed-off-by: Girish S G <girishsg@ti.com>
>> Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
>
> Acked-by: David Brownell <dbrownell@users.sourceforge.net>
>
> Now I can remove this from my own GPIO cleanups.  ;)
that all MMC/SD signals have
> an external pullup.  (Except maybe DAT4..DAT7 for MMC+.)
>
> Need for such a pullup should be in board-specific init
> data, for boards which need it.

I second that, pullup/dn can go in board-specific file.

Girish


