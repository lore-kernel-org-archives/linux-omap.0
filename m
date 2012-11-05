From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3] capebus moving omap_devices to mach-omap2
Date: Mon, 05 Nov 2012 09:56:28 -0600
Message-ID: <5097E1AC.5080806@gmail.com>
References: <1351783082-11411-1-git-send-email-panto@antoniou-consulting.com>
 <20121031175219.GH12739@atomide.com>
 <C9715CB7-D3E2-4CA7-8A93-2B10E8B70640@antoniou-consulting.com>
 <20121031180935.GL12739@atomide.com> <50918223.6080003@ti.com>
 <8AD2F7AF-8315-442B-A394-1A38DAB29F52@antoniou-consulting.com>
 <20121031212639.GQ12739@atomide.com>
 <8B058B00-6C21-4410-A24B-75651D49F6EC@antoniou-consulting.com>
 <20121031221402.GA29490@arwen.pp.htv.fi>
 <E4EE0D1F-C7AC-4620-86F2-D9C7C56E279F@antoniou-consulting.com>
 <50924DA3.1060901@ti.com>
 <F49CA12D-4DAC-4293-AD4D-FC7EDCEA6993@antoniou-consulting.com>
 <50925C49.7060004@ti.com>
 <CBDE21C5-1980-4BDC-9153-7653A07D0024@dominion.thruhere.net>
 <50938108.5040507@ti.com>
 <40797D3D-D62C-4E15-B0DF-75636C1637EE@antoniou-consulting.com>
 <CACxGe6s8qrP0itLgCyv1mBnekc-7K1n_q-kTKUR=MOJ57W_a1w@mail.gmail.com>
 <C9F4DFD1-4BF4-423C-B749-74E37D51192A@antoniou-consulting.com>
 <CACxGe6ubcRqDEGyRbNmwvAMGg5ujAKvPRWe9Vmd9tiHeB7=qNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CACxGe6ubcRqDEGyRbNmwvAMGg5ujAKvPRWe9Vmd9tiHeB7=qNw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/05/2012 08:34 AM, Grant Likely wrote:
> On Mon, Nov 5, 2012 at 1:25 PM, Pantelis Antoniou
> <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org> wrote:
>>
>> On Nov 5, 2012, at 1:22 AM, Grant Likely wrote:
>>
>>> On Fri, Nov 2, 2012 at 8:43 AM, Pantelis Antoniou
>>> <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org> wrote:
>>>> Assuming that we do work on a DT object format, and that the runtime resolution mechanism is approved,
>>>> then I agree that this part of the capebus patches can be dropped and the functionality assumed by generic
>>>> DT core.
>>>>
>>>> The question is that this will take time, with no guarantees that this would be acceptable from
>>>> the device tree maintainers. So I am putting them in the CC list, to see what they think about it.
>>>
>>> This is actually exactly the direction I want to go with DT, which the
>>> ability to load supplemental DT data blobs from either a kernel module
>>> or userspace using the firmware loading infrastructure.
>>>
>>> g.
>>
>> Hi Grant,
>>
>> That's pretty much our use case.
>>
>> Regards
> 
> Good. I'm about 80% though putting together a project plan of what is
> required to implement this. I'll post it for RFC shortly. I would
> appreciate feedback and help on flushing out the design.

The FPGA folks are also interested in dynamic DT configuration. There's
been some discussion and postings on the DT list in the last few months
you may have missed. It's maybe not completely the same use case, but
there is some overlap here.

Rob
