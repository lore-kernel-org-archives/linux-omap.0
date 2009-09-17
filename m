From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Bad block on N810
Date: Thu, 17 Sep 2009 10:20:35 -0400
Message-ID: <4AB245B3.10909@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32302 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbZIQOV3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Sep 2009 10:21:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>

Hi folks,

I'm having a curious problem with my N810: my device turn off (turn off, not restart) always a few seconds after just initialized.

Well, after taking a look in dbug mode, I saw the the following problems:

[   36.921875] JFFS2 notice: (1200) check_node_data: wrong data CRC in data node at 0x0b651edc: read 0x25e088e1, calculated 0x76861b05.
...
[   40.578125] JFFS2 warning: (1293) jffs2_sum_write_sumnode: Not enough space for summary, padsize = -965

I already reflash the FIASCO image, but this error persists. So it looks that the fs has some problem (bad block) on internal memory card. mkfs could solve the problem, but, as I mentioned above, only a few seconds after starting, the device shutdown  :( 

Any hints?

BR,

Carlos.

-- 
Carlos Eduardo Aguiar
Software Developer
Mobile Linux Software
Nokia Institute of Technology - INdT
E-mail: carlos.aguiar@indt.org.br

