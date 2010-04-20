From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC] [PATCH 1/3] OMAP4: Keyboard Controller Support
Date: Tue, 20 Apr 2010 16:16:00 -0700
Message-ID: <87vdblbtqn.fsf@deeprootsystems.com>
References: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F5@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F5@dlee03.ent.ti.com> (Abraham Arce's message of "Tue\, 13 Apr 2010 20\:10\:48 -0500")
Sender: linux-input-owner@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

"Arce, Abraham" <x0066660@ti.com> writes:

> Keyboard controller for OMAP4 with built-in scanning algorithm.
> The following implementations are used:
>
>   - matrix_keypac.c logic
>   - hwmod framework
>   - threaded irq
>
> Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
> Signed-off-by: Abraham Arce <x0066660@ti.com>

Some general comments...

What's missing here is a separation of the driver and the device.
What you need is for arch code to register a platfrom_device (using
hwmod + omap_device).  Then this driver will use the standard
platform_device resource calls to get its base address, IRQs, etc. and
any platform_data.

IOW, as Felipe mentioned, the driver should not be doing the hwmod +
omap_device init and registration.

Kevin
