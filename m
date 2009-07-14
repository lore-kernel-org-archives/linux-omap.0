From: Eino-Ville Talvala <talvala@stanford.edu>
Subject: bitsperlong.h missing in asm-arm?
Date: Tue, 14 Jul 2009 11:38:31 -0700
Message-ID: <4A5CD0A7.5030608@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.Stanford.EDU ([171.67.219.81]:41655 "EHLO
	smtp1.stanford.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755590AbZGNSie (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jul 2009 14:38:34 -0400
Received: from smtp1.stanford.edu (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 7132E178AFF
	for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2009 11:38:34 -0700 (PDT)
Received: from [172.27.76.160] (blur.Stanford.EDU [172.27.76.160])
	by smtp1.stanford.edu (Postfix) with ESMTP id 51AEA178836
	for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2009 11:38:32 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi,

I'm not at all familiar with the way the asm-* include directories are 
handled, but with the current linux-omap tree, I'm getting a user-space 
compilation error with the CodeSourcery 2009q1 release:

In file included from 
/CodeSourcery/arm-gcc-2009q1/bin/../arm-none-linux-gnueabi/libc/usr/include/asm/types.h:
linux-omap-2.6/include/asm-generic/int-ll64.h:11:29: error: 
asm/bitsperlong.h: No such file or directory

It doesn't look like just a CodeSourcery issue, since the missing 
reference is actually in asm-generic/int-ll64.h.

Am I doing something incorrect, or is something missing in 
include/asm-arm  ?

Thanks,

Eddy Talvala
Computer Graphics Lab
Stanford University


