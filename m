From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 11/25] ARM/dmaengine: edma: Merge the two drivers under
 drivers/dma/
Date: Tue, 13 Oct 2015 13:39:07 +0300
Message-ID: <561CDF4B.3050208@ti.com>
References: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
 <1443088932-21731-12-git-send-email-peter.ujfalusi@ti.com>
 <20151012160024.GF27370@localhost> <561CC7B9.8000201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <561CC7B9.8000201@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: nsekhar@ti.com, linux@arm.linux.org.uk, olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/13/2015 11:58 AM, Peter Ujfalusi wrote:
> On 10/12/2015 07:00 PM, Vinod Koul wrote:
>> On Thu, Sep 24, 2015 at 01:01:58PM +0300, Peter Ujfalusi wrote:
>>> Move the code out from arch/arm/common and merge it inside of the d=
maengine
>>> driver.
>>> This change is done with as minimal change to the code as possible =
to avoid
>>> any possibilities to introducing regression.
>>
>> Is this a pure move patch or code has been modified, if latter am
>> disappointed that existing code style issue have not been fixed
>=20
> Yes, it is mostly code move, I have done minimal changes only needed =
to get
> the moved code working in the new location.
> Patch 13 in this series will go through the file and will fix up most=
 (I hope
> all) of the outstanding coding style issues.
> At this point I wanted to have as small change as possible.

But fair enough, I will resend the series with checkpatch fixes done fo=
r this
patch.

--=20
P=E9ter
