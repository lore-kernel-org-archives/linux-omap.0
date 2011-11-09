From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: 3.2-rc1 boot broken on OMAP1 / Amstrad E3
Date: Thu, 10 Nov 2011 00:55:42 +0200
Message-ID: <B8A6ED05-78AC-4140-A9B8-8265F1E9C32F@iki.fi>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:52991 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501Ab1KIWym (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Nov 2011 17:54:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Has anyone managed to boot 3.2-rc1 on OMAP1?

On Amstrad E3 it seems to hang at very early on the boot (below  
output is
with earlyprintk enabled):

Uncompressing Linux... done, booting the kernel.
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.2.0-rc1-e3 (aaro@dell) (gcc version  
4.6.1 (GCC) ) #1 PREEMPT Thu Nov 10 00:23:15 EET 2011
[    0.000000] CPU: ARM925T [54029252] revision 2 (ARMv4T), cr=0000317f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: Amstrad E3 (Delta)
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writethrough
[    0.000000] OMAP1510
[    0.000000]  revision 2 handled as 15xx id: bc058c9b93111a16

Then it prints just some random garbage and hangs.

A.

