From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: dts: am335x-baltos: use phy-phandle declarations
Date: Wed, 23 Nov 2016 08:10:49 -0800
Message-ID: <20161123161049.GH4082@atomide.com>
References: <1479916166-6633-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1479916166-6633-1-git-send-email-yegorslists@googlemail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: yegorslists@googlemail.com
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* yegorslists@googlemail.com <yegorslists@googlemail.com> [161123 07:49]:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> phy-phandle is now a preferred method to reference a PHY device.
> Especially in regards to cpsw it enables PHY specific settings like
> max-speed etc. being specified in DTS.

Applying into omap-for-v4.10/dt thanks.

Tony
