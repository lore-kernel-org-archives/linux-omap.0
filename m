From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: mfd: twl-core: Return directly after a failed platform_device_alloc()
 in add_numbered_child()
Date: Mon, 16 May 2016 10:07:39 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1605161006350.2060@localhost6.localdomain6>
References: <566ABCD9.1060404@users.sourceforge.net> <5682D228.7070902@users.sourceforge.net> <20160111082922.GB14104@x1> <05b7db2a-437a-60ac-d289-71d2150e7f5f@users.sourceforge.net> <3c168185-ec2d-f1f7-fe70-8a230b884ed2@users.sourceforge.net>
 <alpine.DEB.2.02.1605160845050.2060@localhost6.localdomain6> <9f94708f-6433-5227-78ee-52fbfb30fdaf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <9f94708f-6433-5227-78ee-52fbfb30fdaf@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 16 May 2016, SF Markus Elfring wrote:

> >> * Change an error message.
> > 
> > Why?  Is dev_err needed?
> 
> I interpreted Lee's response in this way.
> https://lkml.org/lkml/2016/1/11/104

OK.  He didn't ask for the message to be changed though.  It's a bit 
unfortunate that it now takes up multiple lines.  And I believe it also 
prints redundant information.  Perhaps he will have some further thoughts 
on the matter.

julia
