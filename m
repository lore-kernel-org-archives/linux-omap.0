From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: commit fc7b92fca4e546184557f1c53f84ad57c66b7695 broke
 compilation
Date: Tue, 15 Dec 2009 14:15:39 +0200
Message-ID: <20091215121539.GI3689@nokia.com>
References: <20091215115806.GG3689@nokia.com>
 <19F8576C6E063C45BE387C64729E739404372AAF22@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49210 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689AbZLOMQ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 07:16:56 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404372AAF22@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Krishnamoorthy, Balaji T" <balajitk@ti.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, Dec 15, 2009 at 01:05:01PM +0100, ext Krishnamoorthy, Balaji T wrote:
>> -----Original Message-----
>> From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
>> Sent: Tuesday, December 15, 2009 5:28 PM
>> To: Linux OMAP Mailing List
>> Cc: Krishnamoorthy, Balaji T
>> Subject: commit fc7b92fca4e546184557f1c53f84ad57c66b7695 broke compilation
>>
>> Hi,
>>
>> the patch renaming twl4030 to twl broke compilation of several omap
>> boards.
>>
>> Here are all the files including a file that doesn't exist anymore:
>>
>Thanks Felipe,
>I am preparing a patch for this.

please, compile test with all omap3 defconfigs to be sure.

something like:

for i in `ls arch/arm/configs | grep omap | grep -v 'omap-l137'`; do
	make CROSS_COMPILE=arm-linux- ARCH=arm $i defconfig;
	make CROSS_COMPILE=arm-linux- ARCH=arm;
done

this won't get rx51_defconfig or n8x0_deconfig nor n770_defconfig, but 
it's good enough. rx51_defconfig is the only of those three that twl4030 
anyways.

-- 
balbi
