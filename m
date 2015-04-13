From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH] ARM: omap2plus_defconfig: Switch over to using 8250
 driver
Date: Mon, 13 Apr 2015 09:43:05 +0200
Message-ID: <552B7389.5000505@linutronix.de>
References: <1428689893-14605-1-git-send-email-nm@ti.com> <55282737.8060407@hurleysoftware.com> <552967A0.9080804@ti.com> <552978B2.6000604@hurleysoftware.com> <5529BAE7.4080808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58284 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbbDMHnJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Apr 2015 03:43:09 -0400
In-Reply-To: <5529BAE7.4080808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sekhar Nori <nsekhar@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On 04/12/2015 02:23 AM, Nishanth Menon wrote:
>> I think for the moment we should just freeze omap-serial and let
>> most of userspace catch up first; a lot of the official and
>> unofficial vender support is still stuck in 3.14. By the time,
>> 3.19+ is de rigueur we'll hopefully have figured out the ttyS
>> sharing and how to migrate without breaking userspace.
>>
> 
> How about the folks stuck on older distros like Maemo N900?

By the time I was thinking about this, I ended up with this:
a) replace ttyOx with ttySx for the kernel console we it does not end
   up dark and add a warning. This works right now however the warning
   might been longer but then if one does not read it it might not
   matter at all.
b) add symlink udev rule so ttySx nodes becomes ttyOx one, too

a) was mainly for people not aware of the defconfig change who end up
with the new driver without any knowledge.
b) was mainly for people for people using some kind of "pre-created"
image where you are not sure which kernel they have. They still could
use the old driver or they might have switched to the new one. This
udev rule should make sure there at least a getty on serial after the
complete boot.

Sebastian
