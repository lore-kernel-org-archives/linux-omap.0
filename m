From: Kalle Valo <kalle.valo@nokia.com>
Subject: Re: Nokia Internet Tablets
Date: Fri, 02 Jan 2009 16:35:45 +0200
Message-ID: <87k59d6aim.fsf@nokia.com>
References: <20081222103422.GL29448@guug.org>
	<20081222122757.GI7125@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48820 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbZABOgI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jan 2009 09:36:08 -0500
In-Reply-To: <20081222122757.GI7125@gandalf.research.nokia.com> (ext Felipe Balbi's message of "Mon\, 22 Dec 2008 14\:27\:57 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: ext Otto Solares <solca@guug.org>, linux-omap@vger.kernel.org

"ext Felipe Balbi" <felipe.balbi@nokia.com> writes:

> On Mon, Dec 22, 2008 at 04:34:22AM -0600, ext Otto Solares wrote:
>> Hi all!
>> 
>> I want to resurrect missing support for the Nokia Internet Tablets
>> starting with the N8x0s for my NITdroid project, which uses just
>> standard Linux kernel APIs.
>> 
>> So first I would like to ask some very newbie questions:
>> 
>> -Is there any ongoing effort to support these devices in latest kernels
>>  at the same level as the latest Nokia production kernel (2.6.21-omap)?
>
> n8x0 devices should boot fine with current linux-omap and I'd say we
> have all the drivers here as well, besides audio, camera and wifi (me thinks)

For wifi there is stlc45xx:

http://stlc45xx.garage.maemo.org/

Also Christian Lamparter is adding stlc4550 support to p54, check
linux-wireless list archives for more (search for p54spi).

-- 
Kalle Valo
