From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2 1/2] ads7846: OMAP3: Removal of warnings backtrace in
 bootup
Date: Thu, 3 Feb 2011 13:09:34 +0200
Message-ID: <20110203110934.GR23561@legolas.emea.dhcp.ti.com>
References: <1296726514-32146-1-git-send-email-sourav.poddar@ti.com>
 <4D4A7F13.8080502@compulab.co.il>
 <4D4A80D3.2060407@compulab.co.il>
 <AANLkTi=U1qo=udB=tMyuA2HcnCS4EmreaVDbw2vQ9dY8@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=U1qo=udB=tMyuA2HcnCS4EmreaVDbw2vQ9dY8@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: "Poddar, Sourav" <sourav.poddar@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, dmitry.torokhov@gmail.com, balbi@ti.com, Kishon Vijay Abraham I <kishon@ti.com>, charu@ti.com, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Feb 03, 2011 at 04:30:29PM +0530, Poddar, Sourav wrote:
>  I used -1 because conditional check done in probe ads7846_probe function
>  used this value.
> 
>   err_free_gpio:
>         if (ts->gpio_pendown != -1)
>                 gpio_free(ts->gpio_pendown);

you can actually change that (maybe on a later patch) to gpio_is_valid()

-- 
balbi
