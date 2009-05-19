From: twebb <taliaferro62@gmail.com>
Subject: Re: how to configure android-2.6.27 kernel for an LCD display other
	than Zoom2 display
Date: Tue, 19 May 2009 08:17:53 -0400
Message-ID: <dbdb2ea60905190517l6fa9f495mc879417bab6f1800@mail.gmail.com>
References: <dbdb2ea60905151218v4b5b3299vbc7583ccedf0fc63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:6255 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbZESMRx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 08:17:53 -0400
Received: by an-out-0708.google.com with SMTP id d40so11975897and.1
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 05:17:53 -0700 (PDT)
In-Reply-To: <dbdb2ea60905151218v4b5b3299vbc7583ccedf0fc63@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "omapandroid-discussion@omapzoom.org" <omapandroid-discussion@omapzoom.org>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Fri, May 15, 2009 at 3:18 PM, twebb <taliaferro62@gmail.com> wrote:
> I'm using the L25.6/android-2.6.27 kernel and am adapting it as
> necessary to OMAP3530-based hardware. =A0However, I don't see how to
> configure the kernel for an LCD display other than the NEC display
> defined for ZOOM2 (which is an SPI-based display?). =A0I'm using an L=
G
> display via the dss_data[17:0] interface of the 35xx - and this is
> working with a slightly modified version of lcd_omap3evm.c on the
> linux-omap-2.6.27-omap1 kernel. =A0I'm not familiar with the new DSS
> that appears to be in android-2.6.27.
>
> The LG display is WSVGA, but I'd be happy getting WVGA or VGA working
> on it for now. =A0How can I configure the kernel to support a
> non-SPI-based LCD panel? =A0How does this DSS differ with what appear=
s
> in android-2.6.29/drivers/video/omap2 ?
>
> Any help here would be appreciated.
>
> Thanks,
> twebb
>

Any suggestions on this?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
