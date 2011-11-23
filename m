From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH RESEND v2 2/2] regulator: TPS65910: VDD1/2 voltage
 selector count
Date: Wed, 23 Nov 2011 09:59:27 +0000
Message-ID: <CABS+qY0gHPW6uG=7kC9tarKr=2GoRk8nRrMQ-BG4DStf=dZrEA@mail.gmail.com>
References: <1320758650-29180-1-git-send-email-afzal@ti.com>
	<20111108155639.GE5632@opensource.wolfsonmicro.com>
	<C8443D0743D26F4388EA172BF4E2A7A9023DC4@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A9023DC4@DBDE01.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "Nori, Sekhar" <nsekhar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Afzal,

On 23 November 2011 05:31, Mohammed, Afzal <afzal@ti.com> wrote:
> Hi Liam,
>
> On Tue, Nov 08, 2011 at 21:26:39, Mark Brown wrote:
>> On Tue, Nov 08, 2011 at 06:54:10PM +0530, Afzal Mohammed wrote:
>> > Count of selector voltage is required for regulator_set_voltage
>> > to work via set_voltage_sel. VDD1/2 currently have it as zero,
>> > so regulator_set_voltage won't work for VDD1/2.
>> > Update count (n_voltages) for VDD1/2.
>>
>> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>>
>
> Can you please help this patch to get into mainline Kernel.
> Without this VDD1 & 2 voltages cannot be varied on TPS65910.
>
> This patch applies cleanly to current mainline and is not
> dependent on any other patch.
>

Will do, just been getting stuff back together after the kernel.org
break in and a lot travel.

Liam
