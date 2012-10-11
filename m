From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC][PATCH v4? 0/7] Adaptive Body-Bias for OMAP
Date: Thu, 11 Oct 2012 08:33:04 -0500
Message-ID: <20121011133304.GA19170@kahuna>
References: <1349313974-5473-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52405 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab2JKNdK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Oct 2012 09:33:10 -0400
Content-Disposition: inline
In-Reply-To: <1349313974-5473-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: khilman@deeprootsystems.com, paul@pwsan.com, linux-omap@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, linux-arm-kernel@lists.infradead.org

On 18:26-20121003, Mike Turquette wrote:
> From: Mike Turquette <mturquette@linaro.org>
[...]
> 
>  arch/arm/mach-omap2/Makefile                  |    8 +-
>  arch/arm/mach-omap2/abb.c                     |  322 +++++++++++++++++++++++++
>  arch/arm/mach-omap2/abb.h                     |   94 ++++++++
[...]
>  arch/arm/plat-omap/include/plat/voltage.h     |    1 +
>  18 files changed, 699 insertions(+), 37 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/abb.c
>  create mode 100644 arch/arm/mach-omap2/abb.h
>  create mode 100644 arch/arm/mach-omap2/abb36xx_data.c
>  create mode 100644 arch/arm/mach-omap2/abb44xx_data.c

dumb question: with the request to move everything out of mach-omap2
directory, do we still want to add more files into mach-omap2?

Regards,
NM
