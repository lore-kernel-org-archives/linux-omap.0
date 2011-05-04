From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v2 05/12] OMAP: Serial: Hold console lock for console usage.
Date: Wed, 4 May 2011 15:49:48 +0530
Message-ID: <BANLkTimKFXSCHX-xrG41QJZiDWppGS+EnQ@mail.gmail.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
 <1304080796-625-6-git-send-email-govindraj.raja@ti.com> <20110504100232.GA2092@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20110504100232.GA2092@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, May 4, 2011 at 3:32 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Govindraj.R <govindraj.raja@ti.com> [110429 05:39]:
>>
>> Also during bootup console_lock is not available.
>> =A0 =A0 =A0 =A0--> uart_add_one_port
>> =A0 =A0 =A0 =A0 =A0--> console_register
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0--> console_lock
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 --> console_unlock
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0--> call_console_drivers (her=
e yet console_lock is not released)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --> uart_console_wri=
te
>>
>> Hence convert prints from omap_device_enable/disable to pr_debug.
>
> This sounds like a hack considering we have things working with
> pr_debug currently.

The reason it works currently is because we are aquiring console
lock in omap_serial_init since with the patch series cleanup and
things are moving to driver I see this issue.

The issue is due to recursive prints because of get_sync/put_sync
printing active/deactivate latency from omap_device layer.

During printk -> uart_console_write -->
we do get_sync and if clock is cut and omap_device_enable
gets called and omap_device_enable trying to pr_warn
activate latency.
Here we end up in recursive lock up from printk.

--
Thanks,
Govindraj.R

>
> Tony
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
