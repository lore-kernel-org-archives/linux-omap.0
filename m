From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH RESEND] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
Date: Tue, 27 Mar 2012 16:18:49 +0200
Message-ID: <4F71CC49.4080903@compulab.co.il>
References: <1332139367-1302-1-git-send-email-keshava_mgowda@ti.com> <20120320155353.GE17818@sortiz-mobl> <20120320155541.GF32693@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:36570
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754234Ab2C0OTB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 10:19:01 -0400
In-Reply-To: <20120320155541.GF32693@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Samuel Ortiz <sameo@linux.intel.com>, Keshava Munegowda <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, parthab@india.ti.com, govindraj.raja@ti.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Felipe, Samuel,

On 03/20/12 17:55, Felipe Balbi wrote:
> On Tue, Mar 20, 2012 at 04:53:53PM +0100, Samuel Ortiz wrote:
>> Hi Keshava,
>>
>> On Mon, Mar 19, 2012 at 12:12:47PM +0530, Keshava Munegowda wrote:
>>> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>>>
>>> It is observed that the echi ports of 3430 sdp board
>>> are not working due to the random timing of programming
>>> the associated GPIOs of the ULPI PHYs of the EHCI for reset.
>>> If the PHYs are reset at during usbhs core driver, host ports will
>>> not work because EHCI driver is loaded after the resetting PHYs.
>>> The PHYs should be in reset state while initializing the EHCI
>>> controller.
>>> The code which does the GPIO pins associated with the PHYs
>>> are programmed to reset is moved from the USB host core driver
>>> to EHCI driver.
>>>
>>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>>> Reviewed-by: Partha Basak <parthab@india.ti.com>
>> Felipe, are you ok with that patch ?
>> I'll most likely queue it after this merge window is closed though.

I've just sent a patch that depends on this one (ehci-omap.c part),
though it needs a review, but Samuel, you still haven't applied/pushed
the patch to your git.kernel.org, so can this one go through Felipe's
tree to minimize the dependencies/conflicts?

What do you think, Felipe?

> 
> my bad, here's my Ack:
> 
> Acked-by: Felipe Balbi <balbi@ti.com>
> 

- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJPccxIAAoJEBDE8YO64Efay3EP/ji+LEF3rDCDkqpZ9ELYcsWW
My+4EozWSXRHEpxFk/xb9V/3+inX9cczaRR3DRFQLn8UxxTtn0VJSVmTtFB4Uadc
vsrlBU9gi6DXYX1Jpu3vRUvLnQcfBzlXCnLTVW3fgsYyztNHcHQj7F87t/Kug5V1
UFV21DNzePYlta3+UZly8q0anqvEqlbTY0j81pWhpL5i0T/8iGAhWdTOppbgT+oH
FZ7W+YUk1TJtKHwFWABXfAIBwg/NHaIYPKDiv8z3wIFnT2Lk5IdZagIZfwYExtUE
spX2DEMtti8yKwfEJW2rQHLF8/YCWxKc9oiYegVWniNx7WBYje2wEKP1lT4eYJbe
iCPzhPu63wipvaw2yaVYFdJ6fCHZ4s8ZkE2fWhuGgSsnD/4ljAtl0i+eeVhu6fdi
kQF6E3uNOVOSh3iI1GuMUjolOVDAQiRZdQGDATstLu38sC2NVPfmxW6z6doSQcn5
TeiCkIiZaC/b+6gvglBbbWuxcNUJQCJ+2DFVweBEDmmO2WKgpgo6GGhE0H4uMxjs
1wSP6EABz6O2ihjq1YlBvXMvhP2YWO68u/iBVty1cIt5u9mOFnavpNMPLj9c02ew
AE8TM9LLS5zOYQtEYU3q0WiGQEhaSa5f87pEdQYDH0i98FH9prRRxl3Zh0IOhHa8
Skz7J4AVgxdEci8Op1Uc
=oe1q
-----END PGP SIGNATURE-----
