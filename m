From: <mika.kukkonen@nokia.com>
Subject: RE: [PATCH] DSPBRIDGE: Various compile warning fixes
Date: Tue, 26 Jan 2010 07:03:59 +0100
Message-ID: <20D73E2631F7914F868646E119DEC1CE2102582DE0@NOK-EUMSG-02.mgdnok.nokia.com>
References: <e237d5197c6847e669ff873a432a387b5c4dd2f6.1264080558.git.ameya.palande@nokia.com>,<4B5DCDDB.10409@ti.com>
 <DDE834F1D8D96540B7373DFF675BF56C1B8A2B5AA0@NOK-EUMSG-03.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46931 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab0AZGEM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 01:04:12 -0500
In-Reply-To: <DDE834F1D8D96540B7373DFF675BF56C1B8A2B5AA0@NOK-EUMSG-03.mgdnok.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ameya.palande@nokia.com, omar.ramirez@ti.com
Cc: linux-omap@vger.kernel.org, nm@ti.com, deepak.chitriki@ti.com

 

>-----Original Message-----
>From: Palande Ameya (Nokia-D/Helsinki) 
>Sent: 25 January, 2010 19:03
>To: ext Omar Ramirez Luna
>Cc: linux-omap@vger.kernel.org; Menon, Nishanth; Chitriki 
>Rudramuni, Deepak; Kukkonen Mika (Nokia-D/Helsinki)
>Subject: RE: [PATCH] DSPBRIDGE: Various compile warning fixes
>
>Hi Omar,
>
>Sorry for the top posthing :(
>I guess the original patch had empty if() bodies. 
>That comment can be removed :)

No, the empty if() bodies fix is the chunk that modifies
those macros:

>> -#define DBC_Assert(exp)
>> -#define DBC_Require(exp)
>> -#define DBC_Ensure(exp)
>> +#define DBC_Assert(exp) {}
>> +#define DBC_Require(exp) {}
>> +#define DBC_Ensure(exp) {}
(...)
>> -#define DBG_Exit(void)
>> +#define DBG_Exit(void) do {} while (0)

etc. Those are used in code as

if (whatever)
   do_stuff();
else
   DBC_Assert(exp);
do_something_else();

and you really want to DBC_Assert() not to be totally
empty, but instead evaluate to an empty statement block.

--MiKu