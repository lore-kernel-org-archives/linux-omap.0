From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/5 v13] arm: omap: usb: ehci and ohci hwmod structures
 for omap4
Date: Mon, 10 Oct 2011 14:59:48 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110101455590.5205@utopia.booyaka.com>
References: <1317901099-2519-1-git-send-email-keshava_mgowda@ti.com> <alpine.DEB.2.00.1110070305040.4611@utopia.booyaka.com> <CAP05o4J39MotDTOv-O2ahvWfxL-7jC-L3FGsNXbmDy8HNg=W3g@mail.gmail.com> <alpine.DEB.2.00.1110070330220.4611@utopia.booyaka.com>
 <CAP05o4KLAnNHcvNbNWqJFN710JMNAy2emYzCt2xHF+m-Kvwveg@mail.gmail.com> <CAP05o4+ybhZwRaXZPgS-ZdTL_0gjz1VLf6LuUtMgm_txNPwrnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAP05o4+ybhZwRaXZPgS-ZdTL_0gjz1VLf6LuUtMgm_txNPwrnw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, khilman@ti.com, b-cousson@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org

Hi

On Mon, 10 Oct 2011, Munegowda, Keshava wrote:

> Here is the highlights of the change in the design of  USB Host which
> we can do after kernel 3.2 release;
> 
> 1. separate the TLL changes  from UHH
> 2. The TLL is be a new platform driver in ./drivers/mfd
> 3. the TLL platform driver will export apis  for enable/disable clocks
> and settings.
> 3. the UHH drivers uses these APIS of TLL based on the port
> configurations from board files
>                                      you don't need the TLL clocks to
> be on while all the ports are in phy mode.
> 
> please let me know your thoughts about it.

The TLL driver shouldn't be in drivers/mfd, since it's not an MFD device. 
The TLL driver should go somewhere under drivers/usb.

Basically, the existing OMAP USB subsystem MFD driver should create a TLL 
device.  Then the existing Linux driver probing system can associate the 
TLL driver with the TLL device.


- Paul
