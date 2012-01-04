From: Mark Grosen <mgrosen@ti.com>
Subject: Re: [PATCH 1/7] amp/remoteproc: add framework for controlling remote
 processors
Date: Tue, 3 Jan 2012 23:29:53 -0800
Message-ID: <4F03FFF1.4090108@ti.com>
References: <1319536106-25802-1-git-send-email-ohad@wizery.com> <1319536106-25802-2-git-send-email-ohad@wizery.com> <20120103233534.GC2492@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120103233534.GC2492@ponder.secretlab.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Brian Swetland <swetland@google.com>, Arnd Bergmann <arnd@arndb.de>, Rusty Russell <rusty@rustcorp.com.au>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Greg KH <greg@kroah.com>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

On 01/03/2012 03:35 PM, Grant Likely wrote:
> On Tue, Oct 25, 2011 at 11:48:20AM +0200, Ohad Ben-Cohen wrote:
>> Modern SoCs typically employ a central symmetric multiprocessing (SMP)
>> application processor running Linux, with several other asymmetric
>> multiprocessing (AMP) heterogeneous processors running different instances
>> of operating system, whether Linux or any other flavor of real-time OS.
>>
>> Booting a remote processor in an AMP configuration typically involves:
>> - Loading a firmware which contains the OS image
>> - Allocating and providing it required system resources (e.g. memory)
>> - Programming an IOMMU (when relevant)
>> - Powering on the device
>>
>> This patch introduces a generic framework that allows drivers to do
>> that. In the future, this framework will also include runtime power
>> management and error recovery.
>>
>> Based on (but now quite far from) work done by Fernando Guzman Lugo
>> <fernando.lugo@ti.com>.
> [...]
>> +static int rproc_load_segments(struct rproc *rproc, const u8 *elf_data)
>> +{
>> +	struct device *dev = rproc->dev;
>> +	struct elf32_hdr *ehdr;
>> +	struct elf32_phdr *phdr;
>> +	int i, ret = 0;
>> +
>> +	ehdr = (struct elf32_hdr *)elf_data;
>> +	phdr = (struct elf32_phdr *)(elf_data + ehdr->e_phoff);
>> +
>> +	/* go through the available ELF segments */
>> +	for (i = 0; i<  ehdr->e_phnum; i++, phdr++) {
>> +		u32 da = phdr->p_paddr;
>> +		u32 memsz = phdr->p_memsz;
>> +		u32 filesz = phdr->p_filesz;
> This could be an endianess problem.  If the endianess of the host and
> the rproc are different, then what is the endianess of the elf file?
> Is the endianess of the elf file verified before attempting to parse it?

Yes, this could be a problem, but most likely only in theory. I think it 
would be
unlikely that the host and the rproc would run different endian-ness due 
to the
hassles and overhead of converting data (although TI has processors that
allow it to be done). That said, we should check to prevent an oops.

Another sanity check to add is for the machine type. Some of the TI SoCs
have more than one type of rproc; e.g., OMAP4 has Cortex M3 and C6000 DSP.
We should not load the wrong code on an rproc.

Mark
