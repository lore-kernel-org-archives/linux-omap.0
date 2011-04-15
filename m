From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v2] OMAP: iovmm: fix SW flags passed by user
Date: Fri, 15 Apr 2011 10:49:42 -0500
Message-ID: <BANLkTin=br7Yw39fnhXbLQg-Wgzym1BXJw@mail.gmail.com>
References: <1301083471-11284-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:34026 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751096Ab1DOPtp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Apr 2011 11:49:45 -0400
Received: by mail-wy0-f169.google.com with SMTP id 19so2560098wyf.28
        for <linux-omap@vger.kernel.org>; Fri, 15 Apr 2011 08:49:43 -0700 (PDT)
In-Reply-To: <1301083471-11284-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Omar Ramirez Luna <omar.ramirez@ti.com>, David Cohen <dacohen@gmail.com>, l-o <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Hi Hiroshi,

On Fri, Mar 25, 2011 at 3:04 PM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> Commit d038aee24dcd5a2a0d8547f5396f67ae9698ac8e
> "omap: iovmm: don't check 'da' to set IOVMF_DA_FIXED flag",
> changes iovmm to receive flags specified by user, however
> the upper 16 bits of the flags are wiped by iovmm itself.
>
> This fixes IOVMF_DA_FIXED flags from being lost, and lets the user
> map its desired "device addresses".
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
>
> v2:
> Include missing reference (commit and name) to patch in
> description.

If no comments, could you ack this patch?

Regards,

Omar
