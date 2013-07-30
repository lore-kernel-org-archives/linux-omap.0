From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 2/4] phy: phy-amxxxx-usb: Add PHY driver for amxxxx
 platform
Date: Tue, 30 Jul 2013 16:39:28 +0200
Message-ID: <51F7D020.3000508@linutronix.de>
References: <1374237277-17769-1-git-send-email-george.cherian@ti.com> <1374237277-17769-3-git-send-email-george.cherian@ti.com> <20130729151754.GB827@linutronix.de> <51F74CEC.8040407@ti.com> <51F77F15.7090306@linutronix.de> <51F7CCB7.4040305@ti.com> <20130730143339.GM28162@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130730143339.GM28162@radagast>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: George Cherian <george.cherian@ti.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 07/30/2013 04:33 PM, Felipe Balbi wrote:
> let's try not to add any new TI-specific DT bindings, can you
> figure that out by reading some revision register ? Or perhaps by
> using different compatible strings ?

I would suggest to use a different binding. But I'm currently trying to
come up with something for am335x with a device reference?

Sebastian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCAAGBQJR99AZAAoJEHuW6BYqjPXRf5AP/jcMFUstlqqujRppC2gMsqh6
+xlpwh5hCHJPxQizwkG8kWW9XGMIMPmqODqoYwA9dFI3a5VgVVTRUkhnHEXlAt9A
8X0Sl+mdKx0XwvjxjRDPUEYqvpDFAPYxgnwvxEfjtnDgQs5ikxFj4zaMonAj5oK0
s7XnOImJmdoHbFfvR5Cx10zmfa0BjQETqk5bt/j8+8jnv86cZk8fEGE8XYoUnhFw
BsEZgfSZH/pV6s339gTs+x4+zW0luJIhJdtQmh5Ylo+xt/3TYAmDuZ0v88A6gFV+
MZjJLh2L9Sr6g0Pl/Rk5aMZhe5GSSrZYuu4Vltpz2xF1SjRRqg6ykmw6sqnme2uj
BWwq5qNG5EFPtyhZCupTZ/z388kKOhC54kbFwJW7Duv9TkDUOctVuUbehEN4Pu/u
HljW3FoYvvB/7EOXJhBcG6qy+ClS7mKkJJHeavnzbtzeg2jO1ZSKV1S/bJfpY4F6
ualEKdC+A+UXYNHSnSkbdJPAfIQw9BOhdD3nszdzrB+0xUU1ul2V3Zdf0xKsUVPj
8qkK9IuHum/pUfUEK/3C/igOhtag24LOhiGu1MG8Axe4FdmiTixhnV4DZzGyAMcm
8Br/gtKVCuoU89y0mYhsAA5o+3e6YKE7lPQVULtrZO7/+wbOTrEaukvwCMB/NngL
+qNzg8WzrRHCAQnSKni9
=712g
-----END PGP SIGNATURE-----
