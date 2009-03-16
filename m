From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH 04/12] ARM: OMAP3: mmc-twl4030 fix name buffer length
Date: Mon, 16 Mar 2009 12:04:39 +0200
Message-ID: <49BE2437.6090306@nokia.com>
References: <20090310205824.16425.97745.stgit@localhost> <20090310210608.16425.95680.stgit@localhost> <20090315160007.GC10786@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40480 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbZCPKEZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 06:04:25 -0400
In-Reply-To: <20090315160007.GC10786@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, David Brownell <dbrownell@users.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Russell King - ARM Linux wrote:
> On Tue, Mar 10, 2009 at 02:06:08PM -0700, Tony Lindgren wrote:
>> From: Adrian Hunter <adrian.hunter@nokia.com>
>>
>> Add 1 to buffer length for null terminator.
> 
> Yes, and:
> 
>                 sprintf(twl->name, "mmc%islot%i", c->mmc, 1);
> 
> should be snprintf to ensure that it can't overflow the buffer.
> 

There are only 3 controllers and everyone numbers them 1, 2 and 3.

The change is the other patch.

