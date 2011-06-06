From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: omap4: gpio: fix setting IRQWAKEN bits
Date: Mon, 06 Jun 2011 12:32:05 +0530
Message-ID: <4DEC7B6D.6060901@ti.com>
References: <1307214239-16316-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1307214239-16316-1-git-send-email-ccross@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 6/5/2011 12:33 AM, Colin Cross wrote:
> Setting the IRQWAKEN bit was overwriting previous IRQWAKEN bits,
> causing only the last bit set to take effect, resulting in lost
> wakeups when the GPIO controller is in idle.
>
> Replace direct writes to IRQWAKEN with writes to SETWKUENA and
> CLEARWKUEN.
>
> Signed-off-by: Colin Cross<ccross@android.com>

Looks good. This needs to be fixed on top of the clean-up
branch where GPIO movemnt to driver/gpio/* happening.

For this change,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>	
