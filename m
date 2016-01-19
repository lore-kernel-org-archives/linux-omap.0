From: Evgeniy Polyakov <zbr@ioremap.net>
Subject: Re: [PATCH RESEND] omap_hdq: fix usecount handling
Date: Tue, 19 Jan 2016 19:38:28 +0300
Message-ID: <59381453221508@web14g.yandex.ru>
References: <1452948530-10639-1-git-send-email-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452948530-10639-1-git-send-email-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>, "hns@goldelico.com" <hns@goldelico.com>, Fabian Frederick <fabf@skynet.be>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Andreas

=46rom w1 perspective this doesn't break things :)
Greg, please pull it into your tree if no one objects.

Acked-by: Evgeniy Polyakov <zbr@ioremap.net>

16.01.2016, 15:48, "Andreas Kemnade" <andreas@kemnade.info>:
> hdq_usecount was set to zero after a successful read, so
> omap_hdq_put could not properly free resources which leads
> e.g. to increasing usecounts in lsmod output
>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> =9Adrivers/w1/masters/omap_hdq.c | 1 -
> =9A1 file changed, 1 deletion(-)
>
> diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_=
hdq.c
> index 0e2f43b..a2eec97 100644
> --- a/drivers/w1/masters/omap_hdq.c
> +++ b/drivers/w1/masters/omap_hdq.c
> @@ -618,7 +618,6 @@ static u8 omap_w1_read_byte(void *_hdq)
>
> =9A=9A=9A=9A=9A=9A=9A=9A=9Ahdq_disable_interrupt(hdq_data, OMAP_HDQ_C=
TRL_STATUS,
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9A=9A=9A=9A=9A=9A=9A=9A~OMAP_HDQ_CTRL_STATUS_INTERRUPTMASK);
> - hdq_data->hdq_usecount =3D 0;
>
> =9A=9A=9A=9A=9A=9A=9A=9A=9A/* Write followed by a read, release the m=
odule */
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aif (hdq_data->init_trans) {
> --
> 2.1.4
