From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: BeagleBoard not resuming from uart with latest pm-core ?
Date: Mon, 15 Nov 2010 15:14:30 +0100
Message-ID: <20101115151430.15c899e5@surf>
References: <20101110164414.4529cbda@surf>
	<AANLkTi=Dzv2XE-X_z6yiCaRjgWrST5QGDE9dFDnDy9pT@mail.gmail.com>
	<87pqudaxtm.fsf@deeprootsystems.com>
	<20101115115005.30b35e75@surf>
	<20101115141306.1ff68beb@surf>
	<AANLkTi=PGuYZAPO7nxko=A1PgJMMnB5Wxk86scvs1TPe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:41449 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593Ab0KOOOj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 09:14:39 -0500
In-Reply-To: <AANLkTi=PGuYZAPO7nxko=A1PgJMMnB5Wxk86scvs1TPe@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org

Hello Govindraj,

On Mon, 15 Nov 2010 19:24:05 +0530
Govindraj <govindraj.ti@gmail.com> wrote:

> Can you check if you have below two patches in the kernel you have?
> 
> http://www.spinics.net/lists/linux-serial/msg02684.html
> http://www.spinics.net/lists/linux-serial/msg02683.html
> 
> If not there can you check applying these two patch

I have both of these patches in my kernel (I'm running the latest
pm-core from Kevin's repository). See
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=history;f=drivers/serial/serial_core.c;h=c4ea14670d4486fc142df31d806c528d2752c238;hb=pm-core.

Thanks for the hint, anyway.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
