From: javier Martin <javier.martin@vista-silicon.com>
Subject: cpufreq support for the Beagleboard.
Date: Mon, 21 Mar 2011 11:42:07 +0100
Message-ID: <AANLkTi=mWbpi7i6if5TdBCoi0bUFGWcxOba1kZ+6EePa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62905 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997Ab1CUKmH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Mar 2011 06:42:07 -0400
Received: by iwn34 with SMTP id 34so6248069iwn.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Mar 2011 03:42:07 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,
I am testing latest 2.6.38 stable kernel with my Beagleboard xM. I
have enabled CONFIG_CPU_FREQ option and several governors.
However, when I boot the board and execute "cpufreq-info" I get the following:

root@beagleboard:~# cpufreq-info
cpufrequtils 006: cpufreq-info (C) Dominik Brodowski 2004-2009
Report errors and bugs to cpufreq@vger.kernel.org, please.
analyzing CPU 0:
  no or unknown cpufreq driver is active on this CPU
  maximum transition latency: 0.00 ms.

I've read some information in this wiki: http://elinux.org/OMAP_Power_Management

It seems that cpufreq is still not in mainline but it should be
already on pm branch of omap repository. However, I've also tried
compiling this one and I've got the same problem.

Could anyone clarify whether cpufreq is supported or not in the
Beagleboard xM and where?

Thank you.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
