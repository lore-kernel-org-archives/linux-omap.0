From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [RFC] ARM: OMAP: hwmod: wait for sysreset complete after enabling hwmod
Date: Tue, 23 Oct 2012 23:20:45 +0530
Message-ID: <CAM=Q2ctG2Q8o9g7QZEF_uPM+XYXk2tPim-k4Wx7YJzzJHNhVTw@mail.gmail.com>
References: <1350922532-26338-1-git-send-email-t-kristo@ti.com>
	<87zk3edvti.fsf@deeprootsystems.com>
	<CAM=Q2cvLc63tGMG1t1wguiMHqNxcrZ60GF+fHjxc6_8c7rBykw@mail.gmail.com>
	<87k3uhb26c.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55903 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755017Ab2JWRuq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 13:50:46 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so5699048iea.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 10:50:45 -0700 (PDT)
In-Reply-To: <87k3uhb26c.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Venkatraman S <svenkatr@ti.com>

On Tue, Oct 23, 2012 at 9:39 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Shubhrajyoti Datta <omaplinuxkernel@gmail.com> writes:
[...]
>
> Could you please explain what worked and didn't work on each platforms?
>
> Also, which 3430 did you test on?  If it's SDP, then it has a UART1
> console, correct?
idle mode

set autosuspend for uart
sleep

off count didnt increment on 3430sdp.

hope not hitting any setup at my end.

>
> Kevin
