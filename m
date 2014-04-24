From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/4] ARM: dts: Add support for DRA72x family of devices
Date: Thu, 24 Apr 2014 15:13:54 +0200
Message-ID: <201404241513.54380.arnd@arndb.de>
References: <1398333987-19454-1-git-send-email-rnayak@ti.com> <1398333987-19454-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1398333987-19454-3-git-send-email-rnayak@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com, nm@ti.com, linux-doc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday 24 April 2014, Rajendra Nayak wrote:
> 
> -- DRA742
> -  compatible = "ti,dra7xx", "ti,dra7"
> +- DRA74x
> +  compatible = "ti,dra74", "ti,dra7"
> +
> +- DRA72x
> +  compatible = "ti,dra72", "ti,dra7"

Actually, what I meant was that you should list the fill name of the SoC,
e.g. "ti,dra742", not just "ti,dra74". Leaving out the 'x' is not going
to prevent this from breaking when you have a new dra745 that is incompatible.

You can always list more strings, e.g.

	compatible = "ti,dra745", "ti,dra742", "ti,dra74", "ti,dra7";

if you have a dra745 product that is fully compatible with dra742, but the
important part here is that the first string must be the full name.

	Arnd
