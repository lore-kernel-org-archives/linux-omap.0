From: Ram <vshrirama@gmail.com>
Subject: camera isp driver status?
Date: Thu, 26 Jun 2008 20:09:24 +0530
Message-ID: <8bf247760806260739t36c2df75sc7fe7be74dd034@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:33405 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754899AbYFZOjq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 10:39:46 -0400
Received: by yx-out-2324.google.com with SMTP id 31so25908yxl.1
        for <linux-omap@vger.kernel.org>; Thu, 26 Jun 2008 07:39:42 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,
  What is the current status of the camera isp driver on OMAP3 processor?
  I am using the linux-2.6.22 kernel on linux.omap.com. I am using the
camera isp driver
  that exists on 0.9.8 release. I have also tried 0.9.7 release.

  Has anybody tested it on ISP sensor  (ISP is within the sensor)
connected through
  parallel interface working? that is i am not using the ISP that
exists on OMAP3.

  I am routing all the cam data to Memory through CCDC. Right now i am
  using YUV422 format.

 I do see some  hsync issues. the image appears split at one the end.
 some frames are good. On some frames the image is split at one of the edges.

 I also do notice that the first 5-6 frames are green.
 I do notice that  the data is all jumbled up.
 i notice only green lines in the images captured.


 has anyone faced similar issues?

please do advice.

Regards,
sriram
