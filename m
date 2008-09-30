From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/16] OMAP3: Context save/Restore + OFF mode support
Date: Tue, 30 Sep 2008 17:26:56 +0300
Message-ID: <87r671btfz.fsf@deeprootsystems.com>
References: <01f101c91fd1$c6c95900$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:44576 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbYI3O1G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 10:27:06 -0400
Received: by fg-out-1718.google.com with SMTP id 19so61772fgg.17
        for <linux-omap@vger.kernel.org>; Tue, 30 Sep 2008 07:27:04 -0700 (PDT)
In-Reply-To: <01f101c91fd1$c6c95900$LocalHost@wipultra1382> (Rajendra Nayak's message of "Fri\, 26 Sep 2008 17\:46\:57 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

"Rajendra Nayak" <rnayak@ti.com> writes:

> This patch set adds context save/restore routines for minimal kernel and OFF mode
> support in idle and suspend. This patch set applies on top of pm-1 branch.
>
> This has context save/restore support implemented for the following modules
> GPMC, UART, GPIO, I2C, PRCM, INTC, SCM, SRAM. 
>
> A sysfs knob to dynamically control OFF mode is provided at 
> /sys/power/enable_off_mode. This is set to 0 (disabled) by default.
>

Hi Rajendra,

This series is in much better shape, and allows me to hit retention or
OFF in idle and suspend.  Thanks!

I will pull this series into pm-1 tomorrow.  There are few minor
things that I will cleanup upon merging.

- common:
  - in several new functions, no space between local variable
    definition and start of code
  - copyright 2007 additions.  Shouldn't these be 2008?

- 6/16: INTC
  - remove the comment MIRs being saved with PRCM since this is no longer true

- 11/16: PER/NEON
  - checkpatch warnings

- 15/16: /sys/power/enable_off_mode
  - your method doesn't quite work, I have an alternative

- 14/16: CORE off
  - checkpatch errors and warnings

Thanks,

Kevin
