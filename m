From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v3 2/4] ARM: OMAP2+: Introduce check for OP-TEE in
 omap_secure_init()
Date: Thu, 2 Jan 2020 12:24:39 -0500
Message-ID: <d9dddbe0-f5c3-1413-8b27-d19e8e07f755@ti.com>
References: <20191230185004.32279-1-afd@ti.com>
 <20191230185004.32279-3-afd@ti.com>
 <b4773b91-9893-830d-7b1b-b63eb4077cf7@ti.com>
 <d7d6f381-be00-3072-0510-a18b736987e7@ti.com>
 <20200102171403.GC16702@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200102171403.GC16702@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 1/2/20 12:14 PM, Tony Lindgren wrote:
> * Andrew F. Davis <afd@ti.com> [191231 14:16]:
>> On 12/31/19 1:32 AM, Lokesh Vutla wrote:
>>> This doesn't guarantee that optee driver is probed successfully or firmware
>>> installed correctly. Isn't there a better way to detect? Doesn't tee core layer
>>> exposes anything?
>>
>> We don't actually need the kernel-side OP-TEE driver at all here, we are
>> making raw SMCCC calls which get handled by OP-TEE using platform
>> specific code then emulates the function previously handled by ROM[0]
>> and execution is returned. No driver involved for these types of calls.
>>
>> U-Boot will not add this node to the DT unless OP-TEE is installed
>> correctly, but you are right that is no perfect guarantee. OP-TEE's
>> kernel driver does do a handshake to verify it is working but this is
>> not exposed outside of that driver and happens *way* too late for our
>> uses here. Plus as above, we don't need the OP-TEE driver at all and we
>> should boot the same without it even enabled.
>>
>> So my opinion is that if DT says OP-TEE is installed, but it is not,
>> then that is a misconfiguration and we usually just have to trust DT for
>> most things. If DT is wrong here then the only thing that happens is
>> this call safely fails, a message is printed informing the user of the
>> problem, and kernel keeps booting (although probably not stable given we
>> need these calls for important system configuration).
> 
> OK, please add comments to omap_optee_init_check(), it's not obvious
> to anybody not dealing with optee directly.
> 


Okay, will add this comment and the one suggested by Lokesh for v4.

Andrew


> Regards,
> 
> Tony
> 
