From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 2/5] ARM: dts: Add support for DRA72x family of devices
Date: Tue, 29 Apr 2014 13:16:28 +0200
Message-ID: <5062004.uhiBYDX4C3@wuerfel>
References: <1398769513-8736-1-git-send-email-rnayak@ti.com> <1398769513-8736-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1398769513-8736-3-git-send-email-rnayak@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com, nm@ti.com, s-anna@ti.com, linux-doc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 29 April 2014 16:35:10 Rajendra Nayak wrote:
> DRA722 is part of DRA72x family which are single core cortex A15 devices
> with most infrastructure IPs otherwise same as whats on the DRA74x family.
> 
> So move the cpu nodes into dra74x.dtsi and dra72x.dtsi respectively.
> 
> Also add a minimal dra72-evm dts file.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: linux-doc@vger.kernel.org
> Cc: devicetree@vger.kernel.org

Acked-by: Arnd Bergmann <arnd@arndb.de>
