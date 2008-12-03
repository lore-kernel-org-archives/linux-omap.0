From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] Add OMAP2 camera driver
Date: Wed, 3 Dec 2008 12:18:29 +0530
Message-ID: <5d5443650812022248p28f42ce4n513dceb18adadeab@mail.gmail.com>
References: <200812011357.09474.hverkuil@xs4all.nl>
	 <19F8576C6E063C45BE387C64729E739403E90E6D27@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.237]:52603 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbYLCGsb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Dec 2008 01:48:31 -0500
Received: by qb-out-0506.google.com with SMTP id f11so3562548qba.17
        for <linux-omap@vger.kernel.org>; Tue, 02 Dec 2008 22:48:30 -0800 (PST)
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E90E6D27@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Sakari Ailus <sakari.ailus@nokia.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>

Hi Vaibhav,

>
> [Hiremath, Vaibhav] How about making a separate directory for OMAP, which will contain OMAP1/2/3 specific drivers?
>

I really don't want omap directory for OMAP1 and OMAP2 atleast. Even
in my next patches for OMAP1 camera controller I am going to  remove
"omap/" directory existing on linux-omap git history. For omap1 it is
just two files camera_core.c and omap16xxcam.c, so no need of
directory here. Even going further I am going to merge camera_core and
omap16xxcam into one file, as I don't see code for any other omap1
platform like omap15xxcam.

I don't know about OMAP3 ISP code, some one from TI should refresh
those patches.


-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
