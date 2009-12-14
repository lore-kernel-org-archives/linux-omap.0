From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC/PATCH 2/4] input: misc: twl4030: move to
 request_threaded_irq
Date: Mon, 14 Dec 2009 13:40:09 +0200
Message-ID: <20091214114009.GI12526@nokia.com>
References: <20091212183410.GF3092@sirena.org.uk>
 <1260786654-13294-3-git-send-email-felipe.balbi@nokia.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BC1421BD@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756974AbZLNLlK@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BC1421BD@dbde02.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "ext Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Koskinen Aaro (Nokia-D/Helsinki)" <aaro.koskinen@nokia.com>, David Brownell <david-b@pacbell.net>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Grazvydas Ignotas <notasas@gmail.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@openedhand.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Dec 14, 2009 at 12:31:11PM +0100, ext Shilimkar, Santosh wrote:
>In whole of the series the ISR you have converted to threads using threaded_irq are very
>small in size. They are like quick_change_handlers. So only advantage is the particular
>interrupt is masked for bit longer than with you change.
>
>I might be wrong here but it might introduce the spurious IRQ's because 
>of bit of delay in the processing.What is the motive for this change ? 
>Are we using this API as it suppose to be ?

the irq chip is connected through i2c and that mandate us to handle irqs 
in thread context. Now that we have kernel-wise api for that, we're just 
moving towards it instead of definint our own stuff and the lockdep 
shortcuts we had to put before.

I boot tested these patches on a 3430-based board and it seems to be 
working fine. Did a few tests with usb only. I can see I get the usb 
presence irq correctly.

-- 
balbi
