From: argon design <argondsgn@gmail.com>
Subject: Corrupted LCML messages using DSP Bridge on Gumstix
Date: Fri, 10 Dec 2010 20:34:39 +0000
Message-ID: <AANLkTi=myvoTSqKZCOn4f-qbp9zgWuE7=pAdhkDy13Ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58280 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756848Ab0LJUel (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Dec 2010 15:34:41 -0500
Received: by wwa36 with SMTP id 36so4152345wwa.1
        for <linux-omap@vger.kernel.org>; Fri, 10 Dec 2010 12:34:40 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

BACKGROUND
I am running the RLS25.INC2.6 Zoom release configured for board_overo
on a Overo Water Gumstix module (contains a 3530 chip).

I have got the RLS25.12 binaries from TI's website
(https://gforge.ti.com/gf/project/openmax/frs/) and these work fine
for decoding video (via pvplayer_engine_test).

Now I am trying to use some third party video codecs (from Ittiam) but
some of the messages sent over DSP bridge seem to get corrupted.

The library uses the LCML (I believe this stands for Linux Common
Multimedia layer?) QueueBuffer function to pass an output buffer.
On the ARM side (inside the dsp/bridge kernel driver) I can see non
zero values being passed in for the address and length of the buffer,
but on the DSP side the error messages suggest that the received
values are 0.
This happens for the first output buffer.
Later messages do seem to get passed correctly so it feels as if it is
basically working but there is some oddness in the message passing
code.

I get the same results if I use the baseimage.dof and usn.dll64P from
the RLS25.14M3 TI binaries.

QUESTIONS
1) Is it valid to try to use DSP Bridge from RLS25.INC2.6 for the 3530
chip?  (I understand that the INC2 releases are meant for the 3630 but
I don't know of any reason why they wouldn't also work for 3530)
2) Which version of the TI binaries go with RLS25.INC2.6?
3) Has anyone any idea why the output buffer messages are getting corrupted?

I'm not really looking for debugging help (unless someone knows a
really revealing experiment that only involves code change on the ARM
side) but I am just hoping that someone may have seen a similar
problem before.
I'm new to the whole DSP bridge area so I am sure I have just made a
really stupid mistake somewhere but I can't think where,

Thanks (and many apologies if I haven't picked the right mailing list!),

Peter
