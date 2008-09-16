From: "Ramesh Gupta Guntha" <x0023949@ti.com>
Subject: RE: Question about timers used in dsp bridge
Date: Tue, 16 Sep 2008 19:59:00 +0530
Message-ID: <200809161429.m8GET1AQ006641@dbdp31.itg.ti.com>
References: <87r67k8ed0.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47956 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754372AbYIPO3R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Sep 2008 10:29:17 -0400
In-Reply-To: <87r67k8ed0.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?'=22H=F6gander=22_Jouni'?= <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi Jouni,
 
<snip>

> > In Dsp Bridge GPT5 is used as BIOS_CLK and used only while 
> DSP is starting, this is disabled once the DSP is started. 
> > GPT6 is used for load monitoring purpose by DSP Bridge. GPT6 is 
> > disabled only if the DSP enters into sleep state i.e. Hibernation.
> 
> Thanks for your explanation. Is it entering sleep state 
> itself and then informing bridge driver about this or is it 
> bridge which asks dsp to enter hibernation?

This is for both the cases like DSP initiated Hibernation , usually this happens if there is no activity for certain predefined amount of time and for system suspend where bridge asks dsp to enter into hibernation, for these two cases GPT6 is disabled.

Regards
Ramesh Gupta G

