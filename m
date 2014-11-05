From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: Re: [PATCH 11/13] arm: dts: dra7: add DMA properties for UART
Date: Wed, 5 Nov 2014 11:20:24 -0500
Message-ID: <20141105162024.GH24112@csclub.uwaterloo.ca>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
 <1412014009-13315-12-git-send-email-bigeasy@linutronix.de>
 <20141104170233.GB24112@csclub.uwaterloo.ca>
 <5459079D.7080703@linutronix.de>
 <20141104172117.GC24112@csclub.uwaterloo.ca>
 <20141104183315.GD24112@csclub.uwaterloo.ca>
 <20141104210315.GF24112@csclub.uwaterloo.ca>
 <20141105011506.GG24112@csclub.uwaterloo.ca>
 <5459DBB7.1090702@linutronix.de>
 <20141105153307.GN24110@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141105153307.GN24110@csclub.uwaterloo.ca>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 05, 2014 at 10:33:15AM -0500, Lennart Sorensen wrote:
> Two systems ran 16 hours each so far with no issues.  Pushed 170MB of
> data through the pair of serial ports on one system at 230400.

The console on uart3 doesn't appear to be using the dma assuming the
values in /sys for the dma controller and bytes transferred mean anything.
It does mention in dmesg that it allocated dma channels for uart3 though.

How do you tell if it is using dma?

-- 
Len Sorensen
