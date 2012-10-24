From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Beagleboard xM - play video file : BUG: scheduling while atomic:
 queue1:src/92/0x0000008e , then kernel panic
Date: Wed, 24 Oct 2012 17:52:56 +0200
Message-ID: <CAMP44s3LPq5zSwuxd7ffB_WLeNgZOEFKG=kqipTdPdFKokWazw@mail.gmail.com>
References: <7fad4160-e437-4ea3-b140-4c98a04045f4@googlegroups.com>
	<8d3b5995-b3f7-406b-9172-b3187922dc75@googlegroups.com>
	<CAMP44s2JnoYHN0a-DQCnj-mtGbZK8q7iFBDFR4MQ4L0-n7DYPw@mail.gmail.com>
	<01a2f6b7-ee81-4653-b5f3-a53def9301ca@googlegroups.com>
	<1f842c9c-41cc-415f-ac31-30c85c7f6563@googlegroups.com>
	<CAMP44s137rkBirwX5smMLUnZe6eS0qft0RzO3=vNoDxKpZE_RQ@mail.gmail.com>
	<7948d053-29ae-47fe-9f45-7fb86e534610@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47068 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab2JXPw5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 11:52:57 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so578732obb.19
        for <linux-omap@vger.kernel.org>; Wed, 24 Oct 2012 08:52:56 -0700 (PDT)
In-Reply-To: <7948d053-29ae-47fe-9f45-7fb86e534610@googlegroups.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Selso Liberado <selso.liberado@gmail.com>
Cc: gst-dsp@googlegroups.com, linux-omap@vger.kernel.org, Omar Ramirez Luna <or.rmz1@gmail.com>

On Wed, Oct 24, 2012 at 5:49 PM, Selso Liberado
<selso.liberado@gmail.com> wrote:

> I wished that someone agreed to mail him about this.
> Is the mailing list your talking about is located with this url ?
> http://linux.omap.com/mailman/listinfo

Yes, they are in CC now.

> I did also work with the linux-omap tree repo, and may repeat the test with
> this one.

It should work with a vanilla kernel. I think you might have better
luck with older kernels, 3.2, or maybe even 3.0. I don't recall the
last one I tried, but it was working fine.

Cheers.

-- 
Felipe Contreras
