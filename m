From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 1/4] MFD: Palmas: Check if interrupts property exists
 and then only request irq
Date: Tue, 18 Jun 2013 09:51:39 -0600
Message-ID: <51C0820B.4020404@wwwdotorg.org>
References: <1371549692-7361-1-git-send-email-j-keerthy@ti.com> <1371549692-7361-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371549692-7361-2-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: J Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, ldewangan@nvidia.com, sameo@linux.intel.com, grant.likely@secretlab.ca, swarren@nvidia.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, gg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

On 06/18/2013 04:01 AM, J Keerthy wrote:
> Check if interrupts property exists and then only request irq.
> On some boards INT line might not be connected to a valid
> irq line on the application processor. Hence keeping a check
> before requesting irq.

When there is no interrupts property, surely i2c->irq == 0, which is an
invalid IRQ, and hence there's no need to check this before copying the
value?

In other words, I think this whole patch could just be:

+ 	palmas->irq = i2c->irq;

right?
