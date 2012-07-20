From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC 3/4] ARM: OMAP: powerdomain: Add .power_on/.power_down hooks
 for powerdomains
Date: Fri, 20 Jul 2012 12:56:41 +0530
Message-ID: <CAMQu2gw8NviFfB6gVd=jOB5WttzzArCx2TuH_+8MbFf0SVz3rA@mail.gmail.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com> <1342764284-8143-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:48057 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751681Ab2GTH1D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jul 2012 03:27:03 -0400
Received: by qabg1 with SMTP id g1so55530qab.20
        for <linux-omap@vger.kernel.org>; Fri, 20 Jul 2012 00:27:01 -0700 (PDT)
In-Reply-To: <1342764284-8143-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, t-kristo@ti.com

On Fri, Jul 20, 2012 at 11:34 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> With usecounting added to Powerdomains, its now possible to track Powerdomain
> transitions, including when a Powerdomain is turned on and turned down.
> Add support for hooking up callbacks for such events, which can be used to
> do things like context save/restore etc. which today is mostly stuffed within
> CPUidle and Suspend code.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
Agree.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
