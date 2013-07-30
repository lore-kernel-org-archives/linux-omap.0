From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/4] usb: phy: rename nop_usb_xceiv => usb_phy_gen_xceiv
Date: Tue, 30 Jul 2013 09:34:40 +0200
Message-ID: <51F76C90.90207@linutronix.de>
References: <1374869757-923-1-git-send-email-bigeasy@linutronix.de> <1374869757-923-2-git-send-email-bigeasy@linutronix.de> <20130729122022.GF24801@radagast> <20130730070814.GF7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130730070814.GF7656@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, george.cherian@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 07/30/2013 09:08 AM, Tony Lindgren wrote:
> Looking at this patch there's a pretty high probability of introducing
> pointless merge conflicts.
> 
> How about do the platform data related changes as a separate follow-up
> series? You can typically do this by keeping the old features around,
> then doing a separate series to rename or remove the users later on.
> This will remove the dependency between platform data and the driver
> changes.

I can do this. This will work of for the driver name but not for the
name the platform_data struct. To address this part you could create a
separate branch on top of -rc3 or so which contains only this change(s)
and Felipe and you merge this branch so there won't be any conflicts.

> 
> Regards,
> 
> Tony

Sebastian
