From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v5 REPOST 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
Date: Fri, 04 Mar 2011 13:42:34 -0800
Message-ID: <87r5amftpx.fsf@ti.com>
References: <1299252837-18074-1-git-send-email-dave.martin@linaro.org>
	<AANLkTimz0Ko9GFtLTcBQVV_c2DAPU5XhV47xT+R9Q7mv@mail.gmail.com>
	<7b1ef0e49e8b8c1c20b0965a58c4fe73@mail.gmail.com>
	<20110304174709.GB20560@atomide.com>
	<AANLkTi=UCk5thBSM_JpFPRAr_POtx-DphP-DrVLBNyMG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:54657 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760219Ab1CDVml (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 16:42:41 -0500
Received: by mail-yi0-f54.google.com with SMTP id 12so1158614yie.41
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 13:42:40 -0800 (PST)
In-Reply-To: <AANLkTi=UCk5thBSM_JpFPRAr_POtx-DphP-DrVLBNyMG@mail.gmail.com>
	(Dave Martin's message of "Fri, 4 Mar 2011 18:16:13 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Jean Pihet-XID <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org

Dave Martin <dave.martin@linaro.org> writes:

> On Fri, Mar 4, 2011 at 5:47 PM, Tony Lindgren <tony@atomide.com> wrote:
>> * Santosh Shilimkar <santosh.shilimkar@ti.com> [110304 09:36]:
>>> >
>>> > Following up on this, it looks like I have some locally-recorded
>>> > acks
>>> > which didn't make it into my posting ...
>>
>> To me looks like this is ready to go, but I'd like to see Kevin's
>> acks on this one as this touches the PM code.
>>
>> Or if Kevin wants to take the series, here's my ack for the series:
>>
>> Acked-by: Tony Lindgren <tony@atomide.com>

Yeah, I'll queue this series.

> Thanks -- I'll wait for Kevin to comment also.

I have to give one more round of sanity testing to this series, but
otherwise I have no outstanding issues.  I also need to coordinate with
Santosh on this because he has an additional cleanup series that touches
the same code.

Dave, just to confirm something The outstanding toolchain bugs only
affect compiling in Thumb-2 mode, right?  IOW, if I merge just this
series (without having the other toolchain workaround patches) we should
still be able to compile/run fine in ARM mode, correct?

Kevin


