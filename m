From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/5 v13] arm: omap: usb: ehci and ohci hwmod structures
 for omap4
Date: Mon, 10 Oct 2011 16:13:41 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110101604320.5205@utopia.booyaka.com>
References: <1317901099-2519-1-git-send-email-keshava_mgowda@ti.com> <alpine.DEB.2.00.1110070305040.4611@utopia.booyaka.com> <CAP05o4J39MotDTOv-O2ahvWfxL-7jC-L3FGsNXbmDy8HNg=W3g@mail.gmail.com> <alpine.DEB.2.00.1110070330220.4611@utopia.booyaka.com>
 <CAP05o4KLAnNHcvNbNWqJFN710JMNAy2emYzCt2xHF+m-Kvwveg@mail.gmail.com> <CAP05o4+ybhZwRaXZPgS-ZdTL_0gjz1VLf6LuUtMgm_txNPwrnw@mail.gmail.com> <20111010090330.GE6685@legolas.emea.dhcp.ti.com> <alpine.DEB.2.00.1110101509580.5205@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1110101509580.5205@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Munegowda, Keshava" <keshava_mgowda@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org

Hi

On Mon, 10 Oct 2011, Paul Walmsley wrote:

> So then you'd just create a TLL driver with something like these two 
> symbols exported:
> 
> omap_usbhost_tll_enable_port();
> omap_usbhost_tll_disable_port(); 

N.B., since I don't think Linux has any formal support to map USB ports to 
TLL ports, you'll probably need to create a couple of functions in your 
drivers/mfd/omap-usb-host.c that your EHCI/OHCI drivers could call during 
init/exit to get and put the TLL struct device, to pass to those above 
functions.  Since the MFD driver is what creates the TLL struct devices, 
the MFD driver will have the TLL struct device pointers.  Something like 
omap_usbhost_get_tll_device() and omap_usbhost_put_tll_device().

One other thing.  Not sure what the correct generic name prefix for these 
functions should be, since I don't know the provenance of the USBHOST IP 
block; but maybe the function prefix should be something like 'ti_usbhost' 
instead, to indicate that it isn't OMAP-specific?  You would know better 
than I.


- Paul
