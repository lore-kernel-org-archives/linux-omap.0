From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Audio suspend/resume status on OMAP3 based platforms
Date: Tue, 12 Jan 2010 21:35:15 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D7807@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59734 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab0ALQFY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 11:05:24 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I want to check the status of suspend/resume functionality when audio
subsystem is being used. Specifically, has some one tried the following 
tests on their omap3 based platforms:

a) echo mem > /sys/power/state, when audio playback is running in 
background
b) same command, when audio capture is running in 
background
b) same command, when audio loopback is running in 
background

I am facing some issues with (b) & (c) so wanted to confirm whether
someone else has faced similar problem or not.

Regards,
Anuj Aggarwal

