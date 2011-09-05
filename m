From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 00/10]HDMI: Split hdmi.c in DSS to seperate OMAP
 dependent
Date: Mon, 05 Sep 2011 13:41:15 +0300
Message-ID: <1315219275.3214.21.camel@deskari>
References: <1314960470-2616-1-git-send-email-mythripk@ti.com>
	 <1315208420.2130.31.camel@deskari>
	 <CAP5A+B8+f8mnFPAOJ8E5HX-5AbSRPwicHSEaDke8s9tQ0Fj0KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:56088 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752362Ab1IEKlU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 06:41:20 -0400
Received: by bkbzv3 with SMTP id zv3so4558910bkb.4
        for <linux-omap@vger.kernel.org>; Mon, 05 Sep 2011 03:41:18 -0700 (PDT)
In-Reply-To: <CAP5A+B8+f8mnFPAOJ8E5HX-5AbSRPwicHSEaDke8s9tQ0Fj0KA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, 2011-09-05 at 16:05 +0530, K, Mythri P wrote:
> Hi,
> 
> On Mon, Sep 5, 2011 at 1:10 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Fri, 2011-09-02 at 16:17 +0530, mythripk@ti.com wrote:
> >> From: Mythri P K <mythripk@ti.com>
> >>
> >> HDMI IP block is common between TI OMAP4 Procerssor and Netra processor although
> >> the Display subsytem is different.Also the IP block in future OMAP may differ
> >> from the one existing in OMAP4. Thus to reuse the code between these two
> >> processors , and maintain the multi omap build functionality in DSS.
> >> HDMI IP dependant code is seperated out from hdmi.c and moved to
> >> new library file hdmi_ti_4xxx_ip.c.From the DSS dependent HDMI code only the
> >> function pointer to functionality/features offered by HDMI is called.
> >>
> >> This patch series does the split and also renames hdmi_omap4_panel.c to
> >> hdmi_panel.c as that file has nothing specific to OMAP4 and can be reused for
> >> other OMAP family of processors as well.
> >>
> >> This patch series is based on Tomi's LO-DSS2 master branch.
> >>
> >> changes since
> >> V2: Rename certain files/function to have standard format and handle scenario
> >> when hdmi is disabled.
> >> V1: Function pointer approach to call the HDMI IP functions from DSS HDMI
> >
> I guess i shall change the description , it is changes since , so v2
> would be actually changes since v2 to v3.

Ah, my mistake, I didn't read it carefully. I expected the change log to
be missing as there was only one change note, and there were other
things changed also in this version.

So I'll change my comment to:

It'd be nice to list most (if not all) of the changes made, so it's
easier for the reviewers to see that their comments were applied into
this version.

 Tomi


