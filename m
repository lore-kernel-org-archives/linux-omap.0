From: Suman Anna <s-anna@ti.com>
Subject: Re: Enabling IPU on OMAP44xx
Date: Fri, 24 Apr 2015 18:11:53 -0500
Message-ID: <553ACDB9.6000508@ti.com>
References: <553A6D80.1080307@communistcode.co.uk> <553A8CBE.7010505@ti.com> <553A998C.7060508@eumx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55141 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932462AbbDXXMC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Apr 2015 19:12:02 -0400
In-Reply-To: <553A998C.7060508@eumx.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jack Mitchell <jack.mitchell@eumx.net>, "Menon, Nishanth" <nm@ti.com>, Jack Mitchell <ml@communistcode.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Jack,

> On 24/04/15 19:34, Nishanth Menon wrote:
>> On 04/24/2015 11:21 AM, Jack Mitchell wrote:
>>> I've been fighting for a week with trying to get the IPU booted over
>>> remoteproc on an OMAP4470. I feel like I've got most of the way there
>> we do not have support for OMAP4470 on git.kernel.org.
>>
>> If you are interested in TI vendor kernel support, please use e2e.ti.com.
>>
>> ...
>>
> 
> Hi Nishanth,
> 
> I understand; and booting an omap4470 isn't the issue, I've hacked in 
> the support for booting it as it's basically the same as 4460; which is 
> supported. It's the IPU that I'm trying to get working, which is the 
> same across all the 44xx omap SoCs, right? I'm using the latest mainline 
> and the logs I posted are from the git HEAD early this morning.
> 
> I'm not looking for offical support, just pointers to people who may 
> have been using mainline and the IPU, the support seems to be in there 
> but none of the plumbing so I assume someone is probably using it 
> otherwise it's dead code.

Yeah, these are indeed used downstream in the TI product kernels, and
it's just that adding the support for them has been progressing slowly
upstream.

There are couple of things that are wrong with your minimal patch,
things that stand out
1. omap_ctrl_write_dsp_boot_addr is for DSP, not for IPU, so you need
not set that.
2. omap_device_enable is not enough to release the processor resets in
general, you can check the PRCM RSTCTRL registers, my bet is the
processor is still in reset.
3. You also need to have an associated CMA pool with the remoteproc, and
the CMA start address needs to match to that of your resource table,
atleast with the current firmware images.

In anycase, to be closer to use mainline sources, you would want to
create a DT-based remoteproc device and not legacy style platform
device. The mailbox and IOMMU support are converted to DT and should
support OMAP4 in mainline already.

FYI, you may want to look at the following TI trees,
http://git.ti.com/gitweb/?p=rpmsg/rpmsg.git;a=shortlog;h=refs/heads/rpmsg-ti-linux-3.14.y
(integrated remoteproc with rpmsg)
or just
http://git.ti.com/gitweb/?p=rpmsg/remoteproc.git;a=shortlog;h=refs/heads/rproc-linux-3.14.y
(remoteproc without any rpmsg pieces)

Those should boot on OMAP4, OMAP5 and DRA7 platforms provided you have
the firmwares with appropriate resource tables.

regards
Suman

