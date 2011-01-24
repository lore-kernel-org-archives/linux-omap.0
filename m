From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3] OMAP: Enable Magic SysRq on serial console ttyOx
Date: Mon, 24 Jan 2011 13:47:21 -0800
Message-ID: <8739oi7z4m.fsf@ti.com>
References: <1295604084-27761-1-git-send-email-weber@corscience.de>
	<AANLkTikSznkcNwkVaPswx=zr8FFGQPVMw_AebF9ymZLE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:40843 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751339Ab1AXVr0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 16:47:26 -0500
In-Reply-To: <AANLkTikSznkcNwkVaPswx=zr8FFGQPVMw_AebF9ymZLE@mail.gmail.com>
	(Govindraj's message of "Fri, 21 Jan 2011 15:42:57 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Thomas Weber <weber@corscience.de>, linux-omap@vger.kernel.org, manjugk@ti.com, gadiyar@ti.com, tony@atomide.com, govindraj@ti.com, gregkh@suse.de, andrei.emeltchenko@nokia.com, linux-kernel@vger.kernel.org

Govindraj <govindraj.ti@gmail.com> writes:

> On Fri, Jan 21, 2011 at 3:31 PM, Thomas Weber <weber@corscience.de> wrote:
>> Magic SysRq key is not working for OMAP on new serial
>> console ttyOx because SUPPORT_SYSRQ is not defined
>> for omap-serial.
>>
>> This patch defines SUPPORT_SYSRQ in omap-serial and
>> enables handling of Magic SysRq character.
>>
>> Further there is an issue of losing first break character.
>> Removing the reset of the lsr_break_flag fixes this issue.
>>
>> Signed-off-by: Thomas Weber <weber@corscience.de>
>
>
> Acked-by: Govindraj.R <govindraj.raja@ti.com>
> Tested-by: Manjunath G Kondaiah <manjugk@ti.com>
>

Acked-by: Kevin Hilman <khilman@ti.com>

Greg, this one should go for .38-rc.   Feel free to merge, or we can
take it through the OMAP tree with your ack.

Thanks,

Kevin

