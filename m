From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PULL] http://www.linuxtv.org/hg/~hverkuil/v4l-dvb
Date: Tue, 2 Dec 2008 11:58:31 +0530
Message-ID: <5d5443650812012228u5aad36a2jc3e9e68cd61c27e3@mail.gmail.com>
References: <200812011451.06156.hverkuil@xs4all.nl>
	 <5d5443650812011014q55a96540gc8a4b97be951f2fd@mail.gmail.com>
	 <20081201202209.5cea1f4b@pedra.chehab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.244]:33020 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbYLBG2c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2008 01:28:32 -0500
Received: by ag-out-0708.google.com with SMTP id 31so2059673agc.10
        for <linux-omap@vger.kernel.org>; Mon, 01 Dec 2008 22:28:31 -0800 (PST)
In-Reply-To: <20081201202209.5cea1f4b@pedra.chehab.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>, v4l <video4linux-list@redhat.com>, Sakari Ailus <sakari.ailus@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org

Hi Mauro,

>
> This is one of the lack of the features on mercurial. It doesn't have a meta
> tag for committer. On mercurial, the -hg user and the author should be the same
> person.
>
> Since we want to identify the patch origin (e.g. whose v4l/dvb maintainer got
> the patch), we use the internal "user" meta-tag as the committer, and an extra
> tag, at the patch description for the author (From:).
>
> When creating the -git patch, the "From:" tag is replaced, by script, for
> "Author:", I add my SOB there, and, I add myself as the -git committer (on git
> we have both meta-tags).

Isn't it good time to move v4l2-dvb tree to GIT? I am not aware of any
hg-to-git repo. converter, but I can check with hg and git community.
It could be difficult at first, but I am very confident that there are
many GIT users here than mercurial, and yes your v4l-dvb maintenance
process might change due move from GIT, but atleast you will not have
to internal user meta-data per patch.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
