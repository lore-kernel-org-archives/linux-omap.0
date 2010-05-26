From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: usb_nop_xceiv_register() missing when OTG built as modules
Date: Wed, 26 May 2010 09:03:21 +0300
Message-ID: <20100526060321.GE3069@nokia.com>
References: <87635d54nn.fsf@deeprootsystems.com>
 <19F8576C6E063C45BE387C64729E7394044DB7B6BD@dbde02.ent.ti.com>
 <87eik03scn.fsf@deeprootsystems.com>
 <20100305090426.GG12757@nokia.com>
 <871vfy3azr.fsf@deeprootsystems.com>
 <558f5bffd42210a777154737d6730232@secure211.sgcpanel.com>
 <87y6i6zatj.fsf@deeprootsystems.com>
 <20100522235310.GA15859@matterhorn.lan>
 <19F8576C6E063C45BE387C64729E7394044E61643A@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47658 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766Ab0EZGDs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 02:03:48 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E61643A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>, Kevin Hilman <khilman@deeprootsystems.com>, "me@felipebalbi.com" <me@felipebalbi.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

On Mon, May 24, 2010 at 09:07:37AM +0200, ext Gupta, Ajay Kumar wrote:
>Hi,
>> Here is a compile-tested patch since I haven't seen this fixed in mainline
>> yet.  It applies to the tip of Linus' tree.
>>
>> Attempting to remove usb_nop_xceiv_register() completely will require
>> someone
>> with more knowledge of davinci and blackfin archs to comment on what
>> boards
>> need the platform_device defined.
>
>NAK..
>This is an incorrect fix as it duplicates the code snippet which
>is already present in nop file.

I don't believe you understood the purpose of the original patch:

The idea is that currently, it's impossible to build a board which uses 
nop transceiver and have that be a module because when you'll have an 
undefined function being used on a board file.

Removing the call to nop_xceiv_register() and using a 
platform_device_register() is the way to go, since it's only 4 ~ 5 lines 
of code anyway.

ps: you really think that adding more and more ifdefs is better than 
Amit's patch ??

-- 
balbi

DefectiveByDesign.org
