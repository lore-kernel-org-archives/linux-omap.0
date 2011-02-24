From: Michael Jones <michael.jones@matrix-vision.de>
Subject: Re: [024/115] USB: prevent buggy hubs from crashing the USB stack
Date: Thu, 24 Feb 2011 10:53:34 +0100
Message-ID: <4D662A9E.90007@matrix-vision.de>
References: <4D64C81B.5060807@ahsoftware.de> <Pine.LNX.4.44L0.1102231021210.2233-100000@iolanthe.rowland.org> <20110224085735.GD3528@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail1.matrix-vision.com ([78.47.19.71]:51520 "EHLO
	mail1.matrix-vision.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172Ab1BXJxh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 04:53:37 -0500
In-Reply-To: <20110224085735.GD3528@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Alan Stern <stern@rowland.harvard.edu>, Alexander Holler <holler@ahsoftware.de>, Greg KH <gregkh@suse.de>, Kernel development list <linux-kernel@vger.kernel.org>, stable@kernel.org, stable-review@kernel.org, torvalds@linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, USB list <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org

On 02/24/2011 09:57 AM, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Feb 23, 2011 at 10:26:20AM -0500, Alan Stern wrote:
>> In both cases, it appears that the problem is caused by the fact that 
>> the musb host-controller driver doesn't set the hcd->has_tt flag.
>>
>> Felipe, you should know where it belongs.  It should be easy enough to 
>> add.
> 
> Sure Alan, it's attached to this mail. Compile tested only though.
> Michael, would you care to give your tested-by ?
> 

Alexander already did, but I can do now, too.  Thanks for the fix.

Tested-by: Michael Jones <michael.jones@matrix-vision.de>

MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
