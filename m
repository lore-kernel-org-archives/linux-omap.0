From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 02/10] ARM: OMAP5 / DRA7: PM: Set MPUSS-EMIF clock-domain static dependency
Date: Wed, 27 Aug 2014 11:44:34 -0700
Message-ID: <7hmwapdb71.fsf@paris.lan>
References: <1408716154-26101-1-git-send-email-nm@ti.com>
	<1408716154-26101-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408716154-26101-3-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Fri, 22 Aug 2014 09:02:26 -0500")
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

Nishanth Menon <nm@ti.com> writes:

> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> With EMIF clock-domain put under hardware supervised control, memory
> corruption and untraceable crashes are observed on OMAP5. Further
> investigation revealed that there is a weakness in the PRCM on this
> specific dynamic depedency.

hmm, "weakness".  That's a rather polite way of saying bug. :)

Kevin
