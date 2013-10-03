From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: remove deprecated IRQF_DISABLED
Date: Thu, 3 Oct 2013 11:15:19 -0700
Message-ID: <20131003181519.GR8949@atomide.com>
References: <1378538365-7353-1-git-send-email-michael.opdenacker@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1378538365-7353-1-git-send-email-michael.opdenacker@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Cc: linux@arm.linux.org.uk, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Michael Opdenacker <michael.opdenacker@free-electrons.com> [130907 00:27]:
> This patch proposes to remove the IRQF_DISABLED flag from OMAP code
> It's a NOOP since 2.6.35, and will be removed one day.

Thanks, applying into omap-for-v3.13/fixes-not-urgent.

Tony
