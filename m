From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v6 2/2] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
Date: Mon, 27 Aug 2018 22:53:38 +0200
Message-ID: <20180827205338.GC24549@piout.net>
References: <1534396140-1161-1-git-send-email-j-keerthy@ti.com>
 <1534396140-1161-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1534396140-1161-2-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, johan@kernel.org
List-Id: linux-omap@vger.kernel.org

On 16/08/2018 10:39:00+0530, Keerthy wrote:
> Cut down the shutdown time from 2 seconds to 1 sec. In case of roll
> over try again.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/rtc/rtc-omap.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
