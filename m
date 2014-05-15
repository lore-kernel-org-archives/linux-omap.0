From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 3/5] dt/bindings: ti,edma: Remove redundant properties
 from documentation
Date: Thu, 15 May 2014 11:18:19 +0300
Message-ID: <5374784B.7020608@ti.com>
References: <1399977032-26469-1-git-send-email-peter.ujfalusi@ti.com> <1399977032-26469-4-git-send-email-peter.ujfalusi@ti.com> <7468082.VY82PIo3ZY@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7468082.VY82PIo3ZY@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: nsekhar@ti.com, joelf@ti.com, linux@arm.linux.org.uk, vinod.koul@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

On 05/15/2014 11:01 AM, Arnd Bergmann wrote:
> On Tuesday 13 May 2014 13:30:30 Peter Ujfalusi wrote:
>> From CCCFG register of eDMA3 we can get all the needed information f=
or the
>> driver about the IP:
>> Number of channels: NUM_DMACH
>> Number of regions: NUM_REGN
>> Number of slots (PaRAM sets): NUM_PAENTRY
>> Number of TC/EQ: NUM_EVQUE
>>
>> The ti,edma-regions; ti,edma-slots and dma-channels in DT are
>> redundant since the very same information can be obtained from the H=
W.
>> The mentioned properties can be removed from the binding document.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>=20
> I wonder if we should keep them listed as "optional" properties so yo=
u
> can have a dtb file that still works with older kernels which need th=
em.
>=20
> What you do is an incompatible change to the binding, which we should=
n't
> do lightly. Any new dts files don't need this information of course, =
but
> as a general rule, I'd rather keep things like this around unless we
> already have to enforce an ABI break that is well documented.

We could keep them as optional, or to be precise: ignored properties si=
nce we
are not going to even look at them in the future.
But I do not really see the reason to do so. With this change new kerne=
ls will
boot with old DTB - if it can not be changed which I have not seen yet.=
 Sure
old kernel would not boot with this change, but why would you downgrade=
 the
kernel and update the DTB on a board?
Bisecting is not a good reason since the bug you might be hunting for c=
ould be
in the DTS or in the kernel code so you need to update both of them to =
be sure
you reach the commit you are looking for.

--=20
P=E9ter
