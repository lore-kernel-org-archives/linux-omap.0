From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: [PATCH 12/15] OMAP3 camera driver: Add Sensor and Lens Driver.
Date: Wed, 03 Sep 2008 17:35:32 +0300
Message-ID: <48BEA0B4.8030709@nokia.com>
References: <A24693684029E5489D1D202277BE89441191E332@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:62403 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbYICOfz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 10:35:55 -0400
In-Reply-To: <A24693684029E5489D1D202277BE89441191E332@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

ext Aguirre Rodriguez, Sergio Alberto wrote:
> From: Sergio Aguirre <saaguirre@ti.com>
> 
> OMAP: CAM: Add Sensor and Lens Driver
> 
> This adds the following sensor drivers:
> * Micron MT9P012 sensor
> * DW9710 Lens driver
> 
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> ---
>  drivers/media/video/Kconfig   |   16
>  drivers/media/video/Makefile  |    2
>  drivers/media/video/Kconfig   |   16
>  drivers/media/video/Makefile  |    2
>  drivers/media/video/dw9710.c  |  583 +++++++++++++
>  drivers/media/video/dw9710.h  |   61 +
>  drivers/media/video/mt9p012.c | 1782 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/media/video/mt9p012.h |  295 ++++++

I think the sensor and lens drivers should be separate patches.

-- 
Sakari Ailus
sakari.ailus@nokia.com
