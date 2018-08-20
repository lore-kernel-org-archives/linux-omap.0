From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v6 2/2] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
Date: Mon, 20 Aug 2018 17:17:31 +0200
Message-ID: <20180820151731.GD14967@localhost>
References: <1534396140-1161-1-git-send-email-j-keerthy@ti.com>
 <1534396140-1161-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1534396140-1161-2-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, johan@kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 16, 2018 at 10:39:00AM +0530, Keerthy wrote:
> Cut down the shutdown time from 2 seconds to 1 sec. In case of roll
> over try again.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---

You forgot to include a changelog, but it looks like you've addressed
the issues with v5, and this now looks good to me:

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
