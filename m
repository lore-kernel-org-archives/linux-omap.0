From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH RFC] i2c: omap: Remove the OMAP_I2C_IP_VERSION_*
Date: Mon, 26 Nov 2012 17:33:39 +0530
Message-ID: <CAM=Q2cvU9zH49qrRPJVxwn80DiuBC2NeBOCpoV3JYMJ3e9Eu0w@mail.gmail.com>
References: <1353929982-13984-1-git-send-email-shubhrajyoti@ti.com>
	<20121126115208.GA17605@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:54573 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975Ab2KZMDk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Nov 2012 07:03:40 -0500
In-Reply-To: <20121126115208.GA17605@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, w.sang@pengutronix.de

On Mon, Nov 26, 2012 at 5:22 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Nov 26, 2012 at 05:09:42PM +0530, Shubhrajyoti D wrote:
>> The OMAP_I2C_IP_VERSION_1 and OMAP_I2C_IP_VERSION_2 was needed
>> as on VER2 we were not reading all the 32-bits. Since now that
>> we read the hi register we do not need the OMAP_I2C_IP_VERSION_*.
>> Delete the same.
>>
>> The custom reset is also changed to detect VER2 based on the
>> scheme.
>
> looks like this should become a series IMO.
>
> First patch would move the macros to common header, second patch would
> switch the Reset part to use those macros and third patch gets rid of
> OMAP_I2C_IP_VERSION_*
>
> other than that, looks very good to me.

OK will respin it accordingly.

>
> --
> balbi
