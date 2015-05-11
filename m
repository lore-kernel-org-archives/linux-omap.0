From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v3 2/4] remoteproc: add a rproc ops for performing address
 translation
Date: Mon, 11 May 2015 09:55:09 -0500
Message-ID: <5550C2CD.5070207@ti.com>
References: <1427917039-43206-1-git-send-email-d-gerlach@ti.com> <1427917039-43206-3-git-send-email-d-gerlach@ti.com> <CAK=WgbaSD9tGVKhUkbL3JjtW9GuAR_fbWHG6rx1m_v9TDW0Osw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=WgbaSD9tGVKhUkbL3JjtW9GuAR_fbWHG6rx1m_v9TDW0Osw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi Ohad,

On 05/09/2015 02:54 AM, Ohad Ben-Cohen wrote:
> Hi Dave,
> 
> On Wed, Apr 1, 2015 at 10:37 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
>> From: Suman Anna <s-anna@ti.com>
>>
>> The rproc_da_to_va API is currently used to perform any device to
>> kernel address translations to meet the different needs of the remoteproc
>> core/drivers (eg: loading). The functionality is achieved within the
>> remoteproc core, and is limited only for carveouts allocated within the
>> core.
>>
>> A new rproc ops, da_to_va, is added to provide flexibility to platform
>> implementations to perform the address translation themselves when the
>> above conditions cannot be met by the implementations. The rproc_da_to_va()
>> API is extended to invoke this ops if present, and fallback to regular
>> processing if the platform implementation cannot provide the translation.
>> This will allow any remoteproc implementations to translate addresses for
>> dedicated memories like internal memories.
> 
> Can you please provide specific examples where this is needed and how
> it is going to be used?

We will be using this for the WkupM3 remoteproc driver, and also using
it for a PRUSS remoteproc driver (on downstream kernel for now) on TI
AM335x/AM437x SoCs. The driver uses a firmware where all segments are
placed only in internal RAMs (nothing in DDR), and we use the remoteproc
core's ELF loader code to perform the loading. We need a way for the
remoteproc elf loader core to be able to translate these device
addresses into a kernel mapped addresses so that the loader code can
copy the firmware segments.

The previous attempt on this was to use a new resource type through the
resource table, whereby we are publishing and storing the internal
memory translations were stored in the remoteproc core [1].

regards
Suman

[1] https://patchwork.kernel.org/patch/5602981/
