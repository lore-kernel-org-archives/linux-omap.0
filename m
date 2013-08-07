From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH] bq24190_charger: Add support for TI BQ24190 Battery
 Charger
Date: Wed, 7 Aug 2013 14:28:17 -0700
Message-ID: <20130807212817.GA8608@animalcreek.com>
References: <1373414813-14682-1-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from p3plsmtpa11-06.prod.phx3.secureserver.net ([68.178.252.107]:36368
	"EHLO p3plsmtpa11-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933125Ab3HGWTa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Aug 2013 18:19:30 -0400
Content-Disposition: inline
In-Reply-To: <1373414813-14682-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: cbou@mail.ru, dwmw2@infradead.org
Cc: linux-omap@vger.kernel.org

On Tue, Jul 09, 2013 at 05:06:53PM -0700, Mark A. Greer wrote:
> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> Add driver support for the Texas Instruments BQ24190
> battery charger.  Some of the information provided by
> the device is about the charger and other information
> is about the battery so create two power_supply objects
> (one for each) and provide the appropriate information
> for each one.
> 
> The device has many fields that go beyond what is
> reasonable to report or modify using the existing
> 'POWER_SUPPLY_PROP_*' properties so the driver exports
> the register fields via sysfs.  They are prefixed by
> 'f_' (for 'field') to make it easier to distinguish
> between a register field and a "normal" sysfs file
> exported by the power_supply infrastructure.
> 
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> ---

Ping...
