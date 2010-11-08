From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: OMAP not resuming after waking from suspend to RAM after addition
 of the new OMAP serial drivers
Date: Mon, 8 Nov 2010 14:19:38 +0530
Message-ID: <AANLkTimiBHLRUSvpJ0bE+0NswmLbQGdoG9s8Q6hat3yV@mail.gmail.com>
References: <AANLkTikVaBOtwSXHPPYyBHjFOS2yHODRAY7KV5Q3TjTL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <AANLkTikVaBOtwSXHPPYyBHjFOS2yHODRAY7KV5Q3TjTL@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Laine Walker-Avina <lwalkera@ieee.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 5, 2010 at 3:36 AM, Laine Walker-Avina <lwalkera@ieee.org> =
wrote:
> Hi,
>
> I'm having trouble resuming from RAM suspend with the recent addition
> of the new omap-serial driver. It appears to be in some sort of loop
> in serial_omap_console_putchar() sometime after console_release_sem()
> is called in the resume path. Has this driver been tested going into
> and out of suspend?
>

Yes, System wide suspend was tested.
I dont find any issues resuming from suspend.

Ref logs:
------------
3630SDP:       http://pastebin.com/AXz1xhaU
ZOOM3:          http://pastebin.com/R8RNdNEc

My setup involves:
OMAP3630 boards (3630SDP, ZOOM3)
Kernel: Kevin's Latest PM branch (commit
e0bcaca00bb6cc2d79c8c3b765f969e00a3d313b)

--
Regards,
Govindraj.R


> Thanks,
> --
> Laine Walker-Avina
> Firmware Engineer
> PASCO scientific
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
