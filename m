From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH] ARM: dts: am335x-boneblack: disable RTC-only sleep
Date: Mon, 1 Jun 2015 02:20:08 +0200
Message-ID: <CAALWOA8ReuBSMcu5EvLOrKGfFGBGWSdMhpL_uSnL4QvTC-n8zg@mail.gmail.com>
References: <1432136322-7609-1-git-send-email-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:32953 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758677AbbFAAUa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 May 2015 20:20:30 -0400
In-Reply-To: <1432136322-7609-1-git-send-email-robertcnelson@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>, Johan Hovold <johan@kernel.org>

Sorry for the late response, I only just noticed this since I wasn't CC'd.

This "fix" was not ever Reported-By or Tested-By me as it claims. It
is in fact wrong: &rtc { system-power-controller; } needs to be
present for every variety of beaglebone (more generally every design
with a TPS65217 whose PWR_EN is connected to the PMIC_POWER_EN pin of
an AM335x).

Without a system-power-controller, the kernel has no way of turning
off the system and shutdown will leave the system halted instead.

The previously posted fix, which added  &tps {
ti,pmic-shutdown-controller; }  was correct, and ensures that a
poweroff makes the pmic enter "OFF-state" rather than "SLEEP-state"
(aka RTC-only sleep).

Matthijs
