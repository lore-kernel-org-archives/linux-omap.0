From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC] serial: omap-serial: Enable the UART wake-up bits always
Date: Fri, 4 Feb 2011 17:47:01 +0200
Message-ID: <20110204174701.4dcf290a.jhnikula@gmail.com>
References: <1295884282-16562-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295884282-16562-1-git-send-email-jhnikula@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 24 Jan 2011 17:51:22 +0200
Jarkko Nikula <jhnikula@gmail.com> wrote:

> OMAP can do also dynamic idling so wake-up enable register should be set
> also while system is running. If UART_OMAP_WER is not set, then for instance
> the RX activity cannot wake up the UART port that is sleeping.
> 
> This RX wake-up feature was working when the 8250 driver was used instead
> of omap-serial. Reason for this is that the 8250 doesn't set the
> UART_OMAP_WER and then arch/arm/mach-omap2/pm34xx.c ends up saving and
> restoring the reset default which is the same than value
> OMAP_UART_WER_MOD_WKUP here.
> 
> Fix this by moving the conditional UART_OMAP_WER write from serial_omap_pm
> into serial_omap_startup where wake-up bits are set unconditionally.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Govindraj.R <govindraj.raja@ti.com>
> ---
> This problem has been here since 2.6.37 when the omap-serial was switched
> into use so this patch is for 2.6.39.
> ---
For omap folks:

1. This patch is coming through tty tree
http://git.kernel.org/?p=linux/kernel/git/gregkh/tty-2.6.git;a=commit;h=78841462d72fe7038cb7ea48adecc6fc395f2dc5

2. This patch helps those boards that don't have UART RTS signal (e.g.
BeagleBoard) and thus padconf wakeup mechanism is not available.

-- 
Jarkko
