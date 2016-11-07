From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: PRM: initialize en_uart4_mask and
 grpsel_uart4_mask
Date: Mon, 7 Nov 2016 16:23:06 -0700
Message-ID: <20161107232306.GF2428@atomide.com>
References: <20161024110021.10259-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161024110021.10259-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Paul Walmsley <paul@pwsan.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Colin King <colin.king@canonical.com> [161024 04:01]:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where has_uart4 is false, en_uart4_mask and grpsel_uart4_mask
> are not initialized and so any garbage value is being logically or'd into
> the write of PM_WKEN and OMAP3430_PM_MPUGRPSEL.  Fix this by initializing
> these masks to zero.

Thanks applying into omap-for-v4.9/fixes.

Regards,

Tony
