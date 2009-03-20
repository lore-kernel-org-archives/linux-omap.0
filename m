From: Ashwin Bihari <abihari@gmail.com>
Subject: Re: mmc0 detection timing at kernel startup, linux-omap-2.6.27-omap1
Date: Fri, 20 Mar 2009 09:53:51 -0400
Message-ID: <1f11a5490903200653y4c53d047j9f54f6eec0aef64d@mail.gmail.com>
References: <dbdb2ea60903200606y51d3fba0ia5c116a3c452c21a@mail.gmail.com>
	 <1f11a5490903200634y57f91639r3aad815aa2ce5e92@mail.gmail.com>
	 <C8CB7D0E-5690-4368-B2BB-60B09B37575D@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:52826 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbZCTNxy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 09:53:54 -0400
Received: by yx-out-2324.google.com with SMTP id 31so985472yxl.1
        for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 06:53:52 -0700 (PDT)
In-Reply-To: <C8CB7D0E-5690-4368-B2BB-60B09B37575D@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: twebb <taliaferro62@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Fri, Mar 20, 2009 at 9:44 AM, Koen Kooi <k.kooi@student.utwente.nl> wrote:
>
> Op 20 mrt 2009, om 14:34 heeft Ashwin Bihari het volgende geschreven:
>
>> You need to add the Kernel option "rootdelay=1" to basically delay the
>> Kernel for a moment while attempting to using the SDcard as the RFS
>> mount point.
>
> Since kernel 2.6.24 you can use 'rootwait', which will wait till it becomes
> available so you don't need to keep futzing the value for different SD
> cards.
>
> regards,
>
> Koen
>

Koen,

I wasn't aware of that option, it definitely beats futzing with wait delays!

-- Ashwin
