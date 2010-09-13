From: venki kaps <venkiece2005@gmail.com>
Subject: OMAP3 DSP MMU fault + off mode issue
Date: Tue, 14 Sep 2010 04:58:56 +0900
Message-ID: <AANLkTikHM+o_FCgnVzGhs8UtQ_geXFzKNQpGSZiEN7sx__7772.36856888539$1284407982$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54942 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364Ab0IMT65 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Sep 2010 15:58:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omar.ramirez@ti.com, h-kanigeri2@ti.com, ameya.palande@nokia.com, fernando.lugo@ti.com, x0hebbar@ti.com, ernesto@ti.com, felipe.contreras@gmail.com, s-anna@ti.com, grgupta@ti.com, iva

Dear all,

I have been facing an issue with OMAP3 PM with DSP MMU Fault (Kernel 2.6.32).

The issue is describing as below mentioned way,
        1). The Device is getting DSP MMU Fault when playing MP4 video clip.

The system is not hitting off mode in the below scenario,
        2). System boot ->play mp4 clip ->DSP MMU Fault -> allow off
mode -----------> Never hits off mode

But surprisingly the system is hitting off mode in the below scenario,
       3). System boot ->allow off mode ->play mp4 clip ->DSP MMU
Fault -> allow off mode -----------> perfectly works


 - Could you please describe the root cause about the above issues 1 & 2?
 - How could solve the above issues?

Best Regards,
Venkii
