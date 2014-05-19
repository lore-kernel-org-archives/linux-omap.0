From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 02/13] ARM: edma: Take the number of tc from edma_soc_info
 (pdata)
Date: Mon, 19 May 2014 19:37:29 +0300
Message-ID: <537A3349.3030404@ti.com>
References: <1400242640-9902-1-git-send-email-peter.ujfalusi@ti.com> <1400242640-9902-3-git-send-email-peter.ujfalusi@ti.com> <5379E5E6.9080500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5379E5E6.9080500@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, joelf@ti.com, arnd@arndb.de
Cc: linux@arm.linux.org.uk, vinod.koul@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

On 05/19/2014 02:07 PM, Sekhar Nori wrote:
> To which baseline do the patches apply? These lines are not present a=
t
> least in v3.15-rc5. I am applying the patch without this hunk.

It is generate on top of linux-next-20140515.
next picked up several patches since 3.15-rc and I also have my other p=
atch in
my working branch under this series:
ARM: edma: Clean up and simplify the code around irq request

--
P=E9ter
