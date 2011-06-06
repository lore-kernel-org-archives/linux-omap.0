From: Luciano Coelho <coelho@ti.com>
Subject: Re: Oops on ehci_hcd when booting 3.0.0-rc2 on panda
Date: Mon, 06 Jun 2011 14:05:48 +0300
Message-ID: <1307358348.23002.419.camel@cumari>
References: <1307356643.23002.413.camel@cumari>
	 <20110606104417.GP18731@legolas.emea.dhcp.ti.com>
	 <20110606110218.GS18731@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:35844 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754330Ab1FFLFx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 07:05:53 -0400
In-Reply-To: <20110606110218.GS18731@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>

On Mon, 2011-06-06 at 14:02 +0300, Felipe Balbi wrote: 
> On Mon, Jun 06, 2011 at 01:44:18PM +0300, Felipe Balbi wrote:
> > looks like this is resulting from the missing hwmod conversion in
> > mainlnie. Check if reverting 7e6502d577106fb5b202bbaac64c5f1b065e6daa
> > helps.
> 
> I verified off-list with Luca that reverting that commit does make it
> work. Keshava, care to send a revert patch to Sam until we get all the
> hwmod stuff in.

Yes, I confirm that I'm not getting the oops anymore, after reverting
this patch.

Thanks a lot for the quick answer, dude! :)

-- 
Cheers,
Luca.

