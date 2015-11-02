From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: OMAP: hwmod: AM33xx/43xx: Add HWMOD_INIT_NO_IDLE
 flag to tptc
Date: Mon, 2 Nov 2015 12:23:08 +0200
Message-ID: <5637398C.6020000@ti.com>
References: <1446459060-16220-1-git-send-email-peter.ujfalusi@ti.com>
 <20151102102440.GM21326@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151102102440.GM21326@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: nsekhar@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com, olof@lixom.net
List-Id: linux-omap@vger.kernel.org

On 11/02/2015 12:24 PM, Vinod Koul wrote:
> On Mon, Nov 02, 2015 at 12:11:00PM +0200, Peter Ujfalusi wrote:
>> In Linux we do not have driver for TPTCs of eDMA3 since there is no =
need to
>> do any configuration within TPTC for the eDMA3 to be operational. Al=
l
>> configuration is via the TPCC.
>> To prevent the omap_device_late_idle() to disable the TPTCs when the=
y are
>> no longer bind with the edma driver, the HWMOD_INIT_NO_IDLE need to =
be
>> added.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Vinod, Olof,
>>
>> This patch somehow got lost in my working branch. It was mixed withi=
n the patches
>> I will have for 4.5 while it should have been within the new eDMA3 b=
inding
>> series..
>=20
> Does this fix the issue reported by Olof? Also ACK pls for this

Yes, it is fixing the issue, I have this in my branch. everything looks=
 fine
on AM335x/AM437x/Dra7xx where I have eDMA in use.

--=20
P=E9ter
