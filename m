From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH] omap3: cm-t35: add mux initialization
Date: Tue, 08 Dec 2009 12:40:08 +0200
Message-ID: <4B1E2D08.1090805@compulab.co.il>
References: <cover.1259481545.git.mike@compulab.co.il> <4B1BCE62.1050005@compulab.co.il> <20091207162209.GV24013@atomide.com> <5A47E75E594F054BAF48C5E4FC4B92AB0309C863C8@dbde02.ent.ti.com> <20091207174446.GY24013@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:48781 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753545AbZLHKkE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Dec 2009 05:40:04 -0500
In-Reply-To: <20091207174446.GY24013@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Tony Lindgren wrote:
> * Gadiyar, Anand <gadiyar@ti.com> [091207 08:35]:
>> Tony Lindgren wrote: 
>>> * Mike Rapoport <mike@compulab.co.il> [091206 07:30]:
>>>> Tony,
>>>> Any chance this can go to 2.6.33?
>>> Sure, I was just waiting to hear back if the OUTPUT_PULLUP is
>>> needed for sure? Or is just OUTPUT enough for musb to work?
>>>
>>> Tony
>>>
>> OUTPUT should work too. The ULPI spec recommends a weak pull-up
>> on STP line, but we needn't really have that. Plain OUTPUT is sufficient.
> 
> OK, thanks for checking that. Mike, what do you prefer to do?

I'll test without the pull and if it's Ok this way I'll update the mux
initialization patch and drop the OUTPUT_PULL{UP,DOWN}.

> I guess in some cases the pull may be needed for a pin
> to change faster if an external pull is not used?
> 
> We could add the OUTPUT_PULL defines, but we should probably
> mark them with comments that they should be rarely needed.
> 
> Regards,
> 
> Tony
> 
> 

-- 
Sincerely yours,
Mike.

