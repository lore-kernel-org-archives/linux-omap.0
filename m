From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH] OMAP: Increase VMALLOC_END to allow 256MB RAM
Date: Sat, 4 Oct 2008 11:38:55 +0200
Message-ID: <04C4B3A9-6FEA-4141-BDAB-74C7274301BC@student.utwente.nl>
References: <1222936611-19084-1-git-send-email-mans@mansr.com> <87d4ijwdje.fsf@deeprootsystems.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-11--7199887"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:34438 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173AbYJDJjE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 4 Oct 2008 05:39:04 -0400
Received: from [172.20.1.5] (vpn006014.vpn.utwente.nl [130.89.6.14])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m949cvI2025185
          for <linux-omap@vger.kernel.org>; Sat, 4 Oct 2008 11:38:58 +0200
In-Reply-To: <87d4ijwdje.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-11--7199887
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 2 okt 2008, om 11:29 heeft Kevin Hilman het volgende geschreven:

> Mans Rullgard <mans@mansr.com> writes:
>
>> This increases VMALLOC_END to 0x18000000, making room for 256MB
>> RAM with the default 128MB vmalloc region.
>>
>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> ---
>> arch/arm/plat-omap/include/mach/vmalloc.h |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/mach/vmalloc.h b/arch/arm/ 
>> plat-omap/include/mach/vmalloc.h
>> index d8515cb..b97dfaf 100644
>> --- a/arch/arm/plat-omap/include/mach/vmalloc.h
>> +++ b/arch/arm/plat-omap/include/mach/vmalloc.h
>> @@ -17,5 +17,5 @@
>>  * along with this program; if not, write to the Free Software
>>  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  
>> 02111-1307 USA
>>  */
>> -#define VMALLOC_END	  (PAGE_OFFSET + 0x17000000)
>> +#define VMALLOC_END	  (PAGE_OFFSET + 0x18000000)
>
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
>
> I have a similar patch locally, but the problem I currently have with
> it is that there is no longer any hole between vmalloc space and the
> beginning of IO space (the first virtual mappings start at
> 0xd8000000.)
>
> It's a bit unsafe, but IMO it's is probably OK for the short term.
> Longer term I think the virtual address space of the OMAP kernels
> needs to be reworked.  It currenly just maps directly onto the
> physical address space, which makes the IO_ADDRESS() conversion macros
> simple, but leaves lots of wasted space in the virtual address space.

I was told that omap3 support 512MB of ram, so is it possible to  
account for that as well, or can we revisit that when the actual LP- 
DDR become available?

regards,

Koen




--Apple-Mail-11--7199887
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI5zmxMkyGM64RGpERAk9eAKCJ303hTrcdW1AfURl/sqFjklBvTwCgs7tV
CjBPM2dXH/ztebXzAkOO+oQ=
=8H0B
-----END PGP SIGNATURE-----

--Apple-Mail-11--7199887--
