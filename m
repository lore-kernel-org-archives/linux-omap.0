From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 00/24 V2] OMAP4: PM: suspend, CPU-hotplug and CPUilde support
Date: Tue, 04 Oct 2011 10:05:58 -0700
Message-ID: <87zkhgk7pl.fsf@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:40994 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932983Ab1JDRGE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 13:06:04 -0400
Received: by mail-qw0-f47.google.com with SMTP id c1so592659qad.20
        for <linux-omap@vger.kernel.org>; Tue, 04 Oct 2011 10:06:02 -0700 (PDT)
In-Reply-To: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sat, 24 Sep 2011 11:44:20 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> The series adds OMAP4 MPUSS (MPU SubSystem) power management support for
> suspend (S2R), CPU hotplug and CPUidle.

No need to repost, but can you update the versions in your branch to
have an ARM: prefix in the subject per Arnd's recent request?

Thanks,

Kevin
