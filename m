From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: DSP/IOMMU needs 128-byte alignment from user-space buffers?
Date: Wed, 17 Dec 2008 15:26:24 +0200
Message-ID: <94a0d4530812170526x51aa7959r52c7583661c5a9da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:41558 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbYLQN01 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Dec 2008 08:26:27 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1606126fgg.17
        for <linux-omap@vger.kernel.org>; Wed, 17 Dec 2008 05:26:24 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Hi,

I received information from TI saying that user-space buffers need to
be 128-byte aligned for the DSP to work properly.

Is this true or is it some kind of limitation on their MMU code that
might be solved by Hiroshi's iommu?

This impacts quite drastically user-space applications like GStreamer
since a memory copy would be required to achieve that 128-byte
alignment.

They also claim that adding 128-byte padding at the beginning and at
the end achieves the same purpose.

-- 
Felipe Contreras
