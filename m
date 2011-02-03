From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 2/2] Input: ads7846: use gpio_request_one to configure
 pendown_gpio
Date: Thu, 3 Feb 2011 08:54:05 -0800
Message-ID: <20110203165405.GB12802@core.coreip.homeip.net>
References: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: LW@karo-electronics.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, gadiyar@ti.com, charu@ti.com, grinberg@compulab.co.il, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 03, 2011 at 08:51:46PM +0530, Sourav Poddar wrote:
> The ads7846 driver requests a gpio but does not currently
> configure it explicitly as an input. Use gpio_request_one
> to request and configure it at one shot.
> 
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> Cc: Dmitry Torokhov <dtor@mail.ru>

Will apply this one, the other one is a bit messy IMO, will have to
think about it.

Thanks.

-- 
Dmitry
