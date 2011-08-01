From: Michael Jones <michael.jones@matrix-vision.de>
Subject: timing in driver function
Date: Mon, 01 Aug 2011 17:15:26 +0200
Message-ID: <4E36C30E.9060809@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail1.matrix-vision.com ([78.47.19.71]:37396 "EHLO
	mail1.matrix-vision.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979Ab1HAPVn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 11:21:43 -0400
Received: from mail1.matrix-vision.com (localhost [127.0.0.1])
	by mail1.matrix-vision.com (Postfix) with ESMTP id C787B722BC
	for <linux-omap@vger.kernel.org>; Mon,  1 Aug 2011 17:15:27 +0200 (CEST)
Received: from erinome (g2.matrix-vision.com [80.152.136.245])
	by mail1.matrix-vision.com (Postfix) with ESMTPA id 9AB83722B0
	for <linux-omap@vger.kernel.org>; Mon,  1 Aug 2011 17:15:27 +0200 (CEST)
Received: from erinome (localhost [127.0.0.1])
	by erinome (Postfix) with ESMTP id D13D56F8A
	for <linux-omap@vger.kernel.org>; Mon,  1 Aug 2011 17:15:26 +0200 (CEST)
Received: from [192.168.65.46] (host65-46.intern.matrix-vision.de [192.168.65.46])
	by erinome (Postfix) with ESMTPA id AF4C06F8A
	for <linux-omap@vger.kernel.org>; Mon,  1 Aug 2011 17:15:26 +0200 (CEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I have a function in a driver which takes ~50ms to execute, which I've
measured by reading jiffies at the beginning and end. But jiffies only
counts at 128Hz on my system, so this was a very coarse measurement. Now
I would like to find out more exactly where the time is going inside
this function. So my basic question is, what is the best way to measure
lapsed time with reasonable resolution on an OMAP?

As I had done with the jiffies measurement, what I imagined was
inserting lines into my function, sampling the value of some counter at
various points within it. This approach is crude but simple and would
suffice for my case.

Since it must be a very common task, I thought I'd ask here what the
recommended approach is. I see a few directions...

1. Using the OMAP's 32kHz timer, which is provided as a "struct
clocksource". It seems like what I would want is to call
clocksource_32k.read(), but I don't know how to retrieve clocksource_32k.

2. Using the ARM core's Performance Monitor Count Registers. This seems
to be what perf_event uses. I'm not familiar with perf_events, but it
sounds like I would also need to build 'perf', which according to
http://www.omappedia.org/wiki/Using_perf isn't possible to
cross-compile. I don't want to tackle that without some reassurance that
it is the right/only way.

I am currently using a 2.6.38 kernel.

thanks,
Michael

MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Erhard Meier
