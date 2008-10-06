From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Increase VMALLOC_END to allow 256MB RAM
Date: Mon, 6 Oct 2008 10:16:36 +0300
Message-ID: <20081006071634.GF14042@atomide.com>
References: <1222936611-19084-1-git-send-email-mans@mansr.com> <87d4ijwdje.fsf@deeprootsystems.com> <04C4B3A9-6FEA-4141-BDAB-74C7274301BC@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54665 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbYJFHNi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 03:13:38 -0400
Content-Disposition: inline
In-Reply-To: <04C4B3A9-6FEA-4141-BDAB-74C7274301BC@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

* Koen Kooi <k.kooi@student.utwente.nl> [081004 12:39]:
>
> Op 2 okt 2008, om 11:29 heeft Kevin Hilman het volgende geschreven:
>
>> Mans Rullgard <mans@mansr.com> writes:
>>
>>> This increases VMALLOC_END to 0x18000000, making room for 256MB
>>> RAM with the default 128MB vmalloc region.
>>>
>>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>>> ---
>>> arch/arm/plat-omap/include/mach/vmalloc.h |    2 +-
>>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/include/mach/vmalloc.h b/arch/arm/ 
>>> plat-omap/include/mach/vmalloc.h
>>> index d8515cb..b97dfaf 100644
>>> --- a/arch/arm/plat-omap/include/mach/vmalloc.h
>>> +++ b/arch/arm/plat-omap/include/mach/vmalloc.h
>>> @@ -17,5 +17,5 @@
>>>  * along with this program; if not, write to the Free Software
>>>  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  
>>> 02111-1307 USA
>>>  */
>>> -#define VMALLOC_END	  (PAGE_OFFSET + 0x17000000)
>>> +#define VMALLOC_END	  (PAGE_OFFSET + 0x18000000)
>>
>> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
>>
>> I have a similar patch locally, but the problem I currently have with
>> it is that there is no longer any hole between vmalloc space and the
>> beginning of IO space (the first virtual mappings start at
>> 0xd8000000.)
>>
>> It's a bit unsafe, but IMO it's is probably OK for the short term.
>> Longer term I think the virtual address space of the OMAP kernels
>> needs to be reworked.  It currenly just maps directly onto the
>> physical address space, which makes the IO_ADDRESS() conversion macros
>> simple, but leaves lots of wasted space in the virtual address space.

Seems to be also safe for omap1, so I've pushed it.

> I was told that omap3 support 512MB of ram, so is it possible to account 
> for that as well, or can we revisit that when the actual LP-DDR become 
> available?

Well, to make room for a long term solution let's do the following:

- Use OMAP1_IO_ADDRESS and OMAP2_IO_ADDRES and get rid of
  OMAP_IO_ADDRESS. This allows compiling in more code into a single
  binary

- Remove the remaining io_v2p() and any XXX_IO_ADDRESS()
  in the drivers. Drivers should be now using ioremap() as noted
  earlier

- Then we can further split OMAP2_IO_ADDRESS() into L3_IO_ADDRESS()
  and L4_IO_ADDRESS(), which allows us to move L4_XXXX_VIRT out
  of the way

Anybody got better ideas?

Regards,

Tony
