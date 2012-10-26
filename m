From: Roger Quadros <rogerq@ti.com>
Subject: Re: Commit 4f3e8d263 breaks NFS root on Nokia N900
Date: Fri, 26 Oct 2012 11:59:50 +0300
Message-ID: <508A5106.1020008@ti.com>
References: <50898A82.4020403@iki.fi> <20121025185900.GA18473@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35790 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757752Ab2JZJAB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Oct 2012 05:00:01 -0400
In-Reply-To: <20121025185900.GA18473@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Timo Kokkonen <timo.t.kokkonen@iki.fi>, linux-omap@vger.kernel.org

On 10/25/2012 09:59 PM, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Oct 25, 2012 at 09:52:50PM +0300, Timo Kokkonen wrote:
>> Hi,
>>
>> There is something wrong with the USB since commit 4f3e8d263. I am no
>> longer able to boot from an NFS root with that commit applied. The
>> kernel boots fine, it appears to be able to mount the root over the NFS
>> but then after that, the USB networking appears to hang. Reverting the
>> commit in question makes USB networking fully operational again.
>>
>> The kernel config and boot logs are attached.
> 
> Roger, this is the second big regression because of that patch. I guess
> it's best to revert that while you work on a better patch. Sounds good ?
> 

Yes let's revert that. should have done more testing. my bad.

regards,
-roger
