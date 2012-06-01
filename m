From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] [RFC PATCH 00/11] OMAP System Control Module
Date: Thu, 31 May 2012 17:12:31 -0700
Message-ID: <87y5o7vqj4.fsf@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:36334 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758719Ab2FAAMc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 20:12:32 -0400
Received: by pbcwz7 with SMTP id wz7so3399835pbc.16
        for <linux-omap@vger.kernel.org>; Thu, 31 May 2012 17:12:31 -0700 (PDT)
In-Reply-To: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	(Eduardo Valentin's message of "Fri, 25 May 2012 11:25:50 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: b-cousson@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, amit.kucheria@linaro.org, balbi@ti.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Eduardo,

Eduardo Valentin <eduardo.valentin@ti.com> writes:

> Hello Paul and Tony,
>
> This is a series of patches adding a basic support for system control module,
> on OMAP4+ context. It is a working in progress, but I wanted to share already
> to get your feedback.

This is a great start, thanks for working on this.  We have been needing
to do this for awhile now so I'm glad to see you working on it.

> I've modeled the driver as an MFD. You will see in this series:
> . A rework of the system control module header (patch from Santosh, picked from the list)
> . Device creation for control module core
> . Early device creation for control module core
> . The MFD core driver for system control module
> . The MFD child for usb-phy pin control
> . The MFD child for bandgap sensor
> . Very early exposure of OMAP4 thermal zone
> . All added drivers are only supporting DT probing
> . The series is based on linux-omap master, as it has the hwmod entries for SCM.
>
> The overall idea of this series is to put in place the infrastructure. It is
> not touching nor removing the existing APIs under mach-omap2/control.c for now.
> But the target is to have these APIs moved to the MFD core driver.

IMO, the best time to create the APIs is when the new MFD children are
created.

The goal should be that none of these drivers should be doing direct
read/writes to the control module.

Kevin
