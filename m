From: xl6@rice.edu
Subject: OMAP's typical latency in waking from deep-sleep state?
Date: Fri, 11 Dec 2009 08:10:31 -0600
Message-ID: <20091211081031.21095vjt1ior9p8g@webmail.rice.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mh1.mail.rice.edu ([128.42.201.20]:57769 "EHLO
	mh1.mail.rice.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874AbZLKOKZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 09:10:25 -0500
Received: from mh1.mail.rice.edu (localhost.localdomain [127.0.0.1])
	by mh1.mail.rice.edu (Postfix) with ESMTP id 6B71BCC20E
	for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 08:10:32 -0600 (CST)
Received: from mh1.mail.rice.edu ([127.0.0.1])
	by mh1.mail.rice.edu (mh1.mail.rice.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fTudYrgaHlh3 for <linux-omap@vger.kernel.org>;
	Fri, 11 Dec 2009 08:10:32 -0600 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: xl6)
	by mh1.mail.rice.edu (Postfix) with ESMTPSA id 2E833CC205
	for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 08:10:32 -0600 (CST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

Can someone tell me OMAP's typical latency to wake up from deep-sleep  
state? For example, the time taken by OMAP2 to wake up from the  
SoC-retention state.

I only need the right magnitude. Is it several cycles, several us, or  
several ms? Really have no idea.

Thanks,

-Felix


