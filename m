From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: SR1: VDD autocomp is not active
Date: Thu, 03 Dec 2009 05:22:43 +0200
Message-ID: <4B172F03.2090401@gmail.com>
References: <48239d390912010353l44f8e6d9w7ff963c7fb41ecf3@mail.gmail.com>	 <B85A65D85D7EB246BE421B3FB0FBB59301DE879FB1@dbde02.ent.ti.com>	 <48239d390912010904r25b7246bx529b5132c65ef46a@mail.gmail.com>	 <B85A65D85D7EB246BE421B3FB0FBB59301DD5AA0DF@dbde02.ent.ti.com>	 <48239d390912011223yf2ffa2bhe43a6b699b9f6655@mail.gmail.com>	 <B85A65D85D7EB246BE421B3FB0FBB59301DE87A5E9@dbde02.ent.ti.com>	 <48239d390912020404w1c333178o2315119d7e53a2dc@mail.gmail.com>	 <B85A65D85D7EB246BE421B3FB0FBB59301DE87A635@dbde02.ent.ti.com>	 <48239d390912020513y57f9b863r750b521180ab85b7@mail.gmail.com> <48239d390912020533u10128a0akdb6d5ae35221a1ba@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB59301DE87A6EE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:36138 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089AbZLCDan (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 22:30:43 -0500
Received: by ewy2 with SMTP id 2so9501ewy.28
        for <linux-omap@vger.kernel.org>; Wed, 02 Dec 2009 19:30:49 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE87A6EE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Sergey Lapin <slapinid@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Premi, Sanjeev said the following on 12/02/2009 04:23 PM:
>> -----Original Message-----
>> From: Sergey Lapin [mailto:slapinid@gmail.com] 
>> Sent: Wednesday, December 02, 2009 7:04 PM
>> To: Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: SR1: VDD autocomp is not active
>>
>>     
>>>> [sp] The code will allow you to do so; but without right values
>>>>     kernel execution can go haywire.
>>>>         
Actually the entire silicon can go haywire due to bad voltages. :( yep
kernel can go crazy as a result..

>>> Is it possible somehow to identify right silicon revision 
>>>       
>> before ordering?
>>     
>>> I mean by part number or something?
>>>       
>> Sorry for my ignorance, I've found answer on first question (answer is
>> to read errata properly).
>>
>>     
>>> Also, is there some safe numbers somebody knows about, or is there
>>> some way of generating them?
>>>       
>> I still persist with this question, though.
>>     
>
> [sp] These numbers are based on silicon characterization process.
>      There is no other way to generate them. The numbers can change
>      between silicon lots.
>
>   
Actually can change even between silicons themselves. This is part of
EFUSE values which we write on to each of the silicon. If the chip does
not have SR NVALUES EFUSED, two options:
a) Get a new chip which has SR enabled (or a platform such as zoom2 with
3430 ES3.1 silicon)
b) Disable smartreflex :(

Regards,
Nishanth Menon

PS: NOT recommended: you could choose to play around with my original
patch for SR http://marc.info/?l=linux-omap&m=125623250803526&w=2 esp
looking at the script involved. but I would not recommend to use it on a
production system.
