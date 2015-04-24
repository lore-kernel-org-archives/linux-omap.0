From: Jack Mitchell <ml@communistcode.co.uk>
Subject: Re: Enabling IPU on OMAP44xx
Date: Fri, 24 Apr 2015 20:31:30 +0100
Message-ID: <553A9A12.5020404@communistcode.co.uk>
References: <553A6D80.1080307@communistcode.co.uk> <553A8CBE.7010505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eumx.net ([91.82.101.43]:55366 "EHLO owm.eumx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755669AbbDXTbg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Apr 2015 15:31:36 -0400
In-Reply-To: <553A8CBE.7010505@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Jack Mitchell <ml@communistcode.co.uk>, linux-omap@vger.kernel.org



On 24/04/15 19:34, Nishanth Menon wrote:
> On 04/24/2015 11:21 AM, Jack Mitchell wrote:
>> I've been fighting for a week with trying to get the IPU booted over
>> remoteproc on an OMAP4470. I feel like I've got most of the way there
> we do not have support for OMAP4470 on git.kernel.org.
>
> If you are interested in TI vendor kernel support, please use e2e.ti.com.
>
> ...
>

Hi Nishanth,

I understand; and booting an omap4470 isn't the issue, I've hacked in 
the support for booting it as it's basically the same as 4460; which is 
supported. It's the IPU that I'm trying to get working, which is the 
same across all the 44xx omap SoCs, right? I'm using the latest mainline 
and the logs I posted are from the git HEAD early this morning.

I'm not looking for offical support, just pointers to people who may 
have been using mainline and the IPU, the support seems to be in there 
but none of the plumbing so I assume someone is probably using it 
otherwise it's dead code.

Cheers,
Jack.


