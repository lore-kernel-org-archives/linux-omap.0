From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: omap4: gpio: fix setting IRQWAKEN bits
Date: Mon, 06 Jun 2011 16:18:44 -0700
Message-ID: <87boyav99n.fsf@ti.com>
References: <1307392698-21170-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1307392698-21170-1-git-send-email-ccross@android.com> (Colin
	Cross's message of "Mon, 6 Jun 2011 13:38:17 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, tarun.kanti@ti.com, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Colin,

Colin Cross <ccross@android.com> writes:

> Setting the IRQWAKEN bit was overwriting previous IRQWAKEN bits,
> causing only the last bit set to take effect, resulting in lost
> wakeups when the GPIO controller is in idle.
>
> Replace direct writes to IRQWAKEN with MOD_REG_BIT calls to
> perform a read-modify-write on the register.
>
> Signed-off-by: Colin Cross <ccross@android.com>

Thanks, I'll queue these both for Grant for the 3.0-rc fixes along with
another GPIO fix for a section mismatch I have queued.

Minor: now that this driver has moved to drivers, I changed the subject
prefixes slightly.  They now read:

GPIO: OMAP: fix setting IRQWAKEN bits for OMAP4
GPIO: OMAP: add locking around calls to _set_gpio_triggering

Kevin
