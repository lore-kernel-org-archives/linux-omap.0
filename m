From: Rebecca Schultz Zavin <rebecca@android.com>
Subject: Fwd: dss2 and dsi
Date: Wed, 29 Apr 2009 10:26:59 -0700
Message-ID: <aed62de90904291026t6c18908ax86abfb8343f68a0e@mail.gmail.com>
References: <aed62de90904291024s3b90dae5v742c72c4b8bdbe3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:15409 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbZD2R2N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Apr 2009 13:28:13 -0400
Received: from wpaz37.hot.corp.google.com (wpaz37.hot.corp.google.com [172.24.198.101])
	by smtp-out.google.com with ESMTP id n3THR12X012408
	for <linux-omap@vger.kernel.org>; Wed, 29 Apr 2009 18:27:07 +0100
Received: from qw-out-2122.google.com (qwe3.prod.google.com [10.241.194.3])
	by wpaz37.hot.corp.google.com with ESMTP id n3THQxSg026539
	for <linux-omap@vger.kernel.org>; Wed, 29 Apr 2009 10:27:00 -0700
Received: by qw-out-2122.google.com with SMTP id 3so1343280qwe.31
        for <linux-omap@vger.kernel.org>; Wed, 29 Apr 2009 10:26:59 -0700 (PDT)
In-Reply-To: <aed62de90904291024s3b90dae5v742c72c4b8bdbe3@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I have a question on the intended use of pan_display v. the
update_window ioctl in dss2. =A0I'm using a dsi panel and it seems like
the only way I can get new data out to the display is by calling
display->update. =A0The only place that seems to be called is from a
couple of the ioctls, mainly update_window. =A0Is the intention that yo=
u
use update_window to compose the screen? =A0Android uses pan_display to
flip between a front and back copy of the frame buffer, and if it's
available on the hardware, to send a partial update. =A0On the dss2
framework those calls never cause anything to be sent to the dsi
panel. =A0Should we be calling the update_window ioctl?


Rebecca
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
