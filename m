From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] musb: Add extvbus in musb_board_data
Date: Wed, 24 Mar 2010 11:58:26 +0200
Message-ID: <20100324095826.GM29419@nokia.com>
References: <1266985840-15220-1-git-send-email-ajay.gupta@ti.com>
 <19F8576C6E063C45BE387C64729E7394044DE0EB5E@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:36222 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677Ab0CXJ7R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 05:59:17 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DE0EB5E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>

On Tue, Mar 23, 2010 at 01:46:18PM +0100, ext Gupta, Ajay Kumar wrote:
>Hi,
>> -----Original Message-----
>> From: Gupta, Ajay Kumar
>> Sent: Wednesday, February 24, 2010 10:01 AM
>> To: linux-omap@vger.kernel.org
>> Cc: felipe.balbi@nokia.com; Gupta, Ajay Kumar
>> Subject: [PATCH] musb: Add extvbus in musb_board_data
>>
>> EXTVBUS programming is required by OMAP3EVM REV >=E to supply 500mA
>> power so adding a flag which can be used by musb driver to program
>> EXTVBUS.
>
>Felipe,
>
>Any comment on this one ?

applied, thanks

-- 
balbi
