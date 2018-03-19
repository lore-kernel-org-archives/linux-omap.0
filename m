From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux
Date: Mon, 19 Mar 2018 16:21:34 +0100
Message-ID: <20180319152134.GA26121@kroah.com>
References: <1521463108-9014-1-git-send-email-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1521463108-9014-1-git-send-email-aford173@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: stable@vger.kernel.org, ben.hutchings@codethink.co.uk, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 19, 2018 at 07:38:28AM -0500, Adam Ford wrote:
> commit 74402055a2d3ec998a1ded599e86185a27d9bbf4 upstream.
> 
> The pinmuxing was missing for I2C1 which was causing intermittent issues
> with the PMIC which is connected to I2C1.  The bootloader did not quite
> configure the I2C1 either, so when running at 2.6MHz, it was generating
> errors at time.
> 
> This correctly sets the I2C1 pinmuxing so it can operate at 2.6MHz
> 
> Fixes: 687c27676151 ("ARM: dts: Add minimal support for LogicPD Torpedo
> DM3730 devkit")
> 
> For linux-4.4.y

Thanks, now applied.

greg k-h
