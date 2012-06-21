From: Kevin Hilman <khilman@ti.com>
Subject: Re: MFD USB host: prevents CORE retention in idle
Date: Thu, 21 Jun 2012 11:32:52 -0700
Message-ID: <877gv04isr.fsf@ti.com>
References: <87zk8yxx9l.fsf@ti.com> <4FBD7FDC.9050307@ti.com>
	<CAP05o4KNnrKdmgJ=Ky=MS4pwEoEErH+Agkm2EwN1i1UDb-CbPQ@mail.gmail.com>
	<871um9wlzx.fsf@ti.com> <878vghut1u.fsf@ti.com>
	<4FCE46E7.60702@ti.com>
	<CAP05o4L+0E6fa1VoP_UPTJgKjXb-VqZorUfzsTB3d-KVoFrXfw@mail.gmail.com>
	<CAP05o4KuoQHhTRTCtdpiywgC1HjwzXZHhROKOgSLhoK76Z2aaQ@mail.gmail.com>
	<87fwa56gxp.fsf@ti.com>
	<CAP05o4JEEp-yXjijeeejN3j8uVBDQ35DMGqP9UKj3f7sNnO8LA@mail.gmail.com>
	<CAP05o4LYhFQpEFukyCT2fA7XHPU2L5K8=8W0fncMJk6YEUWdOQ@mail.gmail.com>
	<CAP05o4KaZ93Nt58h5ZccWeM2EazLtwOcV5rkmLvijuB5HRbJ8g@mail.gmail.com>
	<CAORVsuVpbgtS8+Jkw+Z2kA0k0SuL=kYRYcO3JRJ0D9LL34gH2Q@mail.gmail.com>
	<CAP05o4Kh+YVYgv_F-GZ=A0V+Nt=x4wCRwek81K7M=bT=PmyBGw@mail.gmail.com>
	<87mx3zji26.fsf@ti.com>
	<CAP05o4LKMJiHhu7f+dyhEHo5Up1PioCYgmn122vda5d5NfW5Uw@mail.gmail.com>
	<CAP05o4JET=htEeyOkpCDwLKeOSCT24+tNMF0dkE24VLH6s6uLQ@mail.gmail.com>
	<874nq6jc55.fsf@ti.com>
	<CAP05o4+Fcb0Xy_P8hrJ9=Vium_yCFA2mm+fy7nO2=nAsRpK5xQ@mail.gmail.com>
	<CANOLnOOAQiSfZCj1SuiXC5QYuBCwLPLmHDnHTG-pjZFvsdmAwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:37749 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755287Ab2FUSc5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jun 2012 14:32:57 -0400
Received: by dalf4 with SMTP id f4so2169824dal.1
        for <linux-omap@vger.kernel.org>; Thu, 21 Jun 2012 11:32:55 -0700 (PDT)
In-Reply-To: <CANOLnOOAQiSfZCj1SuiXC5QYuBCwLPLmHDnHTG-pjZFvsdmAwg@mail.gmail.com>
	(Grazvydas Ignotas's message of "Thu, 21 Jun 2012 13:47:10 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "Munegowda, Keshava" <keshava_mgowda@ti.com>, Jean Pihet <jean.pihet@newoldbits.com>, Ameya Palande <ameya.palande@ti.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org

Grazvydas Ignotas <notasas@gmail.com> writes:

> On Thu, Jun 21, 2012 at 10:12 AM, Munegowda, Keshava
> <keshava_mgowda@ti.com> wrote:
>> I did the clone of this , But I am not seeing the branch 'tmp/test/usb-host'
>> I am seeing only the branch /wip/arm-nohz-cpusets other than master.
>> I didn't any usb-host branch here too:
>> http://git.kernel.org/?p=linux/kernel/git/khilman/linux.git;a=summary
>
> It seems Kevin linked the wrong git tree, try this one:
> http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git

Oops, sorry.  

Grazvydas is right.  It's my linux-omap-pm tree that has this test
branch.

Kevin
