From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC/PATCH 1/5] usb: otg: add notifier support
Date: Fri, 11 Dec 2009 13:58:11 +0200
Message-ID: <20091211115811.GD12526@nokia.com>
References: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com>
 <1260531086-23857-2-git-send-email-felipe.balbi@nokia.com>
 <20091211115538.GB25806@sirena.org.uk>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:26474 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754887AbZLKL6q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 06:58:46 -0500
Content-Disposition: inline
In-Reply-To: <20091211115538.GB25806@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Grazvydas Ignotas <notasas@gmail.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, David Brownell <dbrownell@users.sourceforge.net>

On Fri, Dec 11, 2009 at 12:55:38PM +0100, ext Mark Brown wrote:
>On Fri, Dec 11, 2009 at 01:31:22PM +0200, Felipe Balbi wrote:
>> The notifier will be used to communicate usb events
>> to other drivers like the charger chip.
>
>> This can be used as source of information to kick
>> usb charger detection as described by the USB
>> Battery Charging Specification 1.1 and/or to
>> pass bMaxPower field of selected usb_configuration
>> to charger chip in order to use that information
>> as input current on the charging profile
>> setup.
>
>This one looks reasonable to me, though I've not thought it through
>properly yet.  Could you please add me to the CC list for future
>revisions of this - I've got some charger drivers that could use this?

Sure I'll do it. I want to start the discussion on this, so if you have 
any comments, please, do comment.

-- 
balbi
