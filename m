From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC 00/24] Move OMAP2+ over to use COMMON clock
Date: Mon, 04 Jun 2012 14:08:10 +0530
Message-ID: <4FCC73F2.4030808@ti.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1206010735540.17068@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:47933 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752823Ab2FDIiR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jun 2012 04:38:17 -0400
Received: by obhx4 with SMTP id x4so8211912obh.6
        for <linux-omap@vger.kernel.org>; Mon, 04 Jun 2012 01:38:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1206010735540.17068@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Friday 01 June 2012 07:07 PM, Paul Walmsley wrote:
> On Fri, 1 Jun 2012, Rajendra Nayak wrote:
>
>> This RFC series is based of Mikes' latest clk-next. I will
>> rebase it once 3.5-rc1 is out and post with more testing thats
>> in progress. Meanwhile, the RFC is for me to get some early
>> feedback on the patches.
>
> Please describe further what's been tested with this series, and what
> hasn't been.

Hi Paul,

I have been mostly boot-testing on the OMAP3/4 boards I have access to, 
3430SDP, 3630 Beagle, 4430 Panda/SDP. Apart from this I was using
omapconf to run the clkspeed audit tests on OMAP4.
I used powerdebug to make sure the tree modeling (parent/child
relations, clk rates etc) are sane after bootup.
I haven't done any low power tests around suspend/idle for OMAP3
or OMAP4 which is on my list to do before I do a repost/rebase on
3.5-rc1. And so is testing on OMAP2430sdp and N800. Any other tests
you recommend I do?

Meanwhile it would be good to know if you see any major issues around
the migration itself and/or the way the patches are structured.

regards,
Rajendra

>
>
> - Paul

