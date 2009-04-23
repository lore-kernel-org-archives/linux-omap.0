From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: Problems while designing TPS65023 regulator driver
Date: Thu, 23 Apr 2009 19:00:06 +0530
Message-ID: <5d5443650904230630v454c2c7ft526b020731278010@mail.gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FAA91D06@dbde02.ent.ti.com>
	 <20090226140450.GB8595@sirena.org.uk>
	 <5A47E75E594F054BAF48C5E4FC4B92AB02FB102A76@dbde02.ent.ti.com>
	 <20090403085335.GA3759@sirena.org.uk>
	 <20090404000531.GE8840@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f118.google.com ([209.85.221.118]:61365 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbZDWNaH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Apr 2009 09:30:07 -0400
Received: by qyk16 with SMTP id 16so1082216qyk.33
        for <linux-omap@vger.kernel.org>; Thu, 23 Apr 2009 06:30:06 -0700 (PDT)
In-Reply-To: <20090404000531.GE8840@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: Mark Brown <broonie@sirena.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi Anuj,

On Sat, Apr 4, 2009 at 5:35 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Mark Brown <broonie@sirena.org.uk> [090403 01:53]:
>> On Fri, Apr 03, 2009 at 01:33:58PM +0530, Aggarwal, Anuj wrote:
>>
>> > I could not find the commit in linux-OMAP git where the init data is
>> > passed as a parameter to the regulator_register(). I am dependent
>> > on this commit for my TPS65023 regulator driver and could not push
>> > my patch without the commit being in l-o.
>>
>> > Any idea when this would be available in l-o?
>>
>> I can't speak for the OMAP tree but the patch should appear in
>> 2.6.30-rc1 so presumably it'll get merged into OMAP some time after that
>> is released.
>
> Sounds good to me.

Any updates on tps65023 regulator driver? Could you please submit the
WIP patches to the list?

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
