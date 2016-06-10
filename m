From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: DRA7: hwmod: Remove QSPI address space entry from
 hwmod
Date: Fri, 10 Jun 2016 05:10:14 -0700
Message-ID: <20160610121013.GN22406@atomide.com>
References: <1463376303-22267-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463376303-22267-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Vignesh R <vigneshr@ti.com> [160515 22:27]:
> QSPI address space information is passed from device tree. Therefore
> remove legacy way of passing address space via hwmod data.

Applying this one into omap-for-v4.8/soc thanks.

Tony
