From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 11/16] OMAP2+: UART: Move errata handling from serial.c to omap-serial
Date: Tue, 11 Oct 2011 14:01:19 -0700
Message-ID: <871uuj1bvk.fsf@ti.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
	<1317380561-661-2-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1317380561-661-2-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Fri, 30 Sep 2011 16:32:36 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Move the errata handling mechanism from serial.c to omap-serial file
> and utilise the same func in driver file.
>
> Errata i202, i291 are moved to be handled with omap-serial
> Moving the errata macro from serial.c file to driver header file
> as from on errata will be handled in driver file itself.
>
> Corrected errata id from chapter reference 2.15 to errata id i291.
>
> Acked-by: Alan Cox <alan@linux.intel.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

The errata handling for i291 is moved from device code to driver code
but it's functionality is also changed (but not described.)

In the current mainline code, The workaround for i291 is done whenever
UART clocks are about to be cut.  When the clocks are (re)enabled, the
device is put back into no-idle.

This patch puts the device into force-idle just before the idle/suspend
transistion, but never puts it back into no-idle.  So after the first
idle/suspend transition, the IP remains in force-idle forever.  I don't
think that's what we want.

Kevin
