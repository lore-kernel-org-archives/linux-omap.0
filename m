From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH V2] tty: serial: omap: Increase max consoles and add check
 to prevent crash
Date: Thu, 23 Oct 2014 12:16:52 +0200
Message-ID: <5448D594.4090300@linutronix.de>
References: <1413908616-843-1-git-send-email-nm@ti.com> <1413982010-11599-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413982010-11599-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Franklin Cooper Jr." <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

On 10/22/2014 02:46 PM, Nishanth Menon wrote:
> Increase the maximum number of consoles possible to 10 since DRA7 now
> has the maximum number of consoles possible. without doing this, for
> example, enabling DRA7 UART10 results in internal data structures and
> console cannot match up and we endup with a crash as follows:

good, Thanks.
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
