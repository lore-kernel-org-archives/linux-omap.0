From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] hwspinlock/omap: add support for dt nodes
Date: Thu, 3 Oct 2013 11:05:46 -0700
Message-ID: <20131003180546.GP8949@atomide.com>
References: <1378230767-54931-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1378230767-54931-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Benoit Cousson <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [130903 11:00]:
> HwSpinlock IP is present only on OMAP4 and other newer SoCs,
> which are all device-tree boot only. This patch adds the
> base support for parsing the DT nodes, and removes the code
> dealing with the traditional platform device instantiation.

Great, this should be safe for Ohad to queue:

Acked-by: Tony Lindgren <tony@atomide.com>
