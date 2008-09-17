From: twebb <taliaferro62@gmail.com>
Subject: getting 2.6.25 from git to run on omap35x evm
Date: Wed, 17 Sep 2008 14:36:36 -0400
Message-ID: <dbdb2ea60809171136v5a380989mf57aca6ff1df5aba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:53504 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859AbYIQSgi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2008 14:36:38 -0400
Received: by py-out-1112.google.com with SMTP id p76so2499603pyb.10
        for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2008 11:36:37 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The OMAP35x EVM (from TI/Mistral) runs their SDK 1.0.0 which is based
on linux-2.6.22.18.  I'm trying to get linux-2.6.25 (tag =
v2.6.25-omap1 from linux-omap-2.6.git) running on the 35x EVM but
having difficulties.  The linux-2.6.22.18 including support for OMAP
35x EVM appears quite different from linux-omap-2.6.25 from git in the
OMAP specific areas.  Should linux-omap-2.6.25-v2.6.25-omap1 build and
run without modifications on OMAP 35x EVM?  If so, I should be able to
port SDK 1.0.0 functionality (that perhaps hasn't made it into the
linux-omap git yet) over to newer 2.6.25 kernel as necessary -
correct?  If not, is there another or newer kernel in linux-omap get
that could/should run on 35x EVM, or is another approach suggested?

Thanks.
