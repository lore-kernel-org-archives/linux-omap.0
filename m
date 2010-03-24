From: Felipe Balbi <felipe.balbi@NOKIA.COM>
Subject: Re: [PATCH v3] arm: omap1/2/3/4: convert clocksource to a
 platform_driver
Date: Wed, 24 Mar 2010 08:34:28 +0200
Message-ID: <20100324063428.GA7534@nokia.com>
References: <1269346981-30147-1-git-send-email-felipe.balbi@nokia.com>
 <1269350966-9311-1-git-send-email-felipe.balbi@nokia.com>
 <87iq8mc3oc.fsf@deeprootsystems.com>
Reply-To: felipe.balbi@NOKIA.COM
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34113 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab0CXGe6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 02:34:58 -0400
Content-Disposition: inline
In-Reply-To: <87iq8mc3oc.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@NOKIA.COM>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, Mar 23, 2010 at 07:07:31PM +0100, ext Kevin Hilman wrote:
>Felipe Balbi <felipe.balbi@nokia.com> writes:
>
>> Convert the omap32k clocksource driver into a platform_driver
>> and while at that, also remove the ifdeferry around the code.
>>
>> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
>
>Looks like a good direction, but it still is rather tied to the 32k
>sync timer.  We also have the ability to use a GPtimer as a
>clocksource (see the clocksource register in timer-gp.c.)  By default,
>we are always using the 32k timer for PM reasons, but we need the ability
>to register any timer as clocksource.  This problably means just splitting
>a little more the driver part and the device part.
>
>Also, the new clocksource.c file should reference from whence it came.
>A lot of that was copy/pasted from the older code so copyrights/author
>credits should follow.

all add back the credits, missed that sorry but I believe the gp timer 
part is subject to another patch, no ? Otherwise this will start to 
become one huge unreviewable patch.

-- 
balbi
