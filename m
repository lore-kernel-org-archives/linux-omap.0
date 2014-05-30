From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [Resend/PATCH] arm: dts: dra7: Add qspi device.
Date: Fri, 30 May 2014 17:04:15 +0530
Message-ID: <53886CB7.4070104@ti.com>
References: <1399374445-16456-1-git-send-email-sourav.poddar@ti.com> <20140506165254.GN18474@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140506165254.GN18474@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sourav Poddar <sourav.poddar@ti.com>, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Menon, Nishanth" <nm@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 06 May 2014 10:22 PM, Tony Lindgren wrote:
> * Sourav Poddar <sourav.poddar@ti.com> [140506 04:08]:
>> These add device tree entry for qspi controller driver on dra7-evm.
> Thanks applying into omap-for-v3.16/dt.
There is a problem with this. The qspi node defines crossbar number
 as its interrupt number. Since the crossbar dts patches are not yet
 there, this causes a warning during boot.  So interrupts = < >
 property should be removed from DT and added later by crossbar series.

Regards,
Sricharan
