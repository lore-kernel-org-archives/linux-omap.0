From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: Re: [PATCH 11/13] arm: dts: dra7: add DMA properties for UART
Date: Tue, 4 Nov 2014 13:33:15 -0500
Message-ID: <20141104183315.GD24112@csclub.uwaterloo.ca>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
 <1412014009-13315-12-git-send-email-bigeasy@linutronix.de>
 <20141104170233.GB24112@csclub.uwaterloo.ca>
 <5459079D.7080703@linutronix.de>
 <20141104172117.GC24112@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141104172117.GC24112@csclub.uwaterloo.ca>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 04, 2014 at 12:21:17PM -0500, Lennart Sorensen wrote:
> Well the file I have is called AM572x_ES1.1_NDA_TRM_vT.pdf, so I am not
> sure who I am allowed to share that file with.  Might be simpler to just
> ask TI for the latest version.
> 
> How I hate NDAs.

Well it doesn't work, because I don't have the dma croassbar patches
from ti-linux-3.14.y which are required to use the full range of dma
channels on the dra7.

I will see how well it works without dma at least.

-- 
Len Sorensen
