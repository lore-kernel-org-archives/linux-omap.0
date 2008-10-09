From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] twl4030-core: fix a typo
Date: Fri, 10 Oct 2008 01:24:10 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087023958D5DE@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB028C6305D0@dbde02.ent.ti.com>
 <20081009160713.GA12091@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49967 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753929AbYJITyZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 15:54:25 -0400
In-Reply-To: <20081009160713.GA12091@frodo>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>, "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>


>To: Pakaravoor, Jagadeesh
>On Thu, Oct 09, 2008 at 08:44:49PM +0530, Pakaravoor, Jagadeesh wrote:
>> From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
>>
>> Fix a trivial typo.
>
>please Cc Samuel Ortiz <sameo@openedhand.com> and lkml

Samuel already fixed this. 
	http://lkml.org/lkml/2008/10/8/166

>
>
>> Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
>> ---
>> Index: linux-omap-git/drivers/mfd/twl4030-core.c
>> ===================================================================
>> --- linux-omap-git.orig/drivers/mfd/twl4030-core.c	2008-10-09 18:32:15.000000000 +0530
>> +++ linux-omap-git/drivers/mfd/twl4030-core.c	2008-10-09 20:40:18.007239952 +0530
>> @@ -57,7 +57,7 @@
>>  #define DRIVER_NAME			"twl4030"
>>
>>  #if defined(CONFIG_TWL4030_BCI_BATTERY) || \
>> -	defined(CONFIG_TWL4030_BCI_BATTERY_MODUEL)
>> +	defined(CONFIG_TWL4030_BCI_BATTERY_MODULE)
>>  #define twl_has_bci()		true
>>  #else
>>  #define twl_has_bci()		false
