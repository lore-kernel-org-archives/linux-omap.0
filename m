From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v8 00/20] OMAP2+: UART: Runtime adaptation + cleanup
Date: Tue, 13 Dec 2011 19:45:54 +0530
Message-ID: <4EE75E1A.7080101@ti.com>
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com> <874nxd5j0f.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <874nxd5j0f.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Alan Cox <alan@linux.intel.com>, Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Kevin,

On Wednesday 07 December 2011 05:51 AM, Kevin Hilman wrote:
> "Govindraj.R"<govindraj.raja@ti.com>  writes:
>
>> Converting uart driver to adapt to pm runtime API's.
>> Code re-org + cleanup.
>> Moving some functionality from serial.c to omap-serial.c
>
> Alan, can you confirm your Ack's are still valid on the drivers/tty
> parts of this series?  It has gone through quite a few changes since
> your original ack.
>
> Greg, are you ok with this series merging via the OMAP tree since it is
> changing arch/arm/mach-omap2/* code as well as the driver, and should go
> together.  If so, with your ack (on the drivers/tty/* parts), I'll
> handle this series through the OMAP tree.

I had a series to add DT support for omap-serial, which I did on top
of the runtime series from Govindraj. Its already acked by Rob Herring
for the DT parts. Would you be able to pick those up as well if its
fine with Greg?

regards,
Rajendra

>
> Thanks,
>
> Kevin
>
>
>
>
>

