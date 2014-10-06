From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: CPSW bug with AM437x SK
Date: Mon, 6 Oct 2014 15:24:59 +0530
Message-ID: <543266F3.4090200@ti.com>
References: <20141003010418.GA9612@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39790 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbaJFJz2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Oct 2014 05:55:28 -0400
In-Reply-To: <20141003010418.GA9612@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Friday 03 October 2014 06:34 AM, Felipe Balbi wrote:
> [  261.177168] [<c0648d48>] (skb_panic) from [<c0565edc>] (skb_put+0x5c/0x60)
> [  261.184415] [<c0565edc>] (skb_put) from [<c0605aac>] (unix_stream_sendmsg+0x164/0x390)
> [  261.192712] [<c0605aac>] (unix_stream_sendmsg) from [<c055b364>] (sock_aio_write+0xdc/0xfc)
> [  261.201475] [<c055b364>] (sock_aio_write) from [<c014c42c>] (do_sync_write+0x8c/0xb4)
> [  261.209697] [<c014c42c>] (do_sync_write) from [<c014cf70>] (vfs_write+0x118/0x1c0)
> [  261.217652] [<c014cf70>] (vfs_write) from [<c014d564>] (SyS_write+0x4c/0xa0)
> [  261.225054] [<c014d564>] (SyS_write) from [<c000ed40>] (ret_fast_syscall+0x0/0x48)
> [  261.232988] Code: e58d4008 e58de00c e59f0008 ebfff48e (e7f001f2) 
> [  261.239378] ---[ end trace d64258d586f40104 ]---

The BT shows that the warn came from a unix socket interface, so this
cannot be a CPSW bug, its a bug in unix socket.

Are you not seeing this issue with file system in any other media?

I will try to reproduce this locally with my AM437x EVMsk.

Regards
Mugunthan V N
