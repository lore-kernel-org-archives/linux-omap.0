From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 119/493] usb: remove use of __devexit_p
Date: Tue, 20 Nov 2012 15:02:04 +0100
Message-ID: <87r4nojrtv.fsf@dell.be.48ers.dk>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
	<1353349642-3677-119-git-send-email-wfp5p@virginia.edu>
	<50AB4D90.4080907@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <50AB4D90.4080907@atmel.com> (Nicolas Ferre's message of "Tue, 20
	Nov 2012 10:29:52 +0100")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Bill Pemberton <wfp5p@virginia.edu>, gregkh@linuxfoundation.org, Kukjin Kim <kgene.kim@samsung.com>, Wan ZongShun <mcuos.com@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Ben Dooks <ben-linux@fluff.org>, Li Yang <leoli@freescale.com>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

>>>>> "Nicolas" == Nicolas Ferre <nicolas.ferre@atmel.com> writes:

 Nicolas> On 11/19/2012 07:21 PM, Bill Pemberton :
 >> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
 >> needed.
 >> 
 >> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
 >> Cc: Peter Korsgaard <jacmet@sunsite.dk> 
 >> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com> 
 >> Cc: Felipe Balbi <balbi@ti.com> 
 >> Cc: Li Yang <leoli@freescale.com> 
 >> Cc: Alan Stern <stern@rowland.harvard.edu> 
 >> Cc: Wan ZongShun <mcuos.com@gmail.com> 
 >> Cc: Ben Dooks <ben-linux@fluff.org> 
 >> Cc: Kukjin Kim <kgene.kim@samsung.com> 
 >> Cc: linux-usb@vger.kernel.org 
 >> Cc: linux-omap@vger.kernel.org 
 >> Cc: linuxppc-dev@lists.ozlabs.org 
 >> Cc: linux-arm-kernel@lists.infradead.org 
 >> Cc: linux-samsung-soc@vger.kernel.org 

 Nicolas> [..]

 >> drivers/usb/host/ehci-atmel.c        | 2 +-

 >> drivers/usb/host/ohci-at91.c         | 2 +-

 Nicolas> For Atmel:

 Nicolas> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

For c67x00 and g_hid:

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
