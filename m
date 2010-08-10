From: Michael Jones <michael.jones@matrix-vision.de>
Subject: TVP5146 support on OMAP3EVM?
Date: Tue, 10 Aug 2010 17:46:16 +0200
Message-ID: <4C617448.8030605@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail1.matrix-vision.com ([78.47.19.71]:58107 "EHLO
	mail1.matrix-vision.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932275Ab0HJP5J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 11:57:09 -0400
Received: from mail1.matrix-vision.com (localhost [127.0.0.1])
	by mail1.matrix-vision.com (Postfix) with ESMTP id 3160C7237F
	for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 17:46:21 +0200 (CEST)
Received: from erinome (g2.matrix-vision.com [80.152.136.245])
	by mail1.matrix-vision.com (Postfix) with ESMTPA id ACC7672314
	for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 17:46:20 +0200 (CEST)
Received: from erinome (localhost [127.0.0.1])
	by erinome (Postfix) with ESMTP id CA6426F8A
	for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 17:46:16 +0200 (CEST)
Received: from [192.168.65.46] (host65-46.intern.matrix-vision.de [192.168.65.46])
	by erinome (Postfix) with ESMTPA id A87226F8A
	for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 17:46:16 +0200 (CEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I'm evaluating OMAP using the OMAP3EVM eval board.  I originally had a 2.6.32 kernel 'linux-omap-psp-2.6.32' (http://arago-project.org/git/people/?p=sriram/ti-psp-omap.git;a=summary).  I have since moved to the latest 'devel' branch on omap3camera (2.6.35).  There, as on the current linux-omap, there seems to no longer be support for the TVP5146 decoder *on the OMAP3EVM*.  In my 2.6.32 branch, there was a file "board-omap3evm-camera.c" which defined the TVP on the OMAP3EVM.

Has support for the TVP5146 decoder on the OMAP3EVM been dropped, or am I overlooking something?

Does anyone know of a demo for the OMAP3EVM for capturing images to test the OMAP?  The TVP seems ideal because I don't need a daughter card with an image sensor, just video input.  Perhaps I need to fall back on the 2.6.29 kernel that came with the board with PSP-02.01.03.11.

thanks,
Michael

MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Hans-Joachim Reich
