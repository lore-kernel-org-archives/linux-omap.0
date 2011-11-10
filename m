From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v7 11/21] OMAP2+: UART: Move errata handling from serial.c
 to omap-serial
Date: Thu, 10 Nov 2011 17:44:27 -0600
Message-ID: <4EBC61DB.9020402@ti.com>
References: <1318951576-10165-1-git-send-email-govindraj.raja@ti.com> <1318951576-10165-12-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1318951576-10165-12-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Govindraj,

On 10/18/2011 10:26, Govindraj.R wrote:
> Move the errata handling mechanism from serial.c to omap-serial file
> and utilise the same func in driver file.
>
> Errata i202, i291 are moved to be handled with omap-serial
> Moving the errata macro from serial.c file to driver header file
> as from on errata will be handled in driver file itself.
> Corrected errata id from chapter reference 2.15 to errata id i291.
>
> Removed errata and dma_enabled feilds from omap_uart_state struct
> as they are no more needed with errata handling done within omap-serial.
>
> Acked-by: Alan Cox<alan@linux.intel.com>
> Signed-off-by: Govindraj.R<govindraj.raja@ti.com>
> ---
>   arch/arm/mach-omap2/serial.c                  |   97 +++++++------------------
>   arch/arm/plat-omap/include/plat/omap-serial.h |    6 ++
>   drivers/tty/serial/omap-serial.c              |   66 ++++++++++++++++-
>   3 files changed, 95 insertions(+), 74 deletions(-)

[snip]

> +	/* Enable the MDR1 errata for OMAP3 */
> +	if (cpu_is_omap34xx()&&  !cpu_is_ti816x())
> +		omap_up.errata |= UART_ERRATA_i202_MDR1_ACCESS;

This errata (i202) is applicable to all devices from OMAP2430 to 
OMAP4460 (apparently this one is not getting fixed). So could you make 
sure this is enabled for 2430, 3430, 3630, 4430 and 4460?

[snip]

> +/*
> + * Work Around for Errata i202 (3430 - 1.12, 3630 - 1.6)

We should update the comment to be "Work Around for Errata i202 (2430, 
3430, 3630, 4430 and 4460)". The "1.12" and "1.6" are just the section 
references in the errata docs, but I think that you can drop these as 
you can just search for the errata ID which is i202.

Cheers
Jon



