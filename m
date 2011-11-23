From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH RESEND v2 2/2] regulator: TPS65910: VDD1/2 voltage
 selector count
Date: Wed, 23 Nov 2011 05:31:43 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9023DC4@DBDE01.ent.ti.com>
References: <1320758650-29180-1-git-send-email-afzal@ti.com>
 <20111108155639.GE5632@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111108155639.GE5632@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Girdwood, Liam" <lrg@ti.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "Nori, Sekhar" <nsekhar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Liam,

On Tue, Nov 08, 2011 at 21:26:39, Mark Brown wrote:
> On Tue, Nov 08, 2011 at 06:54:10PM +0530, Afzal Mohammed wrote:
> > Count of selector voltage is required for regulator_set_voltage
> > to work via set_voltage_sel. VDD1/2 currently have it as zero,
> > so regulator_set_voltage won't work for VDD1/2.
> > Update count (n_voltages) for VDD1/2.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 

Can you please help this patch to get into mainline Kernel.
Without this VDD1 & 2 voltages cannot be varied on TPS65910.

This patch applies cleanly to current mainline and is not
dependent on any other patch.

Regards
Afzal
