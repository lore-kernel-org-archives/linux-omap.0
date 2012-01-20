From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 5/5] OMAP : serial : Check for error in get_context_loss_count
Date: Fri, 20 Jan 2012 14:21:15 +0530
Message-ID: <CAAL8m4yqPSGVx19Nfgw6BSTQ1ZoZaS7s=29yDfLLqmkXyjW6bQ@mail.gmail.com>
References: <1326709360-26020-1-git-send-email-shubhrajyoti@ti.com> <1326709360-26020-6-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1326709360-26020-6-git-send-email-shubhrajyoti@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 16, 2012 at 3:52 PM, Shubhrajyoti D <shubhrajyoti@ti.com> w=
rote:
> In serial_omap_runtime_resume in case of errors returned by
> get_context_loss_count print a warning and do a restore.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> =A0drivers/tty/serial/omap-serial.c | =A0 10 ++++++++--
> =A01 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/om=
ap-serial.c
> index 8c6f137..e1c1a0f 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1602,10 +1602,16 @@ static int serial_omap_runtime_resume(struct =
device *dev)
>
> =A0 =A0 =A0 =A0if (up) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pdata->get_context_loss_count) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 loss_cnt =3D pdata-=
>get_context_loss_count(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int loss_cnt =3D pdata-=
>get_context_loss_count(dev);


Looks ok to me,
Can you ensure off mode is tested with this patch.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
