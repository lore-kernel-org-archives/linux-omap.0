From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH v3 09/10] OMAP4: DSS2: HDMI: Function pointer approach to call
Date: Mon, 5 Sep 2011 11:10:46 +0530
Message-ID: <CAB2ybb9ZgEuPM-mh2HJtDQ4L871Ts5+YCqv_kP+mSw+sw6xtbw@mail.gmail.com>
References: <1314960470-2616-1-git-send-email-mythripk@ti.com>
 <1314960470-2616-2-git-send-email-mythripk@ti.com> <1314960470-2616-3-git-send-email-mythripk@ti.com>
 <1314960470-2616-4-git-send-email-mythripk@ti.com> <1314960470-2616-5-git-send-email-mythripk@ti.com>
 <1314960470-2616-6-git-send-email-mythripk@ti.com> <1314960470-2616-7-git-send-email-mythripk@ti.com>
 <1314960470-2616-8-git-send-email-mythripk@ti.com> <1314960470-2616-9-git-send-email-mythripk@ti.com>
 <1314960470-2616-10-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:46737 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751191Ab1IEFlH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Sep 2011 01:41:07 -0400
Received: by mail-gx0-f176.google.com with SMTP id 7so3708277gxk.7
        for <linux-omap@vger.kernel.org>; Sun, 04 Sep 2011 22:41:06 -0700 (PDT)
In-Reply-To: <1314960470-2616-10-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org

On Fri, Sep 2, 2011 at 4:17 PM,  <mythripk@ti.com> wrote:
> From: Mythri P K <mythripk@ti.com>
<snip>
> + =A0 =A0 =A0 hdmi.hdmi_data.ops->video_enable(&hdmi.hdmi_data, 0);
Still too much of 'hdmi' in this line - maybe you can just replace
hdmi_data w/ data (like you did for hdmi_ops w/ ops)?
<snip>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
