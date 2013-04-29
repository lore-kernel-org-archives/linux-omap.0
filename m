From: Mats Liljegren <liljegren.mats2@gmail.com>
Subject: Re: [meta-ti] Full nohz on TCI6638k2k (KeyStone II)
Date: Mon, 29 Apr 2013 09:52:39 +0200
Message-ID: <CA+xJJ1-bns9yGh1=zgTXn7cNivx9oL4evqN=9HN73kuq_-D3mw@mail.gmail.com>
References: <CA+xJJ18wBM7G=Nt12yMX8KLmTZWS+SnBsXb3F4X1xgq=Y=0y0w@mail.gmail.com>
	<517AA0FE.4080005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:43627 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142Ab3D2Hwl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Apr 2013 03:52:41 -0400
Received: by mail-ee0-f41.google.com with SMTP id c50so2213691eek.28
        for <linux-omap@vger.kernel.org>; Mon, 29 Apr 2013 00:52:39 -0700 (PDT)
In-Reply-To: <517AA0FE.4080005@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: William Mills <wmills@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, meta-ti <meta-ti@yoctoproject.org>, Muralidharan Karicheri <m-karicheri2@ti.com>

On Fri, Apr 26, 2013 at 5:45 PM, William Mills <wmills@ti.com> wrote:
> On 04/26/2013 03:06 AM, Mats Liljegren wrote:
>>
>> I would like to perform a customer demo running a benchmark
>> application in full nohz mode on TCI6638k2k target, which as far as I
>> understand it is a KeyStone II architecture.
>>
>> Does anyone know what the best Linux source code is to perform the
>> nohz port for this board? It should preferably be Linux 3.9 of any RC
>> level, but 3.8 should work as well.
>>
>> I also need a hardware timer to be used as an interrupt source for the
>> interrupt latency measurements. Any suggestions for framework or
>> driver to use?
>>
>
> Mats,
>
> The team is just now rebasing the bringup work on 3.8.4.  You can find their
> work here:
> http://arago-project.org/git/projects/?p=linux-keystone.git;a=shortlog;h=refs/heads/release-server/master
>
> (The word "server" ~= 3.8 for this archive)
>
> Please note that all the master branches are rebuilt from the feature
> branches in the nightly build script.  I think the feature branches get
> rebased also.  The tags of course you can count on.
>
> The A15's use the per-core archetecture timer normally.  However the SOC has
> multiple (20) Timer64 peripherals that can be used as well if they are not
> being used by the DSPs.  If you configure which timer64 to use w/ device
> tree you should be fine.
>
> Bill

Thanks! I'll check it out.

/Mats
