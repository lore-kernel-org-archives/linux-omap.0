From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: 0.5sec delay when ttyO0 is enabled
Date: Tue, 18 Sep 2012 12:34:25 +0100
Message-ID: <50585C41.1050704@mimc.co.uk>
References: <50584F90.2000606@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50584F90.2000606@mimc.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 18/09/12 11:40, Mark Jackson wrote:
> I'm using a BeagleBone, and the linux kernel from Koen Kooi (https://github.com/koenkooi/linux.git).
> 
> I have noticed there is a 0.5sec delay between OMAP UART0 being initialised and the console being
> enabled.

It is, of course, when the printk() messages are processed and dumped to the console.

If I boot with the "quiet" flag, the delay is magically gone.

Apologies for the noise.
