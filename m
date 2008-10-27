From: "iqbal shareef" <iqbalshareef.list@gmail.com>
Subject: omapzoom VRFB rotation contexts
Date: Mon, 27 Oct 2008 20:17:48 +0900
Message-ID: <c6a924220810270417q328d6230x75b8640c54bcd776@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:15229 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbYJ0LRu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Oct 2008 07:17:50 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1748597muf.1
        for <linux-omap@vger.kernel.org>; Mon, 27 Oct 2008 04:17:48 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

There are two VRFB contexts handled under STREAMON (omap24xxvout.c)
interface, Could someone explain why?

Is one for preview and the other for capture?

Why the buffer size(iw*ih*2) is again multiplied by  2 for YUV?

vrfb_buf_size = image_width * image_height * 2 * 2; // allocate for
YUV format (worst case)

Thanks
Iqbal
