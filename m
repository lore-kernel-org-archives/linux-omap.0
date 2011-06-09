From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v3 04/12] Serial: OMAP: Add runtime pm support for
 omap-serial driver
Date: Thu, 9 Jun 2011 10:05:47 +0530
Message-ID: <BANLkTik1fRzQEnGyzTLour-_kYxR+y2kGg@mail.gmail.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
 <1307532194-13039-5-git-send-email-govindraj.raja@ti.com> <4DEFDDE8.3090808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <4DEFDDE8.3090808@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 9, 2011 at 2:09 AM, Jon Hunter <jon-hunter@ti.com> wrote:
> Hi Govindraj,
>
> On 6/8/2011 6:23 AM, Govindraj.R wrote:
>
> [snip]
>
>> +
>> +#define OMAP_UART_AUTOSUSPEND_DELAY (30 * HZ) /* Value is msecs */
>
> [snip]
>
>> @@ -1295,18 +1381,36 @@ static int serial_omap_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->uart_dma.rx_dma_channel =3D OMAP_=
UART_DMA_CH_FREE;
>> =A0 =A0 =A0 =A0}
>>
>> + =A0 =A0 =A0 pm_runtime_use_autosuspend(&pdev->dev);
>> + =A0 =A0 =A0 pm_runtime_set_autosuspend_delay(&pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_UART_AUTOSUSPEND_=
DELAY);
>
> Something is weird here...DEFAULT_AUTOSUSPEND_DELAY is defined as (30=
*HZ)
> which would appear to be jiffies (ticks per second) and NOT msecs. Ho=
wever,
> pm_runtime_set_autosuspend is clearly expecting msecs. So this seems =
to
> conflict. By default 30*HZ for omap would be 30*128 =3D 3840ms so not=
 quite 4
> seconds.
>
> What were you intending here?

Intention is to get approx 3 secs timeout for autosuspend.

--
Thanks,
Govindraj.R

>
> Cheers
> Jon
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
