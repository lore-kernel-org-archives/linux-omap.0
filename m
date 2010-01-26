From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC/PATCH 1/5] usb: otg: add notifier support
Date: Tue, 26 Jan 2010 16:19:36 +0200
Message-ID: <20100126141935.GG10690@nokia.com>
References: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com>
 <1260531086-23857-2-git-send-email-felipe.balbi@nokia.com>
 <201001260316.20529.david-b@pacbell.net>
 <20100126141016.GD10690@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37083 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab0AZOVb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 09:21:31 -0500
Content-Disposition: inline
In-Reply-To: <20100126141016.GD10690@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: ext David Brownell <david-b@pacbell.net>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Grazvydas Ignotas <notasas@gmail.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>

Hi again,

On Tue, Jan 26, 2010 at 03:10:16PM +0100, Balbi Felipe (Nokia-D/Helsinki) wrote:
>On Tue, Jan 26, 2010 at 12:16:20PM +0100, ext David Brownell wrote:
>>On Friday 11 December 2009, Felipe Balbi wrote:
>>> The notifier will be used to communicate usb events
>>> to other drivers like the charger chip.
>>
>>Good idea ... but not OTG-specific.  It doesn't seem to me
>
>thanks

just remember of another problem which I couldn't solve yet:

if you boot the board with the usb cable already attached, then we miss 
the first notification because when the notifier is called, usb 
controller driver isn't probed yet.

-- 
balbi
