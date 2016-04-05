From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 0/2] dmaengine: omap-dma: Fix polled completion
Date: Tue, 5 Apr 2016 17:50:48 +0300
Message-ID: <5703D0C8.80509@ti.com>
References: <1457616527-979-1-git-send-email-peter.ujfalusi@ti.com>
 <20160404131822.GA19738@vkoul-mobl.iind.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160404131822.GA19738@vkoul-mobl.iind.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: linux@arm.linux.org.uk, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Vinod,

On 04/04/16 16:18, Vinod Koul wrote:
> On Thu, Mar 10, 2016 at 03:28:45PM +0200, Peter Ujfalusi wrote:
>> Hi,
>>
>> Based on the discussion on the first version:
>> https://lkml.org/lkml/2016/2/25/167
>>
>> I have fixed the omap_dma_tx_status() - first patch and added the se=
cond patch
>> to not disable the interrupts for memcpy so multiple transfers can b=
e queued.
>=20
> Hi Peter,
>=20
> These do not apply for me. Can you please check.

I have resent as v3.

> FWIW my fixes is on -rc1

tested with -rc1

--=20
P=E9ter
