From: Ruchika Kharwar <ruchika@ti.com>
Subject: Re: [PATCH] jacinto6 : usb3_phy: Updated dpll M,N values.
Date: Mon, 8 Jul 2013 09:33:06 -0500
Message-ID: <51DACDA2.1060806@ti.com>
References: <1371829570-15011-1-git-send-email-ruchika@ti.com> <20130708072848.GB16635@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60091 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464Ab3GHOdJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Jul 2013 10:33:09 -0400
In-Reply-To: <20130708072848.GB16635@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Landley <rob@landley.net>, Nikhil Devshatwar <nikhil.nd@ti.com>


On 07/08/2013 02:28 AM, Felipe Balbi wrote:
> On Fri, Jun 21, 2013 at 10:46:10AM -0500, Ruchika Kharwar wrote:
>> Addition of the M and N recommended values for the USB3 PHY DPLL.
>> Sysclk for DRA7xx is 20MHz.
>> This yields:
>> Clk = 20MHz * M/(N+1) = 20MHz * 1000 /(7+1) = 2.5 Ghz
>>
>> Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
>> Signed-off-by: Ruchika Kharwar <ruchika@ti.com>
> this won't apply since you had already sent me another version. Please
> send in a fix up patch if that's wrong.
>
I already did .. :-)
Sent 07/04/2013

Correction of the omap_usb3_dpll_params array when the sys_clk_rate is
20MHz.

Signed-off-by: Nikhil Devshatwar<nikhil.nd@ti.com>
Signed-off-by: Ruchika Kharwar<ruchika@ti.com>
---
  drivers/usb/phy/phy-omap-usb3.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-omap-usb3.c b/drivers/usb/phy/phy-omap-usb3.c
index efe6e14..a2fb30b 100644
--- a/drivers/usb/phy/phy-omap-usb3.c
+++ b/drivers/usb/phy/phy-omap-usb3.c
@@ -71,9 +71,9 @@ static struct usb_dpll_params omap_usb3_dpll_params[NUM_SYS_CLKS] = {
  	{1250, 5, 4, 20, 0},		/* 12 MHz */
  	{3125, 20, 4, 20, 0},		/* 16.8 MHz */
  	{1172, 8, 4, 20, 65537},	/* 19.2 MHz */
+	{1000, 7, 4, 10, 0},            /* 20 MHz */
  	{1250, 12, 4, 20, 0},		/* 26 MHz */
  	{3125, 47, 4, 20, 92843},	/* 38.4 MHz */
-	{1000, 7, 4, 10, 0},            /* 20 MHz */
  
  };
  


