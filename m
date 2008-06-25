From: "mohammed shareef" <mdshareef@gmail.com>
Subject: standalone osk
Date: Wed, 25 Jun 2008 06:16:59 +0530
Message-ID: <a1d91fa0806241746m60d493dcs94d49ba3ad375d02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:21417 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbYFYArA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2008 20:47:00 -0400
Received: by rv-out-0506.google.com with SMTP id k40so7912358rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 24 Jun 2008 17:47:00 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omap <linux-omap@vger.kernel.org>

Dear all,

i want to make my OSK-omap5912 a standalone system. so i am trying to
flash the filessystem on to its flash. so far it was on a network. i
want an environment variable to be defined at startup and then run an
executable. i figured out that it goes to /etc/inittab and then
executes the script name given there. But i dont know how exactly to
do that. could some one please tell me how to do that? thank you.
regards,
Shareef
