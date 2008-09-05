From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 1/2] OMAP2xxx EAC: update per recent IO address changes
Date: Fri, 5 Sep 2008 08:23:18 +0100
Message-ID: <20080905072318.GA32345@flint.arm.linux.org.uk>
References: <20080905054959.5272.63450.stgit@localhost.localdomain> <20080905055048.5272.89989.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58306 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbYIEHX3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 03:23:29 -0400
Content-Disposition: inline
In-Reply-To: <20080905055048.5272.89989.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On Thu, Sep 04, 2008 at 11:51:15PM -0600, Paul Walmsley wrote:
> @@ -707,7 +707,7 @@ static int __devinit eac_probe(struct platform_device *pdev)
>  		err = -ENODEV;
>  		goto err1;
>  	}
> -	eac->base = (void __iomem *)io_p2v(res->start);
> +	eac->base = ioremap(res->start, (res->end - res->start) + 1);

The parens around the subtraction are just noise; please remove.
