From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 00/25] dmaengine/ARM: Merge the edma drivers into one
Date: Wed, 14 Oct 2015 13:50:31 +0300
Message-ID: <561E3377.4050909@ti.com>
References: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
 <20151014102755.GL27370@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151014102755.GL27370@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: nsekhar@ti.com, linux@arm.linux.org.uk, olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/14/2015 01:27 PM, Vinod Koul wrote:
> On Thu, Sep 24, 2015 at 01:01:47PM +0300, Peter Ujfalusi wrote:
>> Hi,
>>
>> Cover letter:
>>
>> with this series the edma two driver setup will be changed to have o=
nly one
>> driver to support eDMA3. The legacy edma interface will be removed a=
nd eDMA can
>> only be used via dmaengine API from this point on.
>> In order to do the merge the following improvements has been done:
>> - One driver instance per eDMA:
>>  - Any number of eDMA instances are supported (both legacy and DT bo=
ot)
>> - Not relying on global variables, arrays, etc
>> - Code simplification and optimizations in several places
>=20
> One question though, after this move and merge are we still left with=
 edma
> in arm/ ?

The code from arch/arm/ is gone with this series.

--=20
P=E9ter
