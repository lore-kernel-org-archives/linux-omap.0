From: Heikki Krogerus <heikki.krogerus@nokia.com>
Subject: Re: [PATCH v3 1/2] isp1704_charger: allow board specific powering
 routine
Date: Wed, 30 Mar 2011 08:08:15 +0300
Message-ID: <20110330050815.GA32672@esdhcp034230>
References: <1301405280-16899-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1301405280-16899-2-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:19497 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912Ab1C3FIe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 01:08:34 -0400
Content-Disposition: inline
In-Reply-To: <1301405280-16899-2-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: linux-usb@vger.kernel.org, cbouatmailru@gmail.com, balbi@ti.com, sshtylyov@mvista.com, tony@atomide.com, khilman@ti.com, linux-omap@vger.kernel.org, jhnikula@gmail.com

Hi,

On Tue, Mar 29, 2011 at 04:27:59PM +0300, Kalle Jokiniemi wrote:
> The ISP1704/1707 chip can be put to full power down
> state by asserting the CHIP_SEL line. This patch enables
> platform or board specific hooks to put the device into
> power down mode in case not needed.
> 
> This patch is a preparation for enabling this powering
> routine in n900 (rx-51) devices.
> 
> Thanks to Heikki Krogerus for helping out with the patch.
> 
> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
> Cc: Heikki Krogerus <heikki.krogerus@nokia.com>

Acked-By: Heikki Krogerus <heikki.krogerus@nokia.com>

> ---
>  drivers/power/isp1704_charger.c       |   22 ++++++++++++++++++++++
>  include/linux/power/isp1704_charger.h |   29 +++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 0 deletions(-)
>  create mode 100644 include/linux/power/isp1704_charger.h

-- 
heikki
