From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap1: osk: use device properties for at24 eeprom
Date: Tue, 1 May 2018 08:16:31 -0700
Message-ID: <20180501151631.GL5671@atomide.com>
References: <20180404123822.5664-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180404123822.5664-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Bartosz Golaszewski <brgl@bgdev.pl> [180404 05:39]:
> We want to work towards phasing out the at24_platform_data structure.
> There are few users and its contents can be represented using generic
> device properties. Using device properties only will allow us to
> significantly simplify the at24 configuration code.
> 
> Remove the at24_platform_data structure and replace it with an array
> of property entries. Drop the byte_len/size property, as the model name
> already implies the EEPROM's size.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Applying into omap-for-v4.18/omap1 thanks.

Tony
