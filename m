From: Amit Virdi <amitvi128@gmail.com>
Subject: Re: [PATCH 2/4] usb: dwc3: gadget: Stop TRB preparation after limit
 is reached
Date: Sat, 27 Dec 2014 13:24:03 +0530
Message-ID: <CAEOkp44o-a1Onxwxp6rRZvN+vgWhALiNf=Z5FbRtyrOW2JWx=Q@mail.gmail.com>
References: <cover.1418972323.git.amit.virdi@st.com>
	<995bc6a5f9abd9a41f7229aafd1c2978b526783b.1418972323.git.amit.virdi@st.com>
	<20141222160626.GD12815@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:41300 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbaL0HyF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Dec 2014 02:54:05 -0500
In-Reply-To: <20141222160626.GD12815@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Amit Virdi <amit.virdi@st.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org, pratyush.anand@gmail.com, ajay.khandelwal@st.com

On Mon, Dec 22, 2014 at 9:36 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, Dec 19, 2014 at 12:40:16PM +0530, Amit Virdi wrote:
>> When SG is used, there are two loops iterating to prepare TRBs:
>>  - Outer loop over the request_list
>>  - Inner loop over the SG list
>>
>> The driver must stop preparing TRBs when the max TRBs have been prepared. The
>> code was missing break to get out of the outer loop.
>>
>> Signed-off-by: Amit Virdi <amit.virdi@st.com>
>
> which bug is this fixing ? Which kernels are affected ? This need to be
> backported to which kernel ? Which commit introduced this bug ? How can
> I validate this to be a valid fix ?
>

Problem description:
DWC3 gadget sets up a pool of 32 TRBs for each EP during
initialization. This means, the max TRBs that can be submitted for an
EP is fixed to 32. Since the request queue for an EP is a linked list,
any number of requests can be queued to it by the gadget layer.
However, the dwc3 driver must not submit TRBs more than the pool it
has created for. This limit wasn't respected when SG was used
resulting in submitting more than the max TRBs, eventually leading to
non-transfer of the TRBs submitted over the max limit.

Commit that introduced this bug:
This bug is present from the day support for sg list was added to dwc3
gadget., i.e. since commit eeb720fb21d61dfc3aac780e721150998ef603af
("usb: dwc3: gadget: add support for SG lists") - kernel version
v3.2-rc7, hence v3.2

Kernels affected:
It is best to backport this fix to kernel v3.8+ as there were many
enhancements/bug fixes from v3.2..v3.8

Generic setup to reproduce/test this fix:
This bug is reproduced whenever the number of TRBs that need to be
submitted to the hardware from the software queue (request_list)
becomes more than 32 on bulk endpoint. eg. if num_mapped_sgs is 2 and
the request_list has 17 entries (hence, 34 potential TRBs), the
scenario is reproduced.

My setup details:
For reproducing and testing the patches [1/4 and 2/4], I used an
inhouse developed user space application that run on device side. This
user space application interacts with the customized uvc webcam gadget
to submit the video data to the DWC3 driver. The host side was running
standard webcam application (cheese).
