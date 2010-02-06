From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH] DSPBRIDGE: Get rid of driver_minor global variable
Date: Fri, 5 Feb 2010 19:58:06 -0600
Message-ID: <4B6CCCAE.30203@ti.com>
References: <8a14e4992a92e3bc31d518ca71b14f214cf0f764.1265048264.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52548 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933806Ab0BFB6L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 20:58:11 -0500
In-Reply-To: <8a14e4992a92e3bc31d518ca71b14f214cf0f764.1265048264.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>

On 2/1/2010 12:18 PM, Ameya Palande wrote:
> Since there is only 1 device there is no need of driver_minor global variable.
>
> Signed-off-by: Ameya Palande<ameya.palande@nokia.com>

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Pushed to dspbridge

- omar
