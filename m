From: santosh shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH] ARM: OMAP: wakeupgen: Add comment for unhandled FROZEN
 transitions
Date: Mon, 4 Apr 2016 09:05:46 -0700
Message-ID: <570290DA.2050100@oracle.com>
References: <1459774517-58943-1-git-send-email-anna-maria@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459774517-58943-1-git-send-email-anna-maria@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Anna-Maria Gleixner <anna-maria@linutronix.de>, linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 4/4/2016 5:55 AM, Anna-Maria Gleixner wrote:
> FROZEN hotplug notifiers are not handled and do not have to be. Insert
> a comment to remember that the lack of the FROZEN transitions is no
> accident.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
