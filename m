From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: dra7xx: Increase spi-max-frequency to 76.8MHz
 for QSPI
Date: Fri, 26 Aug 2016 08:15:09 -0700
Message-ID: <20160826151508.ac5uy7557lovbd7r@atomide.com>
References: <20160801130655.15004-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160801130655.15004-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Vignesh R <vigneshr@ti.com> [160801 06:07]:
> According to AM572x DM SPRS953A, QSPI maximum bus speed can be 76.8MHz.
> Therefore, increase the spi-max-frequency value of QSPI node to 76.8MHz
> for DRA74 and DRA72 evm. This improves flash raw read speed by ~2MB/s.

Applying into omap-for-v4.9/dt thanks.

Tony
