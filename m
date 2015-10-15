From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5 00/24] dmaengine/ARM: Merge the edma drivers into one
Date: Thu, 15 Oct 2015 10:16:12 +0300
Message-ID: <561F52BC.7040903@ti.com>
References: <1444822986-20562-1-git-send-email-peter.ujfalusi@ti.com>
 <20151014143124.GU27370@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151014143124.GU27370@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: nsekhar@ti.com, linux@arm.linux.org.uk, olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/14/2015 05:31 PM, Vinod Koul wrote:
> On Wed, Oct 14, 2015 at 02:42:42PM +0300, Peter Ujfalusi wrote:
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
>>
>> This change will also help us to do bigger changes in the eDMA drive=
r since,
>> since now we have only one driver to work with.
>=20
> I have applied this now. I got a conlfict on 3rd one while applying a=
nd also
> I got conflict while merging to next
>=20
> Pls verify all is well!

Thanks Vinod,

It looks fine.
It is strange since I'm working on top of linux-next as well. The follo=
wing
commit caused the conflict:
ddfe4d0cce78 dmaengine: edma: remove redundant conditions

I have it in my linux-next, but for some reason it is missing from your
topic/edma, so the series applied with conflicts there and when merging=
 on top
of linux-next there were again conflict.

Thank you,
P=E9ter
