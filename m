From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap2plus_defconfig: enable SPLIT and DWARF4
Date: Mon, 11 Jan 2016 15:34:39 -0800
Message-ID: <20160111233438.GB12777@atomide.com>
References: <1452547572-23515-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1452547572-23515-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [160111 13:26]:
> CONFIG_DEBUG_INFO_SPLIT will split debug info on
> .dwo files. This will generate a smaller vmlinux and
> smaller .ko modules, which will be easier to ship on
> certain products.
> 
> CONFIG_DEBUG_INFO_DWARF4 will generate debug info in
> DWARF4 format, which ends up being larger, but
> improves the probability of resolving variables in
> optmized code.

Nice, this makes my initramfs go down from about 17MB
to 4.7 MB :)

Regards,

Tony
