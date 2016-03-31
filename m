From: Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [PATCH v3 1/2] usb:dwc3: Enable support for 64-bit system
Date: Thu, 31 Mar 2016 11:04:13 +0300
Message-ID: <87mvpfgjk2.fsf@intel.com>
References: <1457594332-7490-1-git-send-email-tqnguyen@apm.com> <1457594332-7490-2-git-send-email-tqnguyen@apm.com> <87pouci03i.fsf@intel.com> <CAKrQpSt3Tm4Bu02ujgDnYu+29zA8VuWQ18o-TFMU1HJ970CkSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKrQpSt3Tm4Bu02ujgDnYu+29zA8VuWQ18o-TFMU1HJ970CkSA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Thang Q. Nguyen" <tqnguyen@apm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org, Phong Vo <pvo@apm.com>, Loc Ho <lho@apm.com>, patches <patches@apm.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

(please don't top-post)

"Thang Q. Nguyen" <tqnguyen@apm.com> writes:
> Hi Balbi,
> If CONFIG_DMA_CMA=3Dy, dma mask is set properly. The issue just happen
> when CONFIG_DMA_CMA is not set. In this case, dma mask is not set and
> we need this code to check if dma mask should be manually set to 32 or
> 64.

Can you point me to the code which has this conditional ? Why would
DMA_CMA=3Dn mean that dma_mask isn't initialized ? According to DMA_CMA's
help text (see below) that's supposed to allow drivers to *allocate*
large contiguous buffers, but that's not the case here.

config DMA_CMA
	bool "DMA Contiguous Memory Allocator"
	depends on HAVE_DMA_CONTIGUOUS && CMA
	help
	  This enables the Contiguous Memory Allocator which allows drivers
	  to allocate big physically-contiguous blocks of memory for use with
	  hardware components that do not support I/O map nor scatter-gather.

	  You can disable CMA by specifying "cma=3D0" on the kernel's command
	  line.

	  For more information see <include/linux/dma-contiguous.h>.
	  If unsure, say "n".



>
> ----
> Thang
>
> On Wed, Mar 30, 2016 at 8:09 PM, Felipe Balbi
> <felipe.balbi@linux.intel.com> wrote:
>>
>> Hi,
>>
>> "Thang Q. Nguyen" <tqnguyen@apm.com> writes:
>>> From: "Thang Q. Nguyen" <tqnguyen@apm.com>
>>>
>>> Add 64-bit DMA operation support to the USB DWC3 driver.
>>> First attempt to set the coherent DMA mask for 64-bit DMA.
>>> If that failed, attempt again with 32-bit DMA.
>>>
>>> Changes from v2:
>>>       - None.
>>>
>>> Changes from v1:
>>>       - Remove WARN_ON if dma_mask is NULL
>>
>> these changes lines should be between the tearline (---) and diffstat
>> below.
>>
>>> Signed-off-by: Thang Q. Nguyen <tqnguyen@apm.com>
>>> ---
>>>  drivers/usb/dwc3/core.c | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index de5e01f..2479c24 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -831,6 +831,21 @@ static int dwc3_probe(struct platform_device *pdev)
>>>       dwc->mem =3D mem;
>>>       dwc->dev =3D dev;
>>>
>>> +     /* Try to set 64-bit DMA first */
>>> +     if (!pdev->dev.dma_mask)
>>> +             /* Platform did not initialize dma_mask */
>>> +             ret =3D dma_coerce_mask_and_coherent(&pdev->dev,
>>> +                                                DMA_BIT_MASK(64));
>>> +     else
>>> +             ret =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MAS=
K(64));
>>> +
>>> +     /* If seting 64-bit DMA mask fails, fall back to 32-bit DMA mask =
*/
>>> +     if (ret) {
>>> +             ret =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MAS=
K(32));
>>> +             if (ret)
>>> +                     return ret;
>>> +     }
>>
>> Also, why is it so that you need this now ? glue layers are copying dma
>> mask from parent device and that should be set properly. This really
>> shouldn't be necessary in dwc3-core; it would mean that glue layer
>> didn't set this device up properly.
>>
>> --
>> balbi
>
>
>
> --=20
>
> Thang Q. Nguyen    | Staff SW Eng.
>
> C: +849.7684.7606 | O: +848.3770.0640
>
> F: +848.3770.0641  | tqnguyen@apm.com

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW/Nn9AAoJEIaOsuA1yqRE3t8P/0Ftsfei7GZ9W1ba8hEOq5L2
oQ8FYIcsqoxtxgK8AXFpxDAJtAVek8GM65+c9jO1dKcRcudM19tc7IPYo2qo8mOM
9c+rpdfCgwcC/gSBX4jLgUHnqCBlV2Cty+rIZDQDLZ1mk6D8XArH9qvKleigOfuV
Thl2EvDkfd040VjR0wPv89X9XaUcaRBN6r2kPgbgPs7KEyuEe8jHoannMIGIYvKD
NcUIMAF86bVFCGvV04OOi7eI6smDyNakn5JhKwTbt/GW35xpl1mI+qmSL/FxyKQ3
wenv+PsdJ6GBIhANWpyUhy0ykjnbp6WLtc2kbQWxueI/taMBSt9YlZQOmCw1iGnx
fZ1+aiUosfacmrfrP9JgJC83sdeVv0ZU9APcFbey/eqQOSkxSaNjoL2IpJsOzpyk
yi08uGkJ39iiN4AqhueJr1clzTn9pwufwx7y/4a07mEuKd+nVfIIL45eCjr7eUdU
+uAqngrGolaq4S8KjXAsaLuFFYCl7j+zlYYeVO9MuTbR7dsGddF+f0i4cIMLUuY0
4slAwyiSKsupv4PPBYTGu0CRJhF1ahqVE4Ok2rI/dQDBy4zlS8GyaMcgN5I9+DOr
+VhzscLUBvY2p2iy+q0Wkpk6Udt3ALW9zb4GEDysLBC/OiZtSR3mK0r3mwy1W7Lk
WgKwhiRvjzKqwICbrtoV
=fMK3
-----END PGP SIGNATURE-----
--=-=-=--
