From: Michael =?ISO-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
Subject: Re: Nokia CBUS code
Date: Tue, 22 Feb 2011 12:12:07 +0100
Message-ID: <1298373127.6998.25.camel@maggie>
References: <1298371692.6998.19.camel@maggie>
	 <20110222110512.GM2979@legolas.emea.dhcp.ti.com>
	 (sfid-20110222_120521_379084_6E682CB3)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:38649 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260Ab1BVLMN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Feb 2011 06:12:13 -0500
In-Reply-To: <20110222110512.GM2979@legolas.emea.dhcp.ti.com> (sfid-20110222_120521_379084_6E682CB3)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap <linux-omap@vger.kernel.org>

On Tue, 2011-02-22 at 13:05 +0200, Felipe Balbi wrote: 
> > That probably is a major effort, as it needs a rewrite in some parts,
> > but I'm certainly interested in getting it mainlined, because I'm
> > currently developing a driver on top of it.
> 
> We're almost there actually. Retu is in great shape and tahvo is a lot
> simpler, but it still needs help. Probably porting the changes I made on
> retu would be the way to go.

Ok, that's pretty cool. I'll try to port this to OpenWRT, soon,
to check how it works.


On another issue: Did you try tahvo-usb recently?
I was trying it with the OpenWRT cbus codebase (which is some months
old) and I couldn't get it to work. It would always crash with
some weird NULL pointer accesses and stuff like this. I was wondering
if the omap-tree tahvo code would actually work on the USB device.

-- 
Greetings Michael.

