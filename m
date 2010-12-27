From: Felipe Balbi <balbi@ti.com>
Subject: Re: [GIT PULL] OMAP USB Changes for Merge Window
Date: Mon, 27 Dec 2010 11:22:42 +0200
Message-ID: <20101227092242.GC2301@legolas.emea.dhcp.ti.com>
References: <20101223084734.GA3149@legolas.emea.dhcp.ti.com>
 <20101223203920.GQ7771@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:36031 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753101Ab0L0JWs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Dec 2010 04:22:48 -0500
Received: by eyd10 with SMTP id 10so4085649eyd.17
        for <linux-omap@vger.kernel.org>; Mon, 27 Dec 2010 01:22:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101223203920.GQ7771@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi,

On Thu, Dec 23, 2010 at 12:39:20PM -0800, Tony Lindgren wrote:
>* Felipe Balbi <balbi@ti.com> [101223 00:47]:
>> Hi Tony,
>>
>> please queue the following two patches for Merge Window.
>>
>> The following changes since commit b79540fcbbcf9b379c9197f63c5a883bbe3adfd4:
>>
>>    Linux-omap rebuilt: Merged branches from Paul and Kevin and mux changes (2010-12-22 19:13:33 -0800)
>
>This can't be pulled as it would pull in tons of non-mainline
>commits from the linux-omap master branch.

heh, my bad. Craneboard wasn't in mainline then I rebased on top of your
tree.

>Everybody, all the pullable branches must be based on something
>in the mainline kernel, like a recent -rc tag. If that won't work,
>then some commit needs to be agreed on separately that will go
>to mainline, like the omap-for-linus branch.

Makes sense.

>Further, please wait few days before sending the pull request
>in case somebody wants to ack your patches. Sending a pull request
>with the patches to be reviewed is kind of pointless.. Sure in this

the patches were actually for reference, much like Greg does with the
USB patches.

>case these are pretty trivial patches, but still.

patch 1 was pending on l-o for weeks, only patch 2 is new.

>Anyways, I'll apply these into a temporary branch and will
>merge into omap-for-linus within next few days assuming no
>problems.

good, thanks.

-- 
balbi
