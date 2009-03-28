From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Latest l-o and usb gadget + NFS root problems
Date: Sat, 28 Mar 2009 16:06:05 +0200
Message-ID: <20090328160605.cd4e6325.jhnikula@gmail.com>
References: <1238146821.28118.36.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f165.google.com ([209.85.219.165]:47397 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbZC1OGd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 28 Mar 2009 10:06:33 -0400
Received: by ewy9 with SMTP id 9so1434380ewy.37
        for <linux-omap@vger.kernel.org>; Sat, 28 Mar 2009 07:06:30 -0700 (PDT)
In-Reply-To: <1238146821.28118.36.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 27 Mar 2009 11:40:21 +0200
Tomi Valkeinen <tomi.valkeinen@nokia.com> wrote:

> Hi,
> 
> There seems to be something wrong with latest l-o, usb gadget ethernet
> and nfsroot. I'm not sure when it broke, but 2.6.29-rc3 worked fine.
> This happens to me with beagleboard and a non-public omap3 board:
> 
I saw something very similar couple days ago on N810 and ethernet
gadget. What was weird that when connection jammed, then also localhost
stopped working. Unfortunately I didn't debug any further would it
happen e.g. using BT PAN connection.


Jarkko
