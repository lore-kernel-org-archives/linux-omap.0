From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCHv2] rpmsg: compute number of buffers to allocate from vrings
Date: Wed, 26 Nov 2014 16:30:49 -0600
Message-ID: <54765499.7080406@ti.com>
References: <1410892387-30596-1-git-send-email-s-anna@ti.com> <5464EE5C.8090904@ti.com> <CAK=Wgbb=u-GBo3JakZcrbO6xoOe=PWb3C50EJAXrpFJF3VraTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=Wgbb=u-GBo3JakZcrbO6xoOe=PWb3C50EJAXrpFJF3VraTQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Ohad,

>
> On Thu, Nov 13, 2014 at 7:46 PM, Suman Anna <s-anna@ti.com> wrote:
>> Hi Ohad,
>>
>> On 09/16/2014 01:33 PM, Suman Anna wrote:
>>> The buffers to be used for communication are allocated during the
>>> rpmsg virtio driver's probe, and the total number of buffers is
>>> currently hard-coded to 512. The vring configuration can vary from
>>> one platform to another or between different remote processors. The
>>> setup of the receive buffers will throw a WARN_ON if the associated
>>> vrings are configured with less than 256 buffers (in each direction).
>>> So, adjust this hard-coded value to rely on the number of buffers the
>>> virtqueue vring is setup with, but also limit to use 256 buffers at
>>> most in each direction to avoid wacky resource tables consuming up
>>> unreasonable memory.
>>>
>>> NOTE: The number of buffers is already assumed to be symmetrical
>>> in each direction, and that logic is not unchanged.
>>>
>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>> ---
>>> v2 changes:
>>> - add upper limit on buffers and update comments
>>> - revise patch description
>>
>> Any comments on this one, if not can you pick this up for 3.19?
> 
> Did some small changes - untested, not even compiled - can you please
> make sure it works for you?

Yep, I have reviewed and verified the changes, it is good to go.

Thanks,
Suman
