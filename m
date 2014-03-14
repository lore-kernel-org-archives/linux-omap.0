From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH v4 08/14] v4l: ti-vpe: Rename csc memory resource name
Date: Fri, 14 Mar 2014 11:48:16 +0530
Message-ID: <53229F28.8060900@ti.com>
References: <1394526833-24805-1-git-send-email-archit@ti.com> <1394711056-10878-1-git-send-email-archit@ti.com> <1394711056-10878-9-git-send-email-archit@ti.com> <000f01cf3eca$b947cc80$2bd76580$%debski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <000f01cf3eca$b947cc80$2bd76580$%debski@samsung.com>
Sender: linux-media-owner@vger.kernel.org
To: Kamil Debski <k.debski@samsung.com>, hverkuil@xs4all.nl
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Kamil,

On Thursday 13 March 2014 08:14 PM, Kamil Debski wrote:
> Hi,
>
>> From: Archit Taneja [mailto:archit@ti.com]
>> Sent: Thursday, March 13, 2014 12:44 PM
>>
>> Rename the memory block resource "vpe_csc" to "csc" since it also
>> exists within the VIP IP block. This would make the name more generic,
>> and both VPE and VIP DT nodes in the future can use it.
>
> I understand that this is not yet used in any public dts files. Right?
>
> Best wishes,
>

Yes, a VPE DT node doesn't exist in any public dts files yet. So it's 
safe to change the name.

It should eventually come in dra7.dtsi. There is a dependency on a 
crossbar IP module, which provides us with an IRQ line for VPE going to 
the GIC. Once that is merged, I can add the VPE DT node.

Thanks,
Archit
