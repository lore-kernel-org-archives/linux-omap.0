From: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Subject: RE: [PATCH] usb: musb: make modules behave better
Date: Fri, 27 Jan 2012 16:21:58 +0000
Message-ID: <B6A220404B6BFC4BBD2AB91C54D39DF43176A805@DBDE01.ent.ti.com>
References: <1327574749-18552-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1327574749-18552-1-git-send-email-balbi@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello,

On Thu, Jan 26, 2012 at 16:15:49, Balbi, Felipe wrote:
> There's really no point in doing all that
> initcall trickery when we can safely let
> udev handle module probing for us.
> 
> Remove all of that trickery, by moving everybody
> to module_init() and making proper use of
> platform_device_register() rather than
> platform_device_probe().
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 

Tested on DM644x EVM.

Tested-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>

Thanks,
Sudhakar
