From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: ALSA sound on beagleboard
Date: Wed, 22 Oct 2008 19:40:29 +0300
Message-ID: <94a0d4530810220940i4987a6cav1c37224590b461f4@mail.gmail.com>
References: <E1KsVml-0007JI-Eq@amazonia.comcast.net>
	 <200810212215.27517.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:33823 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbYJVQka (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2008 12:40:30 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3038752rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 22 Oct 2008 09:40:29 -0700 (PDT)
In-Reply-To: <200810212215.27517.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: rick@efn.org, linux-omap@vger.kernel.org

On Wed, Oct 22, 2008 at 8:15 AM, David Brownell <david-b@pacbell.net> wrote:
> On Tuesday 21 October 2008, you wrote:
>>   Please give me a clue on where to start.
>
> This patch came on linux-omap a while back.  I'm not sure
> why it isn't merged yet.  The clock framework crapped out
> on me because of a lockdep problem ... maybe it'll work OK
> if you don't enable lockdep.

Hmm, I don't know about that lockdep problem, but I don't know
anything about the driver anyway. I just copy-pasted the overo stuff.

I've reposted the patch, maybe it will get merged and the issues will
be resolved eventually.

-- 
Felipe Contreras
