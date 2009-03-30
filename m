From: Igor Mazanov <i.mazanov@gmail.com>
Subject: Re: Latest l-o and usb gadget + NFS root problems
Date: Mon, 30 Mar 2009 10:47:20 +0400
Message-ID: <gqptap$jje$1@ger.gmane.org>
References: <1238146821.28118.36.camel@tubuntu> <20090328160605.cd4e6325.jhnikula@gmail.com>
Reply-To: i.mazanov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:38961 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204AbZC3HuF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Mar 2009 03:50:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LoCFu-0003sQ-NT
	for linux-omap@vger.kernel.org; Mon, 30 Mar 2009 07:50:02 +0000
Received: from ppp91-122-64-9.pppoe.avangarddsl.ru ([91.122.64.9])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2009 07:50:02 +0000
Received: from i.mazanov by ppp91-122-64-9.pppoe.avangarddsl.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2009 07:50:02 +0000
In-Reply-To: <20090328160605.cd4e6325.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Jarkko Nikula wrote:
> On Fri, 27 Mar 2009 11:40:21 +0200
> Tomi Valkeinen <tomi.valkeinen@nokia.com> wrote:
> 
>> Hi,
>>
>> There seems to be something wrong with latest l-o, usb gadget ethernet
>> and nfsroot. I'm not sure when it broke, but 2.6.29-rc3 worked fine.
>> This happens to me with beagleboard and a non-public omap3 board:
>>
> I saw something very similar couple days ago on N810 and ethernet
> gadget. What was weird that when connection jammed, then also localhost
> stopped working. Unfortunately I didn't debug any further would it
> happen e.g. using BT PAN connection.
> 
> 
> Jarkko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

I got stuck in same problem last week. A reason was napi related changes 
in net/core/dev.c. There is a discussion and workaround too in LKML,

Revert "gro: Fix legacy path napi_complete crash", (was: Re: Linux

http://marc.info/?t=123789988400005&r=1&w=2

Regards,
Igor.

