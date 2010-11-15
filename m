From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: BeagleBoard not resuming from uart with latest pm-core ?
Date: Mon, 15 Nov 2010 11:50:05 +0100
Message-ID: <20101115115005.30b35e75@surf>
References: <20101110164414.4529cbda@surf>
	<AANLkTi=Dzv2XE-X_z6yiCaRjgWrST5QGDE9dFDnDy9pT@mail.gmail.com>
	<87pqudaxtm.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:37497 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006Ab0KOKuS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 05:50:18 -0500
In-Reply-To: <87pqudaxtm.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org

Hello,

On Wed, 10 Nov 2010 09:32:53 -0800
Kevin Hilman <khilman@deeprootsystems.com> wrote:

> The other problem that I'm aware of so far I've only seen on boards
> with UART2 console (beagle, Overo, n900.)  The printk messages that
> warn of 'new worst case [de]activate latency" seem to be racing with
> UART disable code.  This makes sense, since this printk is printed to
> the UART immediately after the UART is disabled, which is going to
> cause problems with the current approach to UART pm we have in
> mach-omap2/serial.c.   I have not yet fully debugged this and found a
> workaround. 

Even if I comment the "new worst case deactivate latency" message, my
BeagleBoard still doesn't wake-up from suspend. Here's what I do:

# echo enabled > /sys/class/tty/ttyO2/power/wakeup
# echo mem > /sys/power/state 
[  227.685028] PM: Syncing filesystems ... done.
[  227.699432] Freezing user space processes ... (elapsed 0.01 seconds) done.
[  227.725524] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
[  227.880706] PM: suspend of devices complete after 117.767 msecs
[  227.889160] PM: late suspend of devices complete after 2.136 msecs
[  227.895782] Disabling non-boot CPUs ...

Any idea ?

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
