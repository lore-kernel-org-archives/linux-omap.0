From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/6] system control module device and support for
 temperature sensor
Date: Fri, 23 Sep 2011 00:35:50 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109230035150.10719@utopia.booyaka.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36797 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab1IWGfv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Sep 2011 02:35:51 -0400
In-Reply-To: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org

Hi

On Thu, 22 Sep 2011, Keerthy wrote:

> The patch series adds support of system control module device and adds support
> temperature sensor. The patch series adds hwmod for system control module
> and enables the clocks for temperature sensor. The OMAP4460 specific register
> set data for the on die mpu temperature sensor is also part of this series.
> 
> Benoit Cousson (1):
>   OMAP4: Hwmod: system control module hwmod
> 
> Keerthy (4):
>   OMAP4: Adding the temperature sensor register set bit fields
>   OMAP4: Clock: Associate clocks for OMAP temperature sensor
>   OMAP4460: Temperature sensor data
>   OMAP4: System control module device support
> 
> Vishwanath BS (1):
>   OMAP4460: Clock: Adding support for 4460 specific clocks

Also, before you re-post, could you please prefix the subject lines of all 
of these patches with "ARM: " per Arnd Bergmann's recent request?

thanks

- Paul
