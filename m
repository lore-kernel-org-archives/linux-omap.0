From: astralstorm@gen2.org
Subject: Re: 2.6.26-rc3-omap vs N810 and Xomap
Date: Sat, 31 May 2008 13:40:09 +0200 (CEST)
Message-ID: <49335.89.77.116.159.1212234009.squirrel@gen2.org>
References: <20080525203855.2f6037f6@gen2.org> <483E6778.1030003@seznam.cz>
    <42148.89.77.116.159.1212233636.squirrel@gen2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gen2.org ([194.181.7.159]:38493 "EHLO gen2.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071AbYEaLkK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 31 May 2008 07:40:10 -0400
In-Reply-To: <42148.89.77.116.159.1212233636.squirrel@gen2.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Frantisek Dufka <dufkaf@seznam.cz>, Radoslaw Szkodzinski <astralstorm@gen2.org>, linux-omap@vger.kernel.org

>> Radoslaw Szkodzinski wrote:
>>> Hello,
>>>
>>> I've managed to get 2.6.26-rc3-omap booting (was quite easy actually).
>>> Now I hit a road block - I get everything to start, it boots nicely
>>> (checked with SSH), but fails to display anything except a white
>>> screen.
>>> Looks like Xomap can't (re)init framebuffer, or focus isn't transferred
>>> to it.
>>> Any known possible reasons?
>>>
>>
>> Maybe your Xomap is built with older omapfb.h? I don't know about 2.6.2x
>> kernels but I was bitten by this when trying Xomap binary built for N800
>> with 2.6.18 on 770 with 2.6.16 kernel. There was change in
>> OMAPFB_UPDATE_WINDOW ioctl and the symptomps were similar.
>>
>
> Possible, but nobody has the sources for Xomap I think.

Correction, the source of Nokia Xomap are open, so I'll probably just need
a rebuild.


