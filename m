From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 04/12] ARM: OMAP3: mmc-twl4030 fix name buffer length
Date: Mon, 16 Mar 2009 10:14:03 +0000
Message-ID: <20090316101403.GA31868@n2100.arm.linux.org.uk>
References: <20090310205824.16425.97745.stgit@localhost> <20090310210608.16425.95680.stgit@localhost> <20090315160007.GC10786@n2100.arm.linux.org.uk> <49BE2437.6090306@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37664 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757060AbZCPKO2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 06:14:28 -0400
Content-Disposition: inline
In-Reply-To: <49BE2437.6090306@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, David Brownell <dbrownell@users.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Mar 16, 2009 at 12:04:39PM +0200, Adrian Hunter wrote:
> Russell King - ARM Linux wrote:
>> On Tue, Mar 10, 2009 at 02:06:08PM -0700, Tony Lindgren wrote:
>>> From: Adrian Hunter <adrian.hunter@nokia.com>
>>>
>>> Add 1 to buffer length for null terminator.
>>
>> Yes, and:
>>
>>                 sprintf(twl->name, "mmc%islot%i", c->mmc, 1);
>>
>> should be snprintf to ensure that it can't overflow the buffer.
>>
>
> There are only 3 controllers and everyone numbers them 1, 2 and 3.

So?  You've already had a buffer overflow, so it's clearly time that this
code got fixed properly.
