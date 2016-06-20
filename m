From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 1/4] usb: dwc3: core.h: add some register definitions
Date: Mon, 20 Jun 2016 14:53:05 +0300
Message-ID: <5767D921.60509@ti.com>
References: <1465564650-27516-1-git-send-email-rogerq@ti.com>
 <1465564650-27516-2-git-send-email-rogerq@ti.com>
 <87fus8qkep.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HdVjA76D2Q4n7O8cRfPqEFNOXhMSeh9Fc"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87fus8qkep.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--HdVjA76D2Q4n7O8cRfPqEFNOXhMSeh9Fc
Content-Type: multipart/mixed; boundary="nOXMLfIKmMcKFqaM1pPTwKbpRwuQBEw8M"
From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org,
 sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
 jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org,
 yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <5767D921.60509-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 1/4] usb: dwc3: core.h: add some register definitions
References: <1465564650-27516-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
 <1465564650-27516-2-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
 <87fus8qkep.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
In-Reply-To: <87fus8qkep.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

--nOXMLfIKmMcKFqaM1pPTwKbpRwuQBEw8M
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20/06/16 12:28, Felipe Balbi wrote:
>=20
> Hi,
>=20
> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>> Add OTG and GHWPARAMS6 register definitions
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/usb/dwc3/core.h | 84 ++++++++++++++++++++++++++++++++++++++++=
++++++++-
>>  1 file changed, 83 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index 8fb6361..32bb7531 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -197,6 +197,15 @@
>>  #define DWC3_GCTL_GBLHIBERNATIONEN	(1 << 1)
>>  #define DWC3_GCTL_DSBLCLKGTNG		(1 << 0)
>> =20
>> +/* Global Status Register */
>> +#define DWC3_GSTS_OTG_IP	BIT(10)
>> +#define DWC3_GSTS_BC_IP		BIT(9)
>> +#define DWC3_GSTS_ADP_IP	BIT(8)
>> +#define DWC3_GSTS_HOST_IP	BIT(7)
>> +#define DWC3_GSTS_DEVICE_IP	BIT(6)
>> +#define DWC3_GSTS_CSR_TIMEOUT	BIT(5)
>> +#define DWC3_GSTS_BUS_ERR_ADDR_VLD	BIT(4)
>> +
>>  /* Global USB2 PHY Configuration Register */
>>  #define DWC3_GUSB2PHYCFG_PHYSOFTRST	(1 << 31)
>>  #define DWC3_GUSB2PHYCFG_SUSPHY		(1 << 6)
>> @@ -269,7 +278,12 @@
>>  #define DWC3_MAX_HIBER_SCRATCHBUFS		15
>> =20
>>  /* Global HWPARAMS6 Register */
>> -#define DWC3_GHWPARAMS6_EN_FPGA			(1 << 7)
>> +#define DWC3_GHWPARAMS6_BCSUPPORT		BIT(14)
>> +#define DWC3_GHWPARAMS6_OTG3SUPPORT		BIT(13)
>> +#define DWC3_GHWPARAMS6_ADPSUPPORT		BIT(12)
>> +#define DWC3_GHWPARAMS6_HNPSUPPORT		BIT(11)
>> +#define DWC3_GHWPARAMS6_SRPSUPPORT		BIT(10)
>> +#define DWC3_GHWPARAMS6_EN_FPGA			BIT(7)
>=20
> Keep consistency, we don't use BIT() here.
>=20
Checkpatch was complaining. But I can revert to the non BIT format for
consistency.

cheers,
-roger


--nOXMLfIKmMcKFqaM1pPTwKbpRwuQBEw8M--

--HdVjA76D2Q4n7O8cRfPqEFNOXhMSeh9Fc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXZ9khAAoJENJaa9O+djCTNyoP+wVqs2J6kA8Bd7rCDwCAXYF5
ePlltgw1dLjtnRy27fllbF4ZJEQqAxnzE4ZnikPi8KdI7cjBFg5RneT9IsTkPoQ1
mZ29OZRkbnWaIIM/oWvCP6bxbqv4iWnr1Gn2Htnt794S+g/phZ23l1IiLG+DaA46
ztZat+F/8FWI9wvIpEu3BW8XeV6aPWId0luEcFEYOcRTNYXyB+krJo1tzGtyfdoH
76Wn+oRWOuNsYq8EgmgXvECxBkqRuzwaEsU2j5KxJ1ylhwieixEAUED8mo4g92ZY
9A+f8/lCGqR5U+gs6U5cMCb04moNRuk443nQkTHuPMN5uEXtS2EgGEm3pBKe+RPC
7t9qDtLzyQe9QtbsPu1JOYxfjKu/wOGuedeb0G7p2N4QgWlj3wuTrP3EGPjACX2A
CPTkGstyyFqeMSdxvwvbZhOxOf4F16VwQWYvTvbYb0azIPyThPNKPuj429B7FyP6
Fwu6UEzbgdvcOLfWRV91KYApsCRm+jCXpAcmjKZJD4Da282wwU2Tj9Ea3moR/3uw
wNb4RcF2YdIoTW3xiDY7Xu3kmJQLTVWtJkORWCUzMcCr0XPfp4ZYIxad1miWcdrl
sC4DJzG11M5J0v4LsOYy/ClZG80x08499zLDRK22xKMaScDZ6W6tmilriBogYxOw
L9bluX4nXdqCIM25cWJW
=ko6w
-----END PGP SIGNATURE-----

--HdVjA76D2Q4n7O8cRfPqEFNOXhMSeh9Fc--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
