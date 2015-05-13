From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5 0/8] dmaengine/dra7x: DMA router (crossbar support)
Date: Wed, 13 May 2015 17:57:03 +0300
Message-ID: <5553663F.9040604@ti.com>
References: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com> <20150509114423.GK3521@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150509114423.GK3521@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com, arnd@arndb.de, maxime.ripard@free-electrons.com
List-Id: linux-omap@vger.kernel.org

On 05/09/2015 02:44 PM, Vinod Koul wrote:
>> This implementation is not tied to any DMA driver so it is possible =
to use the
>> framework by other vendors, also ACPI version of binding can be easy=
 enough to
>> be added.
> I have applied all but last change to topic/omap

I can only find 6 patches out of the 8 in topic/omap. Patch 3 - which i=
s the
main reason for this series seams to be missing but the binding documen=
t patch
for the ti-dma-crossbar is there.

--=20
P=E9ter
