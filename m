From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: BeagleBoard not resuming from uart with latest pm-core ?
Date: Mon, 15 Nov 2010 11:29:28 -0800
Message-ID: <8762vypeqv.fsf@deeprootsystems.com>
References: <20101110164414.4529cbda@surf>
	<AANLkTi=Dzv2XE-X_z6yiCaRjgWrST5QGDE9dFDnDy9pT@mail.gmail.com>
	<87pqudaxtm.fsf@deeprootsystems.com> <20101115115005.30b35e75@surf>
	<20101115141306.1ff68beb@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51282 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933579Ab0KOT3c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 14:29:32 -0500
Received: by ywg8 with SMTP id 8so103697ywg.19
        for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 11:29:31 -0800 (PST)
In-Reply-To: <20101115141306.1ff68beb@surf> (Thomas Petazzoni's message of
	"Mon, 15 Nov 2010 14:13:06 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org

Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:

> On Mon, 15 Nov 2010 11:50:05 +0100
> Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
>
>> # echo enabled > /sys/class/tty/ttyO2/power/wakeup
>> # echo mem > /sys/power/state 
>> [  227.685028] PM: Syncing filesystems ... done.
>> [  227.699432] Freezing user space processes ... (elapsed 0.01 seconds) done.
>> [  227.725524] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
>> [  227.880706] PM: suspend of devices complete after 117.767 msecs
>> [  227.889160] PM: late suspend of devices complete after 2.136 msecs
>> [  227.895782] Disabling non-boot CPUs ...
>> 
>> Any idea ?
>
> Removing "no_console_suspend" from my bootargs made it work. However,
> it was previously working with no_console_suspend, and that was very
> useful since I need to debug things happening fairly early in the
> resume procedure. Any clue on how to make "no_console_suspend" work
> again ?

Until we convert the omap-serial driver to use runtime PM (currently
under development), no_console_suspend is going to be unpredictable at
best.  Until then, there will be races with the current UART PM code.

Kevin


