From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v5 1/4] remoteproc: introduce rproc_get_by_phandle API
Date: Thu, 18 Jun 2015 11:01:21 -0500
Message-ID: <5582EB51.8010406@ti.com>
References: <1432327530-48032-2-git-send-email-d-gerlach@ti.com> <1434566762-40702-1-git-send-email-d-gerlach@ti.com> <CAK=Wgbb1e6O574Bpicy4Y623vtiigauT22H-zk+JXGCz070i5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=Wgbb1e6O574Bpicy4Y623vtiigauT22H-zk+JXGCz070i5g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Ohad,
On 06/18/2015 04:04 AM, Ohad Ben-Cohen wrote:
> Hi Dave,
> 
> On Wed, Jun 17, 2015 at 9:46 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
>> Allow users of remoteproc the ability to get a handle to an rproc by
>> passing a phandle supplied in the user's device tree node. This is
>> useful in situations that require manual booting of the rproc.
>>
>> This patch uses the code removed by commit 40e575b1d0b3 ("remoteproc:
>> remove the get_by_name/put API") for the ref counting but is modified
>> to use a simple list and locking mechanism and has rproc_get_by_name
>> replaced with an rproc_get_by_phandle API.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>> v4->v5: Fixed build error from of_find_node_by_phandle when !CONFIG_OF
>>         based on offline discussion.
> 
> We can't rebase our for-next branch, so I've applied a
> similar fix in a separate patch.
> 
> Please check our for-next branch to make sure things still work for you.
> 

Oh sorry about. Pulled your for-next, tried it out, everything looks good to me,
thanks!

Regards,
Dave

> Thanks,
> Ohad.
> 
