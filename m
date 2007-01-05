From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: Re: [PATCH] ARM: OMAP: Fix section mismatch warnings in omap-rng
Date: Fri, 05 Jan 2007 12:49:19 -0400
Message-ID: <1168015759.7712.7.camel@balbi>
References: <459D1DFD.6080606@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <459D1DFD.6080606@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Dirk,

> -static int __init omap_rng_probe(struct platform_device *pdev)
> +static int __devinit omap_rng_probe(struct platform_device *pdev)
> -static int __exit omap_rng_remove(struct platform_device *pdev)
> +static int __devexit omap_rng_remove(struct platform_device *pdev)

Actually, this will only be true if CONFIG_HOTPLUG is set to "y". This
way __devinit is defined to "null".

If we set CONFIG_HOTPLUG to "n" the same Section mismatch issue will
appear.

Maybe this is not the better way to do it.

-- 
Best Regards,

Felipe Balbi
felipe.lima@indt.org.br

Nokia Institute of Technology - INdT
Kernel Developers Team

+55 92 8127 0839
