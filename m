From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv5] OMAP: Serial: Define OMAP uart MDR1 reg and remove
 magic numbers
Date: Fri, 12 Nov 2010 09:35:32 -0800
Message-ID: <20101112173531.GD9264@atomide.com>
References: <1289568557-9727-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1289568557-9727-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@lists.arm.linux.org.uk, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [101112 05:22]:
> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> Define MDR1 register serial definitions used in serial and
> bluetooth drivers.
> Change magic number to ones defined in serial_reg for omap1/2
> serial driver.
> Remove redefined MDR1 register definitions in omap-serial driver.

Thanks, queueing this for 2.6.38 and adding the ack from Greg from
the previous version.

Tony
