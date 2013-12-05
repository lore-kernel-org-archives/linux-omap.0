From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [Bug] am33xx: Basic suspend resume support: Doesn't resume
Date: Thu, 05 Dec 2013 14:42:56 +0100
Message-ID: <1386250976.3880.91.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:36480 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756679Ab3LENnA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Dec 2013 08:43:00 -0500
Received: by mail-bk0-f50.google.com with SMTP id e11so7239828bkh.9
        for <linux-omap@vger.kernel.org>; Thu, 05 Dec 2013 05:42:59 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com, Russ Dill <Russ.Dill@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-omap@vger.kernel.org, Daniel Mack <zonque@gmail.com>

Hi,

 I'm having here a custom am335x board with DDR3 equipped trying to
setup suspend/resume support. I have tested this with the ancient
TI-PSP-3.2 Kernel and current 3.13-rc plus some pm patches.

Problem: After suspending the device, it doesn't resume (freeze):

echo "mem" > /sys/power/state
[  103.020845] PM: Syncing filesystems ... done.
[  103.055549] Freezing user space processes ... (elapsed 0.003 seconds) done.
[  103.066696] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
[  103.077506] PM: Sending message for entering DeepSleep mode
[  103.099896] PM: suspend of devices complete after 11.951 msecs
[  103.110894] PM: late suspend of devices complete after 4.659 msecs
[  103.122599] PM: noirq suspend of devices complete after 5.032 msecs

As a wakeup source I'm currently using gpio0_12.

Triggering the reset button (am335x-pin: WARMRSTn) in suspend-mode has
no effect, which is fine. But after changing the signal on the wakeup
source (here gpio0_12), triggering a reset works fine again.

So it seems to me that somewhere in the wakeup-process is a bug.

Could this be related to DDR3? Apart from that, this custom board here
is pretty similar to the ti-evm board wich works fine.

In oder to test, I've shrunken the kernel to minimal driver support to
sort out as much as possible segfaults in resume functions.

With a view to be able to debug this further, I just ordered an openocd
jtag adapter.

Any comments, ideas, tips, ..?

Thanks
 -- Christoph

