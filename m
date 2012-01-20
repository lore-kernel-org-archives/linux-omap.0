From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 4/5] ARM : OMAP : serial : Make context_loss_cnt signed
Date: Fri, 20 Jan 2012 14:22:23 +0530
Message-ID: <CAAL8m4zEs4H6o3svnkRVG8ejChD-kshF40XKrGfA_ERH--5Oyw@mail.gmail.com>
References: <1326709360-26020-1-git-send-email-shubhrajyoti@ti.com> <1326709360-26020-5-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1326709360-26020-5-git-send-email-shubhrajyoti@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 16, 2012 at 3:52 PM, Shubhrajyoti D <shubhrajyoti@ti.com> w=
rote:
> get_context_loss_count returns an int however it is stored in
> unsigned integer context_loss_cnt . This patch tries to make
> context_loss_cnt int. So that in case of errors(which may be negative=
)
> the value is not interpreted wrongly.
>

This change should be part [1] patch of itself

[1]:

[PATCH 5/5] OMAP : serial : Check for error in get_context_loss_count

--
Thanks,
Govindraj.R


> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm=
/plat-omap/include/plat/omap-serial.h
> index 9ff4444..b7fb6dc 100644
> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> @@ -128,7 +128,7 @@ struct uart_omap_port {
> =A0 =A0 =A0 =A0unsigned char =A0 =A0 =A0 =A0 =A0 msr_saved_flags;
> =A0 =A0 =A0 =A0char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0name[20];
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 port_activity;
> - =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_los=
s_cnt;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_los=
s_cnt;
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 errata;
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wakeups_=
enabled;
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
