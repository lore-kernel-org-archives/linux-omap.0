From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: android-omap-2.6.29 for gumstix overo
Date: Fri, 17 Jul 2009 21:30:16 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F56F1524@dbde02.ent.ti.com>
References: <3B4B1B95-38FA-4F26-8CD9-6A50346F9C76@mac.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F5679BDF@dbde02.ent.ti.com>
 <B78C377E-8474-4310-BAAF-1877111EA730@mac.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F5679BE1@dbde02.ent.ti.com>
 <44A80450-2A36-402C-9E41-940C0F400C89@mac.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F5679BEA@dbde02.ent.ti.com>
 <53FB694B-B432-4E7B-A2B1-42367D3741B3@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36611 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964834AbZGQQAb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jul 2009 12:00:31 -0400
In-Reply-To: <53FB694B-B432-4E7B-A2B1-42367D3741B3@mac.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Elvis Dowson [mailto:elvis.dowson@mac.com]
>Sent: Friday, July 17, 2009 7:09 AM
>To: Pandita, Vikram
>Cc: Linux OMAP Users
>Subject: android-omap-2.6.29 for gumstix overo
>
>Hi Vikram,
>
>On Jul 15, 2009, at 1:26 AM, Pandita, Vikram wrote:
>
>> All this is already available and integrated on android public git
>> tree.
>> This had DSS2 and PM.
>>
>> http://android.git.kernel.org/?p=kernel/omap.git;a=summary
>> Head: android-omap-2.6.29
>> Validated on Zoom2.
>
>I'm taking a look at the android-omap-2.6.29 and trying to see if I
>can get it to work for the overo.
>
>I just have a quick question, the board-zoom2.c file does not seem to
>include an OMAP PM support, for example:
>
>#include <mach/omap-pm.h>
>#include "pm.h"
>#include "omap3-opp.h"
>
>I need a reference example of OMAP PM working for a TI OMAP3503 target.

PM have various parts. Depends what you are looking for.

OSIdle path is enabled, can hit core retention.
OFF is hit only after disabling some drivers.

Especially android uses the system wide suspend..

The OPP tables are not yet populated in following in zoom2 board file:
	 omap2_init_common_hw(NULL, NULL, NULL, NULL);

Hence that part may not work.


>
>Best regards,
>
>Elvis
>

