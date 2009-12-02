From: Sergey Lapin <slapinid@gmail.com>
Subject: Re: SR1: VDD autocomp is not active
Date: Wed, 2 Dec 2009 17:06:37 +0300
Message-ID: <48239d390912020606u7dd359d1k80dc92bf38be198d@mail.gmail.com>
References: <48239d390912010353l44f8e6d9w7ff963c7fb41ecf3@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DE879FB1@dbde02.ent.ti.com>
	 <48239d390912010904r25b7246bx529b5132c65ef46a@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DD5AA0DF@dbde02.ent.ti.com>
	 <48239d390912011223yf2ffa2bhe43a6b699b9f6655@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DE87A5E9@dbde02.ent.ti.com>
	 <48239d390912020404w1c333178o2315119d7e53a2dc@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DE87A635@dbde02.ent.ti.com>
	 <48239d390912020513y57f9b863r750b521180ab85b7@mail.gmail.com>
	 <48239d390912020533u10128a0akdb6d5ae35221a1ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:34181 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbZLBOGc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 09:06:32 -0500
Received: by ey-out-2122.google.com with SMTP id d26so69023eyd.19
        for <linux-omap@vger.kernel.org>; Wed, 02 Dec 2009 06:06:38 -0800 (PST)
In-Reply-To: <48239d390912020533u10128a0akdb6d5ae35221a1ba@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Dec 2, 2009 at 4:33 PM, Sergey Lapin <slapinid@gmail.com> wrote:
>>>
>>> [sp] The code will allow you to do so; but without right values
>>>     kernel execution can go haywire.
>>
>> Is it possible somehow to identify right silicon revision before ordering?
>> I mean by part number or something?
> Sorry for my ignorance, I've found answer on first question (answer is
> to read errata properly).
>
>>
>> Also, is there some safe numbers somebody knows about, or is there
>> some way of generating them?
> I still persist with this question, though.
>
Resume: kernel seems to hang wit SRF disabled and PM enabled.
As I have advantage of saving lots of power with PM.
disabling SRF seems not to be an option. So
it either have to be left as is or numbers should be provided
(possibly for even better tasty power saving!)

Thanks a lot for your help,
S.
