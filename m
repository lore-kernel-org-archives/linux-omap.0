From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH 2/2] OMAP i2c: pinctrl-ify i2c-omap.c
Date: Wed, 19 Sep 2012 15:43:16 +0530
Message-ID: <CAM=Q2cuk83QNWcir7LWx=0+8rP4u97ei94ZB2XN=T9sFQ7v6fQ@mail.gmail.com>
References: <50596F8F.60506@ti.com>
	<1348122889-28271-1-git-send-email-panto@antoniou-consulting.com>
	<1348122889-28271-3-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348122889-28271-3-git-send-email-panto@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 20, 2012 at 12:04 PM, Pantelis Antoniou
<panto@antoniou-consulting.com> wrote:
> Add support for pinctrl mux settings in the OMAP I2C driver.
> If no such pinctl bindings are found a warning message is printed.
>
> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
> ---
looks good
Acked-by: Shubhrajyoti D <shubhrajyoti@ti.com>
