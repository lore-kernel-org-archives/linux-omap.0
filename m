From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/3] staging: tidspbridge: bugfixes
Date: Fri, 5 Nov 2010 19:54:58 +0200
Message-ID: <AANLkTinLw7AvLszyOoThAtmUrnBcX9EGjbT3aQzMWsJe@mail.gmail.com>
References: <1288970148-22191-1-git-send-email-ionut.nicu@mindbit.ro>
	<20101105154328.GA27991@kroah.com>
	<1288972825.9931.7.camel@atlantis.mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34505 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab0KERy7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 13:54:59 -0400
Received: by bwz11 with SMTP id 11so2904581bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 10:54:58 -0700 (PDT)
In-Reply-To: <1288972825.9931.7.camel@atlantis.mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@mindbit.ro>
Cc: Greg KH <greg@kroah.com>, Ionut Nicu <ionut.nicu@gmail.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Nov 5, 2010 at 6:00 PM, Ionut Nicu <ionut.nicu@mindbit.ro> wrote:
> On Fri, 2010-11-05 at 08:43 -0700, Greg KH wrote:
>> On Fri, Nov 05, 2010 at 05:15:45PM +0200, Ionut Nicu wrote:
>> > Changes since v1:
>> >
>> > * Split the mgr_enum_node_info patch into two patches:
>> > one that fixes the issue and one that reorganizes the
>> > code.
>>
>> Are these for the .37 or .38 kernel?
>
> They're bug fixes, so I think they should get into .37. It's up to you
> to decide.

Other than patch #2, I agree it would be better on .37.

-- 
Felipe Contreras
