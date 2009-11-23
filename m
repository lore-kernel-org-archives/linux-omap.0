From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/3] OMAP: omap_device: optionally auto-adjust device
 activate/deactivate latencies
Date: Mon, 23 Nov 2009 10:35:47 -0800
Message-ID: <4B0AD603.3050609@deeprootsystems.com>
References: <1258997622-13923-1-git-send-email-khilman@deeprootsystems.com> <1258997622-13923-2-git-send-email-khilman@deeprootsystems.com> <1258997622-13923-3-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:47125 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188AbZKWSfn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 13:35:43 -0500
Received: by pzk1 with SMTP id 1so4142979pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 10:35:49 -0800 (PST)
In-Reply-To: <1258997622-13923-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Kevin Hilman wrote:
> First, this patch adds new worst-case latency values to the
> omap_device_pm_latency struct.  Here the worst-case measured latencies
> for the activate and deactivate hooks are stored.
> 
> In addition, add an option to auto-adjust the latency values used for
> device activate/deactivate.
> 
> By setting a new 'OMAP_DEVICE_LATENCY_AUTO_ADJUST' flag in the
> omap_device_pm_latency struct, the omap_device layer automatically
> adjusts the activate/deactivate latencies to the worst-case measured
> values.
> 
> Anytime a new worst-case value is found, it is printed to the console.
> Here is an example log during boot using UART2 s an example.  After
> boot, the OPP is manually changed to the 125MHz OPP:
> 
> [...]
> Freeing init memory: 128K
> omap_device: serial8250.2: new worst case deactivate latency 0: 30517
> omap_device: serial8250.2: new worst case activate latency 0: 30517
> omap_device: serial8250.2: new worst case activate latency 0: 218139648
> omap_device: serial8250.2: new worst case deactivate latency 0: 61035
> omap_device: serial8250.2: new worst case activate latency 0: 278076171
> omap_device: serial8250.2: new worst case activate latency 0: 298614501
> omap_device: serial8250.2: new worst case activate latency 0: 327331542
> 
> / # echo 125000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
> 
> omap_device: serial8250.2: new worst case deactivate latency 0: 91552
> 
> Motivation: this can be used as a technique to automatically determine
> the worst case latency values.  The current method of printing a
> warning on every violation is too noisy to actually interact the
> console in order to set low OPP to discover latencies.

Another motivation for this patch is that the activate/deactivate 
latenices can vary depending on the idlemode of the device.  While 
working on the UART I noticed that when using no-idle, the activate 
latencies were as high as several hundred msecs as shown above.  When 
the UARTs are in smart-idle, the max latency is well under 100 usecs.

Kevin
