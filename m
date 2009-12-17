From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Anyone using an ISP1505?
Date: Thu, 17 Dec 2009 21:10:05 +0200
Message-ID: <20091217191005.GA30191@nokia.com>
References: <4B2A7FFB.6090909@billgatliff.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37883 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965311AbZLQTMR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 14:12:17 -0500
Content-Disposition: inline
In-Reply-To: <4B2A7FFB.6090909@billgatliff.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Bill Gatliff <bgat@billgatliff.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>

Hi,

On Thu, Dec 17, 2009 at 08:01:15PM +0100, ext Bill Gatliff wrote:
>I'm working on an OMAP3530CUS board that uses an ISP1505 USB PHY, and I
>haven't gotten much luck getting the kernel to recognize any USB
>devices.  No luck, actually.  :)  My oscilloscope and the schematic say
>that the hardware is wired up properly, I'm just wondering if anyone has
>a similar configuration that's working for them--- and which kernel they
>are using?
>
>The only thing I'm a little concerned about is the possibility that the
>"nop" transceiver isn't the right one for the ISP1505.  I have seen
>patches floating around that claim to support the ISP1504, which should
>be compatible with the 1505 if the datasheet is to be believed; but
>those patches were in the context of i.MX3x machines, and they also
>depended on a "slim framework for external transceivers" patch that
>AFAICT hasn't been merged anywhere despite having been posted back in June.
>
>Said patches can be found here:
>
>http://kerneltrap.org/mailarchive/linux-usb/2009/6/10/5909543
>
>Anyone have any ideas on how to pursue this, before I start chasing a
>solution down myself?

is this with musb ? if it's musb, you need the nop transceiver. Do you 
have any boot logs which you could share ? Without information on the 
board, is a bit difficult :-(

-- 
balbi
