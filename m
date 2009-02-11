From: Anuj Aggarwal <anuj.aggarwal@gmail.com>
Subject: ASoC audio not working on OMAP3 EVM
Date: Wed, 11 Feb 2009 21:20:30 +0530
Message-ID: <2ee9e08d0902110750m22c71b43yba2b3efd47c9b7b6@mail.gmail.com>
References: <2ee9e08d0902110743i1502b430s9ef44528f985c70f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:47426 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbZBKPuc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Feb 2009 10:50:32 -0500
Received: by wf-out-1314.google.com with SMTP id 28so282242wfa.4
        for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2009 07:50:30 -0800 (PST)
In-Reply-To: <2ee9e08d0902110743i1502b430s9ef44528f985c70f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP List <linux-omap@vger.kernel.org>

Hi,

I am on commit "Merge current mainline tree into linux-omap tree
(master)" id: de45215. I tried audio in ASoC on OMAP3 EVM but found
two major problems:

a) Songs are being played very slowly, something like audio in slow motion.
b) Capture plays noise even if no audio source is connected for
recording. It is not capturing 'silence' properly.

Has anyone observed the same problems on other platforms as well? Do
we have a fix for them?

Anuj Aggarwal
Texas Instruments
Bangalore, INDIA
