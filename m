From: John Stultz <john.stultz@linaro.org>
Subject: Re: Minimum timing resolution in Ubuntu/Linaro on the PandaBoard ES
Date: Wed, 08 Feb 2012 09:05:02 -0800
Message-ID: <1328720702.8119.11.camel@js-netbook>
References: <4F31A91B.8080106@umich.edu> <4F32063F.1020607@linaro.org>
	 <51DAA6EF-1C3B-4964-8447-893D295E51A1@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:48215 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757331Ab2BHRGI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 12:06:08 -0500
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-omap@vger.kernel.org> from <john.stultz@linaro.org>;
	Wed, 8 Feb 2012 10:05:52 -0700
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com [9.17.195.107])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id A5E7C19D8052
	for <linux-omap@vger.kernel.org>; Wed,  8 Feb 2012 10:05:28 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q18H5FFK118044
	for <linux-omap@vger.kernel.org>; Wed, 8 Feb 2012 10:05:17 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q18H5ARH018869
	for <linux-omap@vger.kernel.org>; Wed, 8 Feb 2012 10:05:11 -0700
In-Reply-To: <51DAA6EF-1C3B-4964-8447-893D295E51A1@umich.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Richardson <chardson@umich.edu>
Cc: Dmitry Antipov <dmitry.antipov@linaro.org>, linaro-dev@lists.linaro.org, linux-omap@vger.kernel.org

On Wed, 2012-02-08 at 04:32 -0500, Andrew Richardson wrote:
> Ah, very interesting.

>         > dmesg | grep clock
>         [    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
>         [    0.000000] sched_clock: 32 bits at 32kHz, resolution
>         30517ns, wraps every 131071999ms

Hrm. So 30us is still much smaller then the 2.5ms you were seeing. So
that doesn't fully explain the behavior.

thanks
-john




