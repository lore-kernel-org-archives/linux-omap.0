From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 04/10] OMAP4: DSS: HDMI: Move the common header file
Date: Fri, 02 Sep 2011 08:24:03 +0300
Message-ID: <1314941043.1907.8.camel@deskari>
References: <1314598500-24005-1-git-send-email-mythripk@ti.com>
	 <1314598500-24005-2-git-send-email-mythripk@ti.com>
	 <1314598500-24005-3-git-send-email-mythripk@ti.com>
	 <1314598500-24005-4-git-send-email-mythripk@ti.com>
	 <1314598500-24005-5-git-send-email-mythripk@ti.com>
	 <1314867624.2169.21.camel@lappyti>
	 <CAP5A+B8j=6+a2m=Lpf0-G-arO9q2R_286=mHEv52qm4FiyWnZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:52597 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751406Ab1IBFYH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 01:24:07 -0400
Received: by mail-fx0-f48.google.com with SMTP id 7so1326850fxg.7
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 22:24:05 -0700 (PDT)
In-Reply-To: <CAP5A+B8j=6+a2m=Lpf0-G-arO9q2R_286=mHEv52qm4FiyWnZg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, 2011-09-02 at 10:45 +0530, K, Mythri P wrote:
> Hi,
> 
> On Thu, Sep 1, 2011 at 2:30 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Mon, 2011-08-29 at 11:44 +0530, mythripk@ti.com wrote:
> >> From: Mythri P K <mythripk@ti.com>
> >>
> >> Some of the header file definitions of HDMI IP are needed by audio driver thus
> >> moving the common defintion to more generic Include/video.
> >>
> >> Signed-off-by: Mythri P K <mythripk@ti.com>
> >> ---
> >>  drivers/video/omap2/dss/dss.h  |   10 -----
> >>  drivers/video/omap2/dss/hdmi.c |    1 +
> >>  drivers/video/omap2/dss/hdmi.h |   53 ------------------------
> >>  include/video/omaphdmi.h       |   86 ++++++++++++++++++++++++++++++++++++++++
> >>  4 files changed, 87 insertions(+), 63 deletions(-)
> >>  create mode 100644 include/video/omaphdmi.h
> >
> > As the functions will be renamed to hdmi_ti_4xxx_*, perhaps the header
> > file is a bit misnamed.
> >
> > Also, please first do the changes/renamings/etc, and only then move the
> > finished header file to include/video/ to prevent unnecessary changes in
> > include/video.
> >
> The Include/video hdmi header file is a generic file that can be used
> across 4 ,5 and Netra. Actually even the hdmi_ti_5xxx_ definitions
> would come in this header so what do you think it can be named as ? ,
> If you have any better name for hdmi_ti_4xxx_ip as well please suggest
> would be happy to take it , as it doesn't sound that intuitive to me
> as well.

Well, I think whatever the header name is, it should somehow match the
functions and the .c file. So if the functions and the .c file in this
case are hdmi_ti_4xxx, then it'd be logical for the .h file to be named
similarly.

So, if it will contain functions for other IPs also, perhaps just leave
the 4xxx out of it and name it hdmi_ti.h. Then the functions could be
named hdmi_ti_4xxx_yyy(), and accordingly the .c file can be
hdmi_ti_4xxx.c.

Or, perhaps ti_hdmi.h (and funcs & .c files accordingly) would be more
"standard", as it's quite usual to name drivers etc. starting with the
company name.

 Tomi


