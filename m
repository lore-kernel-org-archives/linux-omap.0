From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RESEND v2 2/2] regulator: TPS65910: VDD1/2 voltage
 selector count
Date: Tue, 8 Nov 2011 15:56:39 +0000
Message-ID: <20111108155639.GE5632@opensource.wolfsonmicro.com>
References: <1320758650-29180-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1320758650-29180-1-git-send-email-afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-kernel@vger.kernel.org, lrg@ti.com, sameo@linux.intel.com, nsekhar@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 08, 2011 at 06:54:10PM +0530, Afzal Mohammed wrote:
> Count of selector voltage is required for regulator_set_voltage
> to work via set_voltage_sel. VDD1/2 currently have it as zero,
> so regulator_set_voltage won't work for VDD1/2.
> Update count (n_voltages) for VDD1/2.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
