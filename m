From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: BeagleBoard not resuming from uart with latest pm-core ?
Date: Mon, 15 Nov 2010 14:13:06 +0100
Message-ID: <20101115141306.1ff68beb@surf>
References: <20101110164414.4529cbda@surf>
	<AANLkTi=Dzv2XE-X_z6yiCaRjgWrST5QGDE9dFDnDy9pT@mail.gmail.com>
	<87pqudaxtm.fsf@deeprootsystems.com>
	<20101115115005.30b35e75@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:42154 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814Ab0KONNQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 08:13:16 -0500
In-Reply-To: <20101115115005.30b35e75@surf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org

On Mon, 15 Nov 2010 11:50:05 +0100
Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> # echo enabled > /sys/class/tty/ttyO2/power/wakeup
> # echo mem > /sys/power/state 
> [  227.685028] PM: Syncing filesystems ... done.
> [  227.699432] Freezing user space processes ... (elapsed 0.01 seconds) done.
> [  227.725524] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
> [  227.880706] PM: suspend of devices complete after 117.767 msecs
> [  227.889160] PM: late suspend of devices complete after 2.136 msecs
> [  227.895782] Disabling non-boot CPUs ...
> 
> Any idea ?

Removing "no_console_suspend" from my bootargs made it work. However,
it was previously working with no_console_suspend, and that was very
useful since I need to debug things happening fairly early in the
resume procedure. Any clue on how to make "no_console_suspend" work
again ?

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
