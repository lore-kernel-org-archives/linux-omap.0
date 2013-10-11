From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 6/8] ARM: dts: OMAP4: Add hwspinlock node
Date: Fri, 11 Oct 2013 16:41:25 -0700
Message-ID: <20131011234125.GG29913@atomide.com>
References: <1381439735-52888-1-git-send-email-s-anna@ti.com>
 <1381439735-52888-7-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381439735-52888-7-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>, Benoit Cousson <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [131010 14:24]:
> Add the hwspinlock device tree node for OMAP4 family
> of SoCs.

Suman, can you please post the .dts changes separately from
the driver changes next time so driver maintainers don't
accidentally pick them up. That leads to unnecessary merge
conflicts with the .dts files.

Thanks,

Tony
