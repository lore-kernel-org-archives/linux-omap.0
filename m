From: Eino-Ville Talvala <talvala@stanford.edu>
Subject: Re: FYI - Frankencamera is open source, runs on Linux
Date: Sun, 06 Sep 2009 00:51:23 -0700
Message-ID: <4AA369FB.30609@stanford.edu>
References: <61339.192.168.10.89.1247226725.squirrel@dbdmail.itg.ti.com> <48097.192.168.10.89.1247232736.squirrel@dbdmail.itg.ti.com> <60361.192.168.10.89.1247482584.squirrel@dbdmail.itg.ti.com> <20090810162734.GH1938@atomide.com> <ce9ab5790908102245r28224bf5nfa2a1b22267767fe@mail.gmail.com> <4A810DE4.7030202@gmail.com> <ce9ab5790908102329k73f66b5bgcdd8ac52d6631116@mail.gmail.com> <ce9ab5790909050306m180e7c22g7bbdea7f7053d159@mail.gmail.com> <FCCFB4CDC6E5564B9182F639FC35608702F9B8A593@dbde02.ent.ti.com> <99B9BAB5-9CD3-4BB8-8CF7-C528C04BB107@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-roam1.Stanford.EDU ([171.67.219.88]:36510 "EHLO
	smtp-roam.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752872AbZIFH6Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Sep 2009 03:58:25 -0400
Received: from smtp-roam.stanford.edu (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 9E4EC37D48
	for <linux-omap@vger.kernel.org>; Sun,  6 Sep 2009 00:51:56 -0700 (PDT)
Received: from [192.168.1.102] (adsl-75-35-111-168.dsl.pltn13.sbcglobal.net [75.35.111.168])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: talvala)
	by smtp-roam.stanford.edu (Postfix) with ESMTPSA id 7FAF537D4C
	for <linux-omap@vger.kernel.org>; Sun,  6 Sep 2009 00:51:53 -0700 (PDT)
In-Reply-To: <99B9BAB5-9CD3-4BB8-8CF7-C528C04BB107@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


>> Have you seen this post on N95 camera using linux by Stanford Team -
>> http://news.cnet.com/8301-17938_105-10345557-1.html
>>
>> Is this running on OMAP?--
>
>
> The board in the youtube video looks a lot like the omap3evm, so I 
> guess it's safe to say it's omap3 based.
>
> regards,
>
> Koen
I'm one of the graduate students at Stanford working on this project.

Yes, we're using an OMAP3 EVM (needed the camera interface pins) 
connected to a small custom daughtercard that interfaces to an Elphel 
10338 camera tile, with an Aptina MT9P031 on it.  Plus a bunch of other 
off-the-shelf hardware, but the OMAP3 is at the heart of it.

Eino-Ville (Eddy) Talvala
Graduate Research Assistant
Stanford University
