From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: AM3517 DaVinci EMAC Ethernet performance issues
Date: Thu, 4 Apr 2013 14:02:06 +0530
Message-ID: <515D3A86.6000504@ti.com>
References: <1365042051.84279.YahooMailNeo@web160501.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33152 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933093Ab3DDIcT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Apr 2013 04:32:19 -0400
In-Reply-To: <1365042051.84279.YahooMailNeo@web160501.mail.bf1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: CF Adad <cfadad@rocketmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>

On 4/4/2013 7:50 AM, CF Adad wrote:
> We've done network captures on our link, and the problem is very 
> strange. The iperf client transmits data quickly and steadily for a 
> while, but then all the sudden just stops. In the captures you can see 
> an ACK come back from the server for the frame that was just sent, but 
> then instead of immediately sending the next one it just sits there 
> for sometimes several seconds. Then, it suddenly picks back up and 
> starts running again. It's as though it just paused due to lack of data. 
The same kind of issue was observed in different SoC with Davinci EMAC
and resolved by the patch below. Can you make sure the patch is applied
in your kernel and take the performance again.
https://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?id=7e51cde276ca820d526c6c21cf8147df595a36bf

Regards
Mugunthan V N
