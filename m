From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: git omapzoom suggestions
Date: Thu, 7 Aug 2008 17:37:29 +0300
Message-ID: <94a0d4530808070737p24f40c23t7381fb902f9d59a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:32169 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbYHGOh3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 10:37:29 -0400
Received: by rv-out-0506.google.com with SMTP id k40so508876rvb.1
        for <linux-omap@vger.kernel.org>; Thu, 07 Aug 2008 07:37:29 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I'm trying to pull from git.omapzoom and nothing happens, it seems you
are not running git-update-server-info (info/refs is outdated[1]). You
need to chmod +x .git/hooks/post-update.

Also, you don't have a .git/cloneurl file, so the URL is not displayed
by gitweb. It would also be good to support native git instead of http
(much more efficient).

Best regards.

[1] http://git.omapzoom.org/repo/omapkernel/info/refs

-- 
Felipe Contreras
