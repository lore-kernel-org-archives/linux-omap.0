From: Felipe Balbi <balbi@ti.com>
Subject: Re: Example OMAP board configuration file for LCD brightness
 control
Date: Fri, 10 Sep 2010 20:56:20 +0300
Message-ID: <20100910175620.GA6579@legolas.emea.dhcp.ti.com>
References: <031B7A35-7940-44FC-9D1D-FEEEB73B05F3@mac.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59847 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab0IJR4Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Sep 2010 13:56:24 -0400
Content-Disposition: inline
In-Reply-To: <031B7A35-7940-44FC-9D1D-FEEEB73B05F3@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

you should break your lines at 80-chars

On Fri, Sep 10, 2010 at 12:43:48PM -0500, Elvis Dowson wrote:
>Could someone point me to an example board-configuration file that I
>can use, to similarly configure the board-overo.c file, to configure
>GPIO144 to PWM mode, to enable brightness control for the LCD display?

probably arch/arm/mach-omap2/board-3430sdp.c could help.

-- 
balbi
