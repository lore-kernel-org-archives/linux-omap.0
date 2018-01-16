From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v7 4/8] can: m_can: Move allocation of net device to probe
Date: Tue, 16 Jan 2018 14:33:08 +0530
Message-ID: <811c146c-7269-fb70-30bb-f60159473f02@ti.com>
References: <1515581725-29242-1-git-send-email-faiz_abbas@ti.com>
 <1515581725-29242-5-git-send-email-faiz_abbas@ti.com>
 <480602fa-db66-d5c3-056c-e61e5d0f2afa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <480602fa-db66-d5c3-056c-e61e5d0f2afa@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, b29396@freescale.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Monday 15 January 2018 07:22 PM, Marc Kleine-Budde wrote:
> On 01/10/2018 11:55 AM, Faiz Abbas wrote:
>> With the version no longer required to allocate the net device, it can
>> be moved to probe and the alloc_m_can_dev() function can be simplified.
>>
>> Therefore, move the allocation of net device to probe and change
>> alloc_m_can_dev() to setup_m_can_dev().
> 
> The error handling is broken with this patch,
> 
> Have a look at the switch (priv->version) in setup_m_can_dev(), you free
> the m_can_dev in case of error, but exit with -EINVAL in the beginning
> of the function. setup_m_can_dev() should not free if it doesn't allocate.
> 
> The error handling in m_can_plat_probe() is broken, too. If
> pm_runtime_get_sync(&pdev->dev) fails, you don't free the candev.
> 

Will fix.

Thanks,
Faiz
