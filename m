From: "Arend van Spriel" <arend@broadcom.com>
Subject: Re: Regression 3.11-rc1: omap4panda: no usb and consequently no
 ethernet
Date: Fri, 26 Jul 2013 09:25:49 +0200
Message-ID: <51F2247D.2000805@broadcom.com>
References: <51E7AA24.6080600@broadcom.com> <51E7CEF3.5000408@ti.com>
 <51E7D080.6070401@broadcom.com> <51E7D1D2.1060006@ti.com>
 <51E7E1B7.6090104@broadcom.com> <51E7E2AD.8020106@ti.com>
 <51F122D5.80205@broadcom.com> <51F1E39D.2030902@ti.com>
 <51F1E65B.4020005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51F1E65B.4020005@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 07/26/2013 05:00 AM, Joel Fernandes wrote:
> On 07/25/2013 09:49 PM, Joel Fernandes wrote:
>
> [..]
>
>>> Can I get back on this topic. When USB and ethernet was working for me
>>> as stated above, I was not doing tftpboot. When I use tftpboot the
>>> images are obtained from the tftp server, but after kernel has started
>>> there is nothing in /sys/bus/usb/devices/.
>>
>> I quickly tried 3.11-rc2 + Roger's USB PHY clock patch on omap4-panda-es
>> and enabled following USB options:
>>
>> CONFIG_USB_MUSB_HDRC=y
>> CONFIG_USB_PHY=y
>> CONFIG_OMAP_USB2=y
>> CONFIG_OMAP_CONTROL_USB=y
>> CONFIG_USB_MUSB_OMAP2PLUS=y
>> CONFIG_MFD_OMAP_USB_HOST=y
>> CONFIG_USB_EHCI_HCD=y
>> CONFIG_USB_OHCI_HCD=y
>> CONFIG_USB_EHCI_HCD_OMAP=y
>
> Sorry I missed saying I also set had to set CONFIG_NOP_USB_XCEIV=y
>

I will compare this with my .config. At first glance it looks like I am 
missing some of these.

Gr. AvS
