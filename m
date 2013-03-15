From: kishon <kishon@ti.com>
Subject: Re: [PATCH 1/4] usb: Fix linker errors during build
Date: Fri, 15 Mar 2013 21:22:02 +0530
Message-ID: <514343A2.5010702@ti.com>
References: <1363354132-27523-1-git-send-email-kishon@ti.com> <20130315142556.GA23930@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130315142556.GA23930@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, notasas@gmail.com
List-Id: linux-omap@vger.kernel.org

On Friday 15 March 2013 07:55 PM, Felipe Balbi wrote:
> On Fri, Mar 15, 2013 at 06:58:49PM +0530, Kishon Vijay Abraham I wrote:
>> commit 63378a (usb: phy: remove CONFIG_USB_OTG_UTILS) removed
>> CONFIG_USB_OTG_UTILS from Kconfig but failed to removed from Makefile.
>> Fixed it here.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>
> I can fold it in original commit since that's not in mainline yet,
> thanks

Sure.

Thanks
Kishon
