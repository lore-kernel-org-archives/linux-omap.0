From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: usb_nop_xceiv_register() missing when OTG built as modules
Date: Fri, 5 Mar 2010 11:04:26 +0200
Message-ID: <20100305090426.GG12757@nokia.com>
References: <87635d54nn.fsf@deeprootsystems.com>
 <19F8576C6E063C45BE387C64729E7394044DB7B6BD@dbde02.ent.ti.com>
 <87eik03scn.fsf@deeprootsystems.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:44972 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505Ab0CEJFO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 04:05:14 -0500
Content-Disposition: inline
In-Reply-To: <87eik03scn.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Mar 04, 2010 at 06:32:40PM +0100, ext Kevin Hilman wrote:
>Yes, I did that intentionally.  I *want* USB compiled as a module.  If
>I do that, the build fails, and that's a bug that needs to be fixed.

it depends on where you're calling usb_nop_xceiv_register(), if you're 
calling from a file that's built-into the kernel, then it's your fault.

I suggest you keep usb as a module, but keep nop xceiv built-in.

-- 
balbi
