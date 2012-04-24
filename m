From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHv8 06/10] I2C: OMAP: Fix the crash in i2c remove
Date: Tue, 24 Apr 2012 23:44:15 +0530
Message-ID: <4F96ED77.9070503@ti.com>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com> <1334842101-20670-7-git-send-email-shubhrajyoti@ti.com> <20120423164944.GE27321@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:50994 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755842Ab2DXSOY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 14:14:24 -0400
Received: by pbbrq13 with SMTP id rq13so425121pbb.8
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 11:14:23 -0700 (PDT)
In-Reply-To: <20120423164944.GE27321@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ben-linux@fluff.org, tony@atomide.com, stable@vger.kernel.org

On Monday 23 April 2012 10:19 PM, Wolfram Sang wrote:
>>     [  154.901153] Exception stack(0xdf9b9fb0 to 0xdf9b9ff8)
>> >     [  154.907104] 9fa0:                                     beaf1f04 4006be00 0000000f 0000000c
>> >     [  154.915710] 9fc0: 4006c000 00000000 00008034 ffffff40 00000007 00000000 00000000 0007b8d7
>> >     [  154.916778] 9fe0: 00000000 beaf1b68 0000d23c 4005baf0 80000010 ffffffff
>> >     [  154.931335]  r6:ffffffff r5:80000010 r4:4005baf0 r3:beaf1f04
>> >     [  154.937316] ---[ end trace 1b75b31a2719ed21 ]--
>> > 
>> > Cc: <stable@vger.kernel.org>
>> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Is this really the correct solution? I do wonder that every driver using
> runtime PM should enable the clocks on their own. That should be done by
> the core, 
By core you don't mean the i2c core but the pm layer right?
> I'd say; it is not unusual that drivers need to write to
> registers in remove(). If it is correct, can I get some acks?
I did see the crash.

Will wait for the pm experts to comment.

>> > ---
>> >  drivers/i2c/busses/i2c-omap.c |    2 ++

>> >  1 files changed, 2 insertions(+), 0 deletions(-)
>> > 

