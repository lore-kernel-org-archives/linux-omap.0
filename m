From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 11/13] arm: dts: dra7: add DMA properties for UART
Date: Wed, 05 Nov 2014 17:30:51 +0100
Message-ID: <545A50BB.2020307@linutronix.de>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de> <1412014009-13315-12-git-send-email-bigeasy@linutronix.de> <20141104170233.GB24112@csclub.uwaterloo.ca> <5459079D.7080703@linutronix.de> <20141104172117.GC24112@csclub.uwaterloo.ca> <20141104183315.GD24112@csclub.uwaterloo.ca> <20141104210315.GF24112@csclub.uwaterloo.ca> <20141105011506.GG24112@csclub.uwaterloo.ca> <5459DBB7.1090702@linutronix.de> <20141105153307.GN24110@csclub.uwaterloo.ca> <20141105162024.GH24112@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141105162024.GH24112@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/05/2014 05:20 PM, Lennart Sorensen wrote:
> On Wed, Nov 05, 2014 at 10:33:15AM -0500, Lennart Sorensen wrote:
>> Two systems ran 16 hours each so far with no issues.  Pushed 170MB o=
f
>> data through the pair of serial ports on one system at 230400.
>=20
> The console on uart3 doesn't appear to be using the dma assuming the
> values in /sys for the dma controller and bytes transferred mean anyt=
hing.
> It does mention in dmesg that it allocated dma channels for uart3 tho=
ugh.

Then it should use it :)

> How do you tell if it is using dma?

There is omap_8250_tx_dma() and omap_8250_rx_dma(). Both setup
callbacks (the rx+tx _complete). Upon successful DMA transfer you
should see them invoked with bytes transfered (>0).
=46or RX transfer you need at least trigger bytes in the FIFO within a
given time frame (I think it was 46 bytes and the delay may be up to 2
bytes). If you miss this then DMA for RX won't wire and you purge the
=46IFO manually via "timeout-interrupt" (the callback will be invoked
with an error condition and 0 bytes).

Assuming this works for you then one should figure out why the counters
in /sys are not updated=85

Sebastian
