From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: BeagleBoard not resuming from uart with latest pm-core ?
Date: Tue, 16 Nov 2010 14:59:30 -0800
Message-ID: <87pqu4c1t9.fsf@deeprootsystems.com>
References: <20101110164414.4529cbda@surf>
	<AANLkTi=Dzv2XE-X_z6yiCaRjgWrST5QGDE9dFDnDy9pT@mail.gmail.com>
	<87pqudaxtm.fsf@deeprootsystems.com> <20101115115005.30b35e75@surf>
	<20101115141306.1ff68beb@surf>
	<AANLkTi=PGuYZAPO7nxko=A1PgJMMnB5Wxk86scvs1TPe@mail.gmail.com>
	<20101115151430.15c899e5@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:65127 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755758Ab0KPW7e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 17:59:34 -0500
Received: by gwj17 with SMTP id 17so789658gwj.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Nov 2010 14:59:34 -0800 (PST)
In-Reply-To: <20101115151430.15c899e5@surf> (Thomas Petazzoni's message of
	"Mon, 15 Nov 2010 15:14:30 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Govindraj <govindraj.ti@gmail.com>, Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org

Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:

> Hello Govindraj,
>
> On Mon, 15 Nov 2010 19:24:05 +0530
> Govindraj <govindraj.ti@gmail.com> wrote:
>
>> Can you check if you have below two patches in the kernel you have?
>> 
>> http://www.spinics.net/lists/linux-serial/msg02684.html
>> http://www.spinics.net/lists/linux-serial/msg02683.html
>> 
>> If not there can you check applying these two patch
>
> I have both of these patches in my kernel (I'm running the latest
> pm-core from Kevin's repository).

Hmm, using pm-core, I can hit full-chip retention in suspend on my
Beagle C4.

However, upgrading to a recent x-loader and u-boot, I can reproduce the
problem.

The problem is an old one that seems to have resurfaced.  Namely, u-boot
leaves the MUSB block in a state that prevents it from idling, and thus
prevents CORE from hitting RET.

I have a series of hacks for this in the PM branch (see my pm-otg-reset
branch) that fixes the problem, but is not clean.  This will work until
the omap_hwmod conversion for MUSB is done.   One of the perks we get
from omap_hwmod is that a reset is done for each hwmod ensuring that any
(mis)configuration of the bootloader is cleared and the HW is in a known
default state.

Kevin


