From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2] ARM: bcm: Fix support for BCM2711 SoC which breaks
 other ARM platforms
Date: Sun, 15 Dec 2019 08:48:50 +0100
Message-ID: <8330901D-84A6-4618-A509-477D04A93B7B@goldelico.com>
References: <0d7bef0622d69bd4f1129afe26b358669e639ae8.1576361067.git.hns@goldelico.com>
 <b209c3dd-0d20-05b1-6cbc-62f40623028c@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <b209c3dd-0d20-05b1-6cbc-62f40623028c@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: arm-soc <linux-arm-kernel@lists.infradead.org>, letux-kernel@openphoenux.org, Scott Branden <sbranden@broadcom.com>, Tony Lindgren <tony@atomide.com>, Ray Jui <rjui@broadcom.com>, linux@armlinux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, Stefan Wahren <wahrenst@gmx.net>, kernel@pyra-handheld.com, Linux-OMAP <linux-omap@vger.kernel.org>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, linux-rpi-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Florian,

> Am 14.12.2019 um 23:49 schrieb Florian Fainelli <f.fainelli@gmail.com>:
> 
> This looks fine, I would just rephrase the commit subject as:
> 
> ARM: bcm: Add missing sentinel to bcm2711_compat[]
> 
> instead of indicating the breakage but not so much the fix, if that is
> okay with you. 

Yes, is okay and indeed better.

> -- 
> Florian


BR and thanks,
Nikolaus
