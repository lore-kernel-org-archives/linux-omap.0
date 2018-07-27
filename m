From: Keerthy <j-keerthy@ti.com>
Subject: Re: ARM: Build failures with CONFIG_HAVE_RCU_TABLE_FREE=y on
 linux-next
Date: Fri, 27 Jul 2018 14:43:48 +0530
Message-ID: <6f9ef0f9-9eda-cf87-3219-cb82e08ba8ac@ti.com>
References: <8a8db414-4723-14f2-ef9d-c10aecc80278@ti.com>
 <20180727091154.GL6920@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180727091154.GL6920@n2100.armlinux.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Nishanth Menon <nm@ti.com>, tony@atomide.com, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Friday 27 July 2018 02:41 PM, Russell King - ARM Linux wrote:
> arm: asm/tlb.h: Fix build error implicit func declaration

Okay so basically blank functions in arch/arm/include/asm/tlb.h.

Thanks,
Keerthy
