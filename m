From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/2] remoteproc: remove the now-redundant kref
Date: Mon, 04 Jun 2012 14:22:54 -0700
Message-ID: <4FCD272E.1020300@codeaurora.org>
References: <1338017791-9442-1-git-send-email-ohad@wizery.com> <1338017791-9442-2-git-send-email-ohad@wizery.com> <4FC5DD74.4030202@codeaurora.org> <CAK=WgbbwaMAnTGcivC9ZR8K-MtTqHAV3+BgUmk8WjCaayifJxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=WgbbwaMAnTGcivC9ZR8K-MtTqHAV3+BgUmk8WjCaayifJxw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fernando Guzman Lugo <fernando.lugo@ti.com>
List-Id: linux-omap@vger.kernel.org

On 05/30/12 05:38, Ohad Ben-Cohen wrote:
> On Wed, May 30, 2012 at 11:42 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>>> -     /* the rproc will only be released after its refcount drops to zero */
>>> -     kref_put(&rproc->refcount, rproc_release);
>>> +     /* unroll rproc_alloc. TODO: we may want to let the users do that */
>>> +     put_device(&rproc->dev);
>> Yes I think we want rproc_free() to actually call put_device() the last
>> time and free the resources.
> Yeah that was one of the options I considered.
>
> In general, we have three options here:
> 1. Remove this last put_device invocation, and require users to call
> rproc_free() even after they call rproc_unregister().
> 2. Let rproc_unregister() still do this, by calling rproc_free().
> 3. Let rproc_unregister() still do this, by invoking put_device().
>
> I think that (1) looks better since it makes the interface symmetric
> and straight forward.
>
> (2) and (3) may be simper because users only need to call
> rproc_unregister and that's it.
>
> I eventually decided against (1) because I was concerned it will only
> confuse users at this point.
>
> But if you think that (1) is nicer too then maybe we should go ahead
> and do that change.

Option 1 is nicer and it also follows the model other subsystems have
put forth such as the input subsystem.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
