From: Amit Virdi <amitvi128-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] usb: dwc3: gadget: Stop TRB preparation after limit
 is reached
Date: Mon, 29 Dec 2014 12:05:57 +0530
Message-ID: <CAEOkp447UBzCRfmCO1yy1_k4N40L_TsfbrCpoLXd=Wmav8JROg@mail.gmail.com>
References: <cover.1418972323.git.amit.virdi@st.com>
	<995bc6a5f9abd9a41f7229aafd1c2978b526783b.1418972323.git.amit.virdi@st.com>
	<20141222160626.GD12815@saruman>
	<CAEOkp44o-a1Onxwxp6rRZvN+vgWhALiNf=Z5FbRtyrOW2JWx=Q@mail.gmail.com>
	<20141227174628.GB17608@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141227174628.GB17608@saruman>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Amit Virdi <amit.virdi-qxv4g6HH51o@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pratyush Anand Thakur <pratyush.anand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ajay.khandelwal-qxv4g6HH51o@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sat, Dec 27, 2014 at 11:16 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Sat, Dec 27, 2014 at 01:24:03PM +0530, Amit Virdi wrote:
>> On Mon, Dec 22, 2014 at 9:36 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
>> > On Fri, Dec 19, 2014 at 12:40:16PM +0530, Amit Virdi wrote:
>> >> When SG is used, there are two loops iterating to prepare TRBs:
>> >>  - Outer loop over the request_list
>> >>  - Inner loop over the SG list
>> >>
>> >> The driver must stop preparing TRBs when the max TRBs have been prepared. The
>> >> code was missing break to get out of the outer loop.
>> >>
>> >> Signed-off-by: Amit Virdi <amit.virdi-qxv4g6HH51o@public.gmane.org>
>> >
>> > which bug is this fixing ? Which kernels are affected ? This need to be
>> > backported to which kernel ? Which commit introduced this bug ? How can
>> > I validate this to be a valid fix ?
>> >
>>
>> Problem description:
>> DWC3 gadget sets up a pool of 32 TRBs for each EP during
>> initialization. This means, the max TRBs that can be submitted for an
>> EP is fixed to 32. Since the request queue for an EP is a linked list,
>> any number of requests can be queued to it by the gadget layer.
>> However, the dwc3 driver must not submit TRBs more than the pool it
>> has created for. This limit wasn't respected when SG was used
>> resulting in submitting more than the max TRBs, eventually leading to
>> non-transfer of the TRBs submitted over the max limit.
>
> this would become a much, much better commit log than the one you
> provided. It's a much more verbose description of the issue.
>

Okay, I'll edit the commit message.

>> Commit that introduced this bug:
>> This bug is present from the day support for sg list was added to dwc3
>> gadget., i.e. since commit eeb720fb21d61dfc3aac780e721150998ef603af
>> ("usb: dwc3: gadget: add support for SG lists") - kernel version
>> v3.2-rc7, hence v3.2
>>
>> Kernels affected:
>> It is best to backport this fix to kernel v3.8+ as there were many
>> enhancements/bug fixes from v3.2..v3.8
>>
>> Generic setup to reproduce/test this fix:
>> This bug is reproduced whenever the number of TRBs that need to be
>> submitted to the hardware from the software queue (request_list)
>> becomes more than 32 on bulk endpoint. eg. if num_mapped_sgs is 2 and
>> the request_list has 17 entries (hence, 34 potential TRBs), the
>> scenario is reproduced.
>>
>> My setup details:
>> For reproducing and testing the patches [1/4 and 2/4], I used an
>> inhouse developed user space application that run on device side. This
>> user space application interacts with the customized uvc webcam gadget
>> to submit the video data to the DWC3 driver. The host side was running
>> standard webcam application (cheese).
>
> oh, so this is something I can't easily reproduce myself. Then I'll need
> full boot logs, register dump and full trace output of dwc3 running and
> exhibiting the problem. Also, make sure you use either v3.18 or v3.19rc1
> to validate your changes.
>

[Quoting you from the thread of patch 1/4]

>> endpoint. Following is the log snippet once this bug is reproduced:
>> ----
>> dwc3 dwc3.0: ep2in-bulk: Transfer Not Ready
>> dwc3 dwc3.0: queing request 24cc5780 to ep2in-bulk length 960002
>> dwc3 dwc3.0: ep2in-bulk: req 24cc5780 dma 24eb6400 length 2 chain
>> dwc3 dwc3.0: ep2in-bulk: req 24cc5780 dma 25901800 length 960000
>> dwc3 dwc3.0: queing request 24cc5000 to ep2in-bulk length 960002
>> dwc3 dwc3.0: ep2in-bulk: Transfer Not Ready
>> dwc3 dwc3.0: queing request 24cc5900 to ep2in-bulk length 960002
>> -----
>>
>> Without this fix, the hardware never generates "Transfer Complete"
>> event for the corresponding EP and goes into an unknown state.
>
> whiuch kernel are you using to develop this ? Most of these messages
> don't exist anymore with v3.19-rc because I have converted them into
> tracepoints, considering you're showing me logs with these messages,
> this tells me that you're sending me a patch developed/tested against a
> kernel older than v3.18. I need to see full bootup logs, a register dump
> (/sys/kernel/debug/*dwc3*/regdump) and a much larger debugging log from
> dwc3 in order to accept patches from you. Sorry, but I cannot take
> patches which were not tested against, at a minimum, the latest major
> release.
>

Yes you're right that both the fixes [1/4] and [2/4] have only been
build tested with the latest kernel. I should have mentioned this
information in the commit message or the cover-letter itself.

The only reason why I have not been able to test these fixes on the
latest is because the customized webcam gadget is not ported on the
latest kernel. There have been a lot of changes in the video framework
lately and that is not my area of expertise. So porting the customized
webcam gadget to latest kernel and testing these fixes is not feasible
for me.

Having said all this, the fact remains that these are bugs in the dwc3
driver from kernel v3.9 onwards. The log messages clearly depict this.
These bugs are obviously present till date.

I ask you to give a more deeper thought on the whole situation and not
undermine the importance of code review.
 - [Patch 2/4] fixes a bug that could have been found in the code review.
 - [Patch 1/4] fixes a bug which was very very subtle but a deeper
code review can certainly boost the confidence about the change made.
list_is_last won't work when SG is used because, for the last request
in the request_list, the TRB for the first sg entry modifies the
list's next and prev pointers while moving the URB to req_queued.

I can certainly provide the dwc3 specific kernel bootup logs, full
regdump and any loglevel you want me to, if that helps
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
