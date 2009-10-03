From: michael <michael@panicking.kicks-ass.org>
Subject: ISP OMAP3 camera support ov7690
Date: Sun, 04 Oct 2009 01:13:49 +0200
Message-ID: <4AC7DAAD.2020203@panicking.kicks-ass.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from static-88-194-224-77.ipcom.comunitel.net ([77.224.194.88]:54601
	"EHLO panicking.kicks-ass.org" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752813AbZJCXQK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Oct 2009 19:16:10 -0400
Received: from michael.panicking ([192.168.0.192] ident=michael)
	by panicking.kicks-ass.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <michael@panicking.kicks-ass.org>)
	id 1MuEye-00011F-Q7
	for linux-omap@vger.kernel.org; Sun, 04 Oct 2009 02:29:29 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I'm writing a driver to support the ov7690 camera and I have some question about the meaning of:

- datalane configuration
- phyconfiguration

How can I map this parameter to a camera? Can anyone give me some example?


Michael
