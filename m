From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 0/2] net: davinci_cpdma: reduce latency on -rt
Date: Tue, 26 Jul 2016 17:36:49 +0300
Message-ID: <f546b5f0-1da6-2c16-647a-33bb8692b753@ti.com>
References: <1469534545-14478-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1469534545-14478-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Mugunthan V N <mugunthanvnm@ti.com>
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

On 07/26/2016 03:02 PM, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>
> these patches are based on next-20160726. I didn't check yet how late=
ncy
> improves by using these patches, but even if the improvment is small,
> it's still a good idea to have them.

Sry, but how this will affect on -RT? This is not a raw locks, so
they will be converted to rt-mutexes which are sleepable.
Or I've missed smth?

>
> A second pair of eyes checking what I did would be great.
>
> Best regards
> Uwe
>
>
> Uwe Kleine-K=C3=B6nig (2):
>   net: davinci_cpdma: reduce time holding ctlr->lock in
>     cpdma_control_set
>   net: davinci_cpdma: reduce time holding chan->lock in
>     cpdma_chan_submit
>
>  drivers/net/ethernet/ti/davinci_cpdma.c | 58 ++++++++++++++++-------=
----------
>  1 file changed, 29 insertions(+), 29 deletions(-)
>


--=20
regards,
-grygorii
