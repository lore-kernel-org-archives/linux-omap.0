From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 00/11] OMAP3 CPUidle patches
Date: Fri, 4 Jul 2008 14:05:56 +0300
Message-ID: <20080704110556.GA4397@codecarver.research.nokia.com>
References: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com> <20080702131127.GA4404@codecarver.research.nokia.com> <000701c8dc48$d1ce66a0$68bf18ac@ent.ti.com> <20080702154253.GC4404@codecarver.research.nokia.com> <004d01c8dce8$56eec0b0$68bf18ac@ent.ti.com> <87prpum7nr.fsf@trdhcp146196.ntc.nokia.com> <873amqknae.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:35359 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754462AbYGDLGW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jul 2008 07:06:22 -0400
Content-Disposition: inline
In-Reply-To: <873amqknae.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>
Cc: ext Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org

> 
> So Rajendra sent his uImage and it works quite ok what comes to off
> mode on my sdp board. I still see problems with serial console (slow)
> and on boot I need to generate manually interrupts to get it to
> boot. Otherwise board hangs at this point:
> 
> eth0: link up
> Sending DHCP requests ., OK
> IP-Config: Got DHCP answer from 0.0.0.0, my address is 192.168.2.101
> IP-Config: Complete:
>      device=eth0, addr=192.168.2.101, mask=255.255.255.0, 
> gw=192.168.2.1,
>      host=192.168.2.101, domain=ntc.nokia.com, nis-domain=(none),
>      bootserver=0.0.0.0, rootserver=172.22.146.197, rootpath=
> Looking up port of RPC 100003/2 on 172.22.146.197
> Looking up port of RPC 100005/1 on 172.22.146.197
> VFS: Mounted root (nfs filesystem).
> Freeing init memory: 108K
> 
> Rajendra, are you still using .config file you sent to me? Are all the
> changes in your tree available in l-o list.

I tried the same uImage here on my SDP. It goes to off nicely after
bootup, but after using the console, VDD2 does not to off anymore. VDD1
does go to off.

Cheers,

Peter.
